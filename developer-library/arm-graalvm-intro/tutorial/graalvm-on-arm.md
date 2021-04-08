# GraalVM on OCI Arm A1

This tutorial describes how to get started with GraalVM on OCI Arm A1 compute platform. You can use GraalVM to improve the performance of your existing applications and build lightweight polyglot applications for the cloud. It’s an ideal companion for the OCI OCI Arm A1 compute shapes, which provide linear scalability and an unbeatable price-performance ratio.

## Deploying your workloads on OCI Arm A1 compute platform

The OCI Arm A1 compute platform based on Ampere Altra CPUs represent a generational shift for enterprises and application developers that are building workloads that can scale from edge devices to cloud data centers. The unique design of this  platform delivers consistent and predictable performance as there are no resource contention within a compute core and offers more isolation and security. This new class of compute shapes on Oracle Cloud Infrastructure  provide an unmatched platform that combines power of the Altra CPUs with the security, scalability and eco-system of services on OCI.

## What is GraalVM ?

GraalVM is a high-performance runtime for applications written in Java, JavaScript, LLVM-based languages such as C and C++, and other dynamic languages. It significantly improves application performance and efficiency, so it can help you run your existing applications more efficiently on cloud platforms. 

GraalVM also builds native executable binaries—native images—for existing JVM-based applications. The resulting native image contains the whole program in machine-code form for immediate execution and avoids the startup and memory footprint of the JVM itself. This capability makes GraalVM ideal for building cloud native applications, and several microservice frameworks for JVM languages include this capability today.

## Start using GraalVM on OCI 

OCI offers Oracle GraalVM Enterprise Edition for free to its customers. GraalVM Enterprise support is included in the Oracle Cloud subscription. The combination of high-performance Arm-based compute shapes and GraalVM Enterprise on OCI provides a compelling platform for both existing and new enterprise applications.

To install GraalVM on OCI, run the following command:
 
```
sudo yum install graalvm21-ee-11
```

After it’s installed, GraalVM is available in the `/usr/lib64/graalvm` directory.

## Running existing Java applications on GraalVM 

GraalVM includes a JDK, and by default it replaces the top-tier Java JIT compiler with the GraalVM compiler. The new and innovative GraalVM compiler can improve the performance of your existing JVM language applications. 

```
java -version

java version "11.0.10" 2021-01-19 LTS
Java(TM) SE Runtime Environment GraalVM EE 21.0.0.2 (build 11.0.10+8-LTS-jvmci-21.0-b06)
Java HotSpot(TM) 64-Bit Server VM GraalVM EE 21.0.0.2 (build 11.0.10+8-LTS-jvmci-21.0-b06, mixed mode, sharing)
```

