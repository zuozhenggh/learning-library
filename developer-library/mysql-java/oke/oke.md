# Run a Spring Boot program in Kubernetes 

## Introduction

In this lab, we put the Java program in a container and run it in OKE.

Estimated Time: 20 minutes

### About Java
XXXXX

### Objectives

In this lab, you will:
* Create a Spring Boot program
* Create a container and put the java program in it
* Upload the container to the Kubernetes Registry
* Run the Java container in OKE

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* Followed the previous lab by creating a OKE cluster and a Mysql database

## Task 1: Create a Java program

We will download the source code and examine how it works

1. Open the cloud console

2. Clone the git repository. And let's look what this simple Java program contains:

```
### Code
Open the OCI cloud console and clone this repository:
```
git clone https://github.com/mgueury/java-mysql
cd java-mysql
cd 2_java
cat Mysql.java

----------------------------------------------------------
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class Mysql {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection conn =  DriverManager.getConnection(args[0]);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, name FROM person");
            while (rs.next()) {
              System.out.println( rs.getString(1) + " , " + rs.getString(2));
            }
            stmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println( e );
            e.printStackTrace();
        } 
    }
----------------------------------------------------------
```

## Task 2: Create a container and put the java program in it

1. Still in the same directory. Build the container:

```
docker build -t java-mysql .
```

After the build, you will have a container called: java-mysql:latest

  ![Image alt text](images/sample1.png)
  

## Task 3: Upload the container to the Kubernetes Registry

Still in Oracle Cloud console. We will need to login to the container Registry: Oracle Cloud Infrastructure Registry (OCIR).
Let's find this info.

1. In the OCI menu, go to Developer Service / Container Registry

2. Take note of the <namespace> (for example, `fr03kzmuvhtf` shown in the image below).

	![namespace](images/22-create-repo.png " ")

  XXXXX If you use a compartment for the lab. Be sure to set the root compartment before the next step.

3. Click **Create Repository**, specify the following details for your new repository, and click **Create Repository**.
    * Repository Name: `<tenancy name>/java-mysql`
    * Access: `Public`
    ![create repository](images/create-repository.png " ")

4. Check the URL: [Availability by Region|https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm#regional-availability] URL and find your region (datacenter). Take a note of it: <region-name>

For example: for Frankfurt: eu-frankfurt-1

5. In Oracle Cloud console, on the top right. Click Profile. Take a note of your username: <username>

  ![Image alt text](images/sample1.png)

6. Generating an Auth Token to Enable Login to Oracle Cloud Infrastructure Registry

* Still in your user profile. Go to the section "Auth Tokens"
* Click Generate Token.
* Give a name
* Take a note of your token: <token>

It will be a string of 15/20 characters looking like this: " ab1>3cde{F:G#]HI5<4 "

8. Back to the cloud console. 

* Log in OCIR

```
docker login <region-prefix>.ocir.io -u <namespace/username>
Ex 
- (OCI user) docker login eu-frankfurt-1.ocir.io -u fr03kzmuvhtf/firstname.lastname@company.com 
- (IDCS user) docker login eu-frankfurt-1.ocir.io -u fr03kzmuvhtf/oracleidentitycloudservice/firstname.lastname@company.com
```


9. Go in your java-mysql/2_java directory. Build the container:

```
cd $HOME/lab/2_java
docker build -t java-mysql .
```

After the build, you will have a container called: java-mysql:latest

  ![Image alt text](images/sample1.png)
  

9. Upload the container in the registry. First we need to tag it 

```
docker tag java-mysql:latest <region-name>.ocir.io/<tenancy>/java-mysql:latest
docker push <region-name>.ocir.io/<tenancy>/marc/java-mysql:latest

ex: docker tag java-mysql:latest eu-frankfurt-1.ocir.io/fr03kzmuvhtf/java-mysql:latest
docker push eu-frankfurt-1.ocir.io/fr03kzmuvhtf/java-mysql:latest
```
10. Go back to the OCI Menu. Developer Service / Container Registry

Check the registry and the Container should be there.

## Task 4: Run the Java container in OKE

1. To run the container in the 

xxxx



## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
