# Build a Micronaut Application

## Introduction

In this lab you will build a Micronaut application locally that connects to Oracle Autonomous Database.

Estimated Lab Time: &lt;40&gt; minutes

### Objectives

In this lab you will:

* Create Micronaut Data entities that map Oracle Database tables
* Define Micronaut Data repositories to implement queries
* Expose Micronaut Controllers as REST endpoints
* Write tests for the Micronaut application
* Run the Micronaut application locally

## **STEP 1**: Create Micronaut Data entities that map Oracle Database tables

The first step is to define entity classes that can be used to read data from database tables.

Using your favourite IDE create a new class under `src/main/java/example/atp/domain` that looks like the following:

```java
package example.atp.domain;

import io.micronaut.core.annotation.Creator;
import io.micronaut.data.annotation.GeneratedValue;
import io.micronaut.data.annotation.Id;
import io.micronaut.data.annotation.MappedEntity;


@MappedEntity
public class Owner {

    @Id
    @GeneratedValue
    private Long id;
    private final String name;
    private int age;

    @Creator
    public Owner(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
```

The `@MappedEntity` annotation is used to indicate that the entity is mapped to a database table. By default this will be a table using the same name as the class (in this case `owner`).

The columns of the table are represented by each Java property. In the above case an `id` column will be used to represent the primary key and by using `@GeneratedValue` this sets up the mapping to assume the use of an `identity` column in Autonmous Database.

The `@Creator` annotation is used on the constructor that will be used to instantiate the mapped entity and is also used to express required columns. In this case the `name` column is required whilst the `age` column is not and can be set independently using the `setAge` setter. 

Now define another entity to model a `pet` table under `src/main/java/example/atp/domain`:

```java
package example.atp.domain;

import io.micronaut.core.annotation.Creator;
import io.micronaut.data.annotation.AutoPopulated;
import io.micronaut.data.annotation.Id;
import io.micronaut.data.annotation.MappedEntity;
import io.micronaut.data.annotation.Relation;

import javax.annotation.Nullable;
import java.util.UUID;

@MappedEntity
public class Pet {

    @Id
    @AutoPopulated
    private UUID id;
    private String name;
    @Relation(Relation.Kind.MANY_TO_ONE)
    private Owner owner;
    private PetType type = PetType.DOG;

    @Creator
    public Pet(String name, @Nullable Owner owner) {
        this.name = name;
        this.owner = owner;
    }

    public Owner getOwner() {
        return owner;
    }

    public String getName() {
        return name;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public PetType getType() {
        return type;
    }

    public void setType(PetType type) {
        this.type = type;
    }

    public enum PetType {
        DOG,
        CAT
    }
}
```

With that done it is time move onto defining repository interfaces to implement queries.

## **STEP 2**: Define Micronaut Data repositories to implement queries

Micronaut Data supports the notion of defining interfaces that automatically implement SQL queries for you at compilation time using the data repository pattern.

To take advantage of this feature of Micronaut Data define a new repository interface that extends from `CrudRepository` and is annotated with `@JdbcRepository` using the `ORACLE` dialect:

```java
package example.atp.repositories;

import example.atp.domain.Owner;
import io.micronaut.data.jdbc.annotation.JdbcRepository;
import io.micronaut.data.model.query.builder.sql.Dialect;
import io.micronaut.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

@JdbcRepository(dialect = Dialect.ORACLE)
public interface OwnerRepository extends CrudRepository<Owner, Long> {

    @Override
    List<Owner> findAll();

    Optional<Owner> findByName(String name);
}
```

The `CrudRepository` interface takes 2 generic argument types. The first is the type of the entity (in this case `Owner`) and the second is the type if the ID (in this case `Long`).

