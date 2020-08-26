# Use Helidon Service

## Introduction

In this lab we will run a Helidon microservice and connect the Micronaut application to it

### Objectives

In this lab you will:

* Run a pre-built Helidon MP application as a native image locally
* Update Micronaut controller to invoke the service
* Run the Micronaut application locally to verify setup

## **STEP 1**: Run Helidon MP microservice

The Helidon MP application is already built and available as a native image
(ahead of time compilation into native code using GraalVM `native-image`).

Source code of the application is available at:
 
https://github.com/tomas-langer/helidon-hol-example.git

Download the native image binary (this is needed for deployment to cloud)

TODO: define link

Run the native image (if you are using a Linux environment):

`./helidon-mp-service`

_non Linux environment:_
  - get the application from github: `git clone https://github.com/tomas-langer/helidon-hol-example.git`
  - build the application (from application directory): `mvn package`
  - run the application: `java -jar target/helidon-mp-service.jar`

This will open the application on port `8081`

We can verify this application works by exercising the following endpoints:

- `curl -i http://localhost:8081/vaccinated/Dino` - this is our "business" endpoint and should return `true`
- `curl -i http://localhost:8080/health` - returns health status (MicroProfile health format)
- `curl -H 'Accept: application/json' http://localhost:8081/metrics` - returns metrics (MicroProfile metrics format)
- `curl -i http://localhost:8081/openapi` - returns OpenAPI yaml service description (MicroProfile OpenAPI specification)

## **STEP 2**: Update Micronaut code

We will create a new endpoint for Pet health. This endpoint will use a service that either connects to a remote
microservice, or if that fails, uses a local fallback.

1. Services needed

Create a package `example.atp.services`.

Create new classes in this package:

`PetHealthOperations` interface to define the contract:
```java
package example.atp.services;

import java.util.concurrent.CompletableFuture;

public interface PetHealthOperations {
    CompletableFuture<PetHealth> getHealth(String name);

    enum PetHealth {
        UNKNOWN,
        GOOD,
        REQUIRES_VACCINATION
    }
}
```

`PetHealthFallback` used to fallback to in case the target service is not available
```java
package example.atp.services;

import io.micronaut.retry.annotation.Fallback;

import javax.inject.Singleton;
import java.util.concurrent.CompletableFuture;

@Fallback
@Singleton
public class PetHealthFallback implements PetHealthOperations {
    @Override
    public CompletableFuture<PetHealth> getHealth(String name) {
        return CompletableFuture.completedFuture(PetHealthOperations.PetHealth.UNKNOWN);
    }
}
```

And finally the `PetHealthService` used to invoke the target service:
```java
package example.atp.services;

import java.util.concurrent.CompletableFuture;

import javax.inject.Singleton;

import io.micronaut.http.annotation.Get;
import io.micronaut.http.client.annotation.Client;
import io.micronaut.retry.annotation.Recoverable;

@Singleton
@Recoverable(api = PetHealthOperations.class)
public class PetHealthService implements PetHealthOperations {
    private final PetHealthClient petHealthClient;

    PetHealthService(PetHealthClient petHealthClient) {
        this.petHealthClient = petHealthClient;
    }

    @Override
    public CompletableFuture<PetHealth> getHealth(String name) {
        if (petHealthClient.isVaccinated(name)) {
            return CompletableFuture.completedFuture(PetHealth.GOOD);
        }
        return CompletableFuture.completedFuture(PetHealth.REQUIRES_VACCINATION);
    }

    @Client(value = "pet-health", path ="/vaccinated")
    public interface PetHealthClient {
        @Get("/{name}")
        boolean isVaccinated(String name);
    }
}
```

2. Update the configuration to define service endpoint

In `resources/application.yml`, update the `micronaut` section and add the following:
```yaml
micronaut:
  http.services:
    pet-health:
      urls: "http://localhost:8081"
```

3. Update the controller

Update the `PetController`:

```java
// a new field
private final PetHealthOperations petHealthOperations;

//updated constructor
PetController(PetRepository petRepository, PetHealthOperations petHealthOperations) {
    this.petRepository = petRepository;
    this.petHealthOperations = petHealthOperations;
}

// new method
@Get("/{name}/health")
CompletableFuture<PetHealthOperations.PetHealth> getHealth(String name) {
    return petHealthOperations.getHealth(name);
}
```


## **STEP 3**: Run the code

Now when the Micronaut application is rebuilt and restarted,
we can test the new endpoint.
 
For the sake of simplicity, the `Dino` and `Hoppy` pets are vaccinated,
 and the poor `Baby Puss` is not.
 
You can now access http://localhost:8080/pets/name/health to find out if a pet is healthy:

```bash
curl -i http://localhost:8080/pets/Dino/health
HTTP/1.1 200 OK
Date: Wed, 26 Aug 2020 13:36:58 GMT
Content-Type: application/json
content-length: 6
connection: keep-alive

"GOOD"%
```

We can try another pet (we need to escape the space):
```bash
curl -i http://localhost:8080/pets/Baby%20Puss/health
HTTP/1.1 200 OK
Date: Wed, 26 Aug 2020 13:37:53 GMT
Content-Type: application/json
content-length: 22
connection: keep-alive

"REQUIRES_VACCINATION"%
```

And we can also see what happens when the target service is down.
Please shut down the Helidon service (just press Ctrl+C in the console or kill the process)

Now let's retry the call and see that fallback works:
```bash
curl -i http://localhost:8080/pets/Dino/health
HTTP/1.1 200 OK
Date: Wed, 26 Aug 2020 13:39:28 GMT
Content-Type: application/json
content-length: 9
connection: keep-alive

"UNKNOWN"%
```