As an example of an existing Java application, we can run the [Spring PetClinic](https://projects.spring.io/spring-petclinic/) sample application, which is built with Spring Boot. 

1. Clone the repository to get started. 

```
 git clone https://github.com/spring-projects/spring-petclinic.git
```

2. To run the sample application without modifications, open the port on which the application will listen (8080 by default). 
```
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp 
sudo firewall-cmd --reload
```

3. Build and run the application.

```
 cd spring-petclinic
 ./mvnw spring-boot:run 
```
The first time you run the application, Maven downloads the dependencies. It could take several minutes before the downloads are complete.
You should see output similar to the following example:

```
2021-03-05 18:11:28.447  INFO 3704 --- [           main] o.s.s.petclinic.PetClinicApplication     : No active profile set, falling back to default profiles: default
2021-03-05 18:11:31.531  INFO 3704 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFAULT mode.
2021-03-05 18:11:31.697  INFO 3704 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 144 ms. Found 4 JPA repository interfaces.
2021-03-05 18:11:33.436  INFO 3704 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2021-03-05 18:11:33.720  INFO 3704 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2021-03-05 18:11:33.721  INFO 3704 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 5133 ms
2021-03-05 18:11:34.797  INFO 3704 --- [           main] o.hibernate.jpa.internal.util.LogHelper  : HHH000204: Processing PersistenceUnitInfo [name: default]
2021-03-05 18:11:34.902  INFO 3704 --- [           main] org.hibernate.Version                    : HHH000412: Hibernate ORM core version 5.4.28.Final
2021-03-05 18:11:34.983  INFO 3704 --- [           main] o.hibernate.annotations.common.Version   : HCANN000001: Hibernate Commons Annotations {5.1.2.Final}
2021-03-05 18:11:35.266  INFO 3704 --- [           main] org.hibernate.dialect.Dialect            : HHH000400: Using dialect: org.hibernate.dialect.MySQLDialect
2021-03-05 18:11:36.838  INFO 3704 --- [           main] o.h.tuple.entity.EntityMetamodel         : HHH000157: Lazy property fetching available for: org.springframework.samples.petclinic.owner.Owner
2021-03-05 18:11:37.094  INFO 3704 --- [           main] o.h.e.t.j.p.i.JtaPlatformInitiator       : HHH000490: Using JtaPlatform implementation: [org.hibernate.engine.transaction.jta.platform.internal.NoJtaPlatform]
2021-03-05 18:11:37.112  INFO 3704 --- [           main] j.LocalContainerEntityManagerFactoryBean : Initialized JPA EntityManagerFactory for persistence unit 'default'
2021-03-05 18:11:38.696  INFO 3704 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2021-03-05 18:11:40.604  INFO 3704 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 13 endpoint(s) beneath base path '/actuator'
2021-03-05 18:11:40.758  INFO 3704 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2021-03-05 18:11:40.783  INFO 3704 --- [           main] o.s.s.petclinic.PetClinicApplication     : Started PetClinicApplication in 13.846 seconds (JVM running for 14.906)
```
The application starts in about 14 seconds. As you can see, GraalVM contains a full JDK and can be a drop-in replacement for your existing JVM.  

To learn more about the optimization flags available to GraalVM, see the documentation [here](https://docs.oracle.com/en/graalvm/enterprise/20/docs/reference-manual/jvm/Options/) 

## Building blazing fast Native Images

GraalVM can create self-contained executable binaries from your Java applications, which can run incredibly fast. The GraalVM ahead-of-time compilation of your Java code processes all application classes, dependencies, and runtime libraries, and removes the overhead and footprint of a JVM itself. However, some advanced language features, such as runtime proxies and reflection, require additional configuration. Many microservice Java frameworks, such as  [Micronaut](https://micronaut.io), [Helidon](https://helidon.io) and [Quarkus](https://quarkus.io) support building native images immediately. 

1. To start, install the native image tooling. These packages are available in the yum repositories for OCI but are not installed by default.

```
sudo yum install  graalvm21-ee-11-native-image
```

For this tutorial, we’re using Micronaut to build the application because Micronaut uses a dependency injection and aspect-oriented runtime that doesn’t use reflection.

2. Clone the repository and get started:

```
git clone https://github.com/micronaut-guides/micronaut-creating-first-graal-app.git
cd micronaut-creating-first-graal-app/complete
```

3. Run the application to see how long it takes for it to start on a JVM:

```
./gradlew run
```

You should see output similar to the following example:

```
> Task :complete:run
 __  __ _                                  _
|  \/  (_) ___ _ __ ___  _ __   __ _ _   _| |_
| |\/| | |/ __| '__/ _ \| '_ \ / _` | | | | __|
| |  | | | (__| | | (_) | | | | (_| | |_| | |_
|_|  |_|_|\___|_|  \___/|_| |_|\__,_|\__,_|\__|
  Micronaut (v2.3.4)

09:59:34.504 [main] INFO  io.micronaut.runtime.Micronaut - Startup completed in 755ms. Server Running: http://localhost:8080
```

The application starts in 755 milliseconds, which is impressive. 

4. Now, build a native image for the application and compare the startup time:

```
./gradlew nativeImage
```
It takes about 5 minutes to build the native image. After it’s built, the native image is placed in the  `build/native-image/application` directory. 

5. Run the native image.

```
./build/native-image/application
```

You should see output similar to the following example:

```
 __  __ _                                  _
|  \/  (_) ___ _ __ ___  _ __   __ _ _   _| |_
| |\/| | |/ __| '__/ _ \| '_ \ / _` | | | | __|
| |  | | | (__| | | (_) | | | | (_| | |_| | |_
|_|  |_|_|\___|_|  \___/|_| |_|\__,_|\__,_|\__|
  Micronaut (v2.3.4)

09:59:18.558 [main] INFO  io.micronaut.runtime.Micronaut - Startup completed in 18ms. Server Running: http://localhost:8080
```

The naive image is more than 40 times faster, starting in just 18 milliseconds. 

The key takeaway here is that regardless of how simple or complex your application is, GraalVM native images can give you an immediate performance boost. Combined with the latest Arm-based compute shapes and GraalVM Enterprise, Oracle Cloud Infrastructure provides an unmatched platform for building and evolving your enterprise workloads.