The `CrudRepository` interface defines methods that allow you to create, read, update and delete entities from the database with the appropriate SQL inserts, selects, updates and deletes computed for you at compilation time. For more information see the javadoc for [CrudRepository](https://micronaut-projects.github.io/micronaut-data/latest/api/io/micronaut/data/repository/CrudRepository.html).

You can define methods within the interface that perform JDBC queries and automatically handle all the intricate details for you such as defining correct transaction semantics (read-only transactions for queries), executing the query and mapping the result set to the `Owner` entity class you defined earlier.

The `findByName` method defined above will produce a query such as `SELECT ID, NAME, AGE FROM OWNER WHERE NAME = ?` automatically at compilation time.

Fore more information on query methods and the types of queries you can define see the [documentation for query methods](https://micronaut-projects.github.io/micronaut-data/latest/guide/index.html#querying) in the Micronaut Data documentation.

With the `OwnerRepository` in place let's create another repository and this time using a data transfer object (DTO) to perform an optimized query.

First create the DTO under `src/main/java/example/atp/domain`:

```java
package example.atp.domain;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class NameDTO {
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

A DTO is a simple POJO that allows you to select only the columns a particular query needs, thus producing a more optimized query. Define another repository called `PetRepository` for the `Pet` entity that uses the DTO:

```java
package example.atp.repositories;

import example.atp.domain.NameDTO;
import example.atp.domain.Pet;
import io.micronaut.data.annotation.Join;
import io.micronaut.data.jdbc.annotation.JdbcRepository;
import io.micronaut.data.model.query.builder.sql.Dialect;
import io.micronaut.data.repository.PageableRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@JdbcRepository(dialect = Dialect.ORACLE)
public interface PetRepository extends PageableRepository<Pet, UUID> {

    List<NameDTO> list();

    @Join("owner")
    Optional<Pet> findByName(String name);
}
```

Take note of the `list` method that returns the DTO. This method will again be implemented for you at compilation time, but this time instead of retrieving all the columns of the `Pet` column it will only rereive the `name` column and any other columns you may define.

The `findByName` method is also interesting as it uses another important feature of Micronaut Data which is the `@Join` annotation which allows you to specify join paths so that you retrieve exactly the data you need via database joins resulting in much more efficient queries.

With the data repositories in place let's move on exposing REST endpoints.

## **STEP 3**: Expose Micronaut Controllers as REST endpoints

REST endpoints in Micronaut are easy to write and defined as controllers (as per the MVC pattern).

Define a new `OwnerController` class in `src/main/java/example/atp/controllers` like the following:

```java
package example.atp.controllers;

import java.util.List;
import java.util.Optional;

import javax.validation.constraints.NotBlank;

import example.atp.domain.Owner;
import example.atp.repositories.OwnerRepository;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;

@Controller("/owners")
@ExecuteOn(TaskExecutors.IO)
class OwnerController {

    private final OwnerRepository ownerRepository;

    OwnerController(OwnerRepository ownerRepository) {
        this.ownerRepository = ownerRepository;
    }

    @Get("/")
    List<Owner> all() {
        return ownerRepository.findAll();
    }

    @Get("/{name}")
    Optional<Owner> byName(@NotBlank String name) {
        return ownerRepository.findByName(name);
    }
}
```

A controller class is defined with the `@Controller` annotation which you can use to define the root URI that the controller maps to (in this case `/owners`).

Notice too the `@ExecuteOn` annotation which is used to tell Micronaut that the controller performs I/O communication with a database and therefore operations should run on the I/O thread pool.

The `OwnerController` class uses Micronaut dependency injection to obtain a reference to the `OwnerRepository` repository interface you defined earlier and use to to implement two endpoints:

* `/` - The root endpoint lists all the owners
* `/{name}` - The second endpoint uses a URI template to allow looking up an owner by name. The value of the URI variable `{name}` is provided as a parameter to the `byName` method.

Next define another REST endpoint called `PetController` under `src/main/java/example/atp/controllers`:

```java
package example.atp.controllers;

import java.util.List;
import java.util.Optional;

import example.atp.domain.NameDTO;
import example.atp.domain.Pet;
import example.atp.repositories.PetRepository;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;

@ExecuteOn(TaskExecutors.IO)
@Controller("/pets")
class PetController {

    private final PetRepository petRepository;

    PetController(PetRepository petRepository) {
        this.petRepository = petRepository;
    }

    @Get("/")
    List<NameDTO> all() {
        return petRepository.list();
    }

    @Get("/{name}")
    Optional<Pet> byName(String name) {
        return petRepository.findByName(name);
    }
}
```

This time the `PetRepository` is injected to expose a list of pets and pets by name.

## **STEP 4**: Write Integration Tests for the Micronaut Application

TODO

## **STEP 5**: Run the Micronaut application locally

TODO

## Learn More

* [Micronaut Documentation](https://micronaut.io/documentation.html)
* [Micronaut Data Documentation](https://micronaut-projects.github.io/micronaut-data/latest/guide/index.html)
