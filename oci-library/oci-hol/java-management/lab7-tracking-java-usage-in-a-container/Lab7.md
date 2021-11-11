# Tracking Java Usage in a Container

## Introduction
This lab will guide you in creating a Docker image on your compute instance and how to enable Java Management Service to track Java usage in a container.

Estimated Time: 30 minutes

### Objectives
In this lab, you will:

- Install Docker on your compute instance
- Create a simple Java application
- Create a Docker image with Oracle JDK on your compute instance
- Configure Java Usage Tracker Location
- Verify Configuration

### Prerequisites

- An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
- A compute instance with the resources configured in Lab 1 to Lab 4 (Management Agent, Fleet, Compartments, SSH key pair login). The compute instance should also have **Oracle JDK 8** installed.

## Task 1: Install Docker on your compute instance
The following steps will describe installation of Docker on a compute instance running Oracle Linux 7, which was covered in Lab 2.

1. Perform an SSH login into your OCI compute instance.

2. Run the following command and allow the installation. The update command will take a few minutes.
    ```
    sudo yum update
    ```
    ```
    sudo yum-config-manager --enable *addons
    ```
3. Continue by running the following commands.
    ```
    sudo yum update
    ```
4. Install Docker and enable it by running.
    ```
    sudo yum install docker-engine
    ```
    ```
    sudo systemctl enable docker
    ```
    ```
    sudo systemctl start docker
    ```
5. You can check the version of your Docker installation by running the following
    ```
    sudo docker version
    ```
6. You can verify that Docker is correctly installed by running this.
    ```
    sudo docker run hello-world
    ```
    You should be able to see the following output if your installation is correct.
    Sample output:
    ```
    Hello from Docker!
    This message shows that your installation appears to be working correctly.

    To generate this message, Docker took the following steps:
    1. The Docker client contacted the Docker daemon.
    2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
    3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
    4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.

    To try something more ambitious, you can run an Ubuntu container with:
    $ docker run -it ubuntu bash

    Share images, automate workflows, and more with a free Docker ID:
    https://hub.docker.com/

    For more examples and ideas, visit:
    https://docs.docker.com/get-started/
    ```

You now have successfully installed Docker on your compute instance.

## Task 2: Create a simple Java application
This task will guide you on how to create a simple Java application that can be used in the Docker image that will be built later. If you already have a Java application packaged in a jar format, you may skip ahead to Task 3.

1. Perform an SSH login into your OCI compute instance.

2. Create a Java application and package it into a jar file by following the below steps.

  - If you are not already in the home directory of your compute instance, navigate there by running this.
    ```
    cd ~
    ```
  
  - For the purposes of this lab, we will create a simple Java application in your home directory which prints odd numbers. Create a new directory and enter it with your terminal.
    
    ```
    mkdir OddNumbers
    ```
    ```
    cd OddNumbers
    ```
    
  - Create a simple application that prints odd numbers by entering these commands.
    
    ```
    sudo nano OddNumbers.java
    ```
    ```
    import java.lang.*;
    
    public class OddNumbers {
        public static void main(String[] args) throws Exception {
            System.out.println("This is my second program in java");
            int number=15;  
            System.out.println("List of odd numbers from 1 to "+number+": ");  
            for (int i=1; i<=number; i++) {  
                //logic to check if the number is odd or not  
                //if i%2 is not equal to zero, the number is odd  
                if (i%2!=0) {
                    Thread.sleep(1000);
                    System.out.println(i);
                }
            }
        }//End of main
    }//End of OddNumbers Class
    ```
    
  - Compile the Java code using this command. 
    
    ```
    javac OddNumbers.java
    ```
    Another file called OddNumbers.class should appear after the command.
    &nbsp;
    
  - Run the following command to create a jar file.
    
    ```
    jar -cfe OddNumbers.jar OddNumbers OddNumbers.class
    ```
    
  - Test the jar file to see if the output and entry point is correct. Sample output shown below. For more information on jar file creation, see this [article](https://docs.oracle.com/    javase/tutorial/deployment/jar/build.html).
    
    ```
    java -jar OddNumbers.jar
    ```
    
    Sample Output:
    
    ```
    This is my second program in java
    List of odd numbers from 1 to 15: 
    1
    3
    5
    7
    9
    11
    13
    15
    ```

You have now created a simple Java application.

## Task 3: Create a Docker image with Oracle JDK
This section will provide guidance on creating a Docker image running a Oracle JDK within the compute instance. If you already have a Docker image with Oracle JDK on it, you may pull your image into the compute instance, skip this task and proceed with Task 4.

**Note:** Currently, only containers with Oracle JDKs are able to be detected by the Java Usage Tracker.

1. Ensure that you are already in your compute instance. If not, perform an SSH login.

2. Install Git in your compute instance.

    ```
    cd ~
    ```
    
    ```
    sudo yum install git
    ```

3. Clone the Oracle Docker Images repository from GitHub into your compute instance and copy the Dockerfile to the OddNumbers folder by running the following.

    ```
    git clone https://github.com/oracle/docker-images.git
    ```
    
    ```
    cp docker-images/OracleJava/17/Dockerfile ~/OddNumbers
    ```

  - Ensure that the Dockerfile was successfully copied to the OddNumbers folder created in Task 2. You should see the Dockerfile present after the `ls` command inside the OddNumbers folder.

    ```
    cd OddNumbers
    ```
    
    ```
    ls
    ```

  ![image of dockerfile listed](/../images/dockerfile-check.png)

<!--  -->
4. Edit the Dockerfile to include our jar file in the build by running these commands.

    ```
    sudo nano Dockerfile
    ```
- The inbuilt Nano text editor is now open. Scroll down to near the end of the Dockerfile and insert the following lines.

    ```
    ARG JAR_FILE=target/*.jar
    COPY OddNumbers.jar /
    ENTRYPOINT ["java","-jar","/OddNumbers.jar"]
    ```
    
    ![image of dockerfile in nano text editor](/../images/dockerfile.png)

  - When done, save and exit the Nano text editor by pressing **CTRL+x** then **y** and then **ENTER**.
<!--  -->
5. In the OddNumbers folder, run the following command for Docker to build the image. This step may take a few minutes.

    ```
    sudo docker build -t oddnumbers .
    ```

6. Verify that the image was created by running this.

    ```
    sudo docker images
    ```
You should see your new image "oddnumbers" in the list.
&nbsp;

7. Test the new docker image by running this command.
    ```
    sudo docker run oddnumbers
    ```
The same output of odd numbers should appear.
&nbsp;


## Task 4: Configure Java Usage Tracker Location
You should now have a compute instance with Docker installed and a Docker image using Oracle JDK.

1. To use JMS in a container, you must ensure that Java Usage Tracker records are written to `/var/log/java/usagetracker.log` on the container host (your compute instance). On **your compute instance**, run the following command.
    ```
    sudo docker run -d -v /var/log/java/:/var/log/java/ -v /etc/oracle/java/:/etc/oracle/java/:ro --name odd-numbers oddnumbers:latest
    ```

2. View more information about the running container by running this command.
    ```
    sudo docker inspect odd-numbers
    ```

  Check for the "Mounts" section, which should not be empty.
    ![image of inspect container](/../images/bind-mounts.png)

## Task 5: Verify Configuration

1. You may wish to check the log files for your Java application. Start by running this command to display the log file content. 

    ```
    cat /var/log/java/usagetracker.log
    ```
  You should be able to see the jar file (OddNumbers.jar) and the Java version (Java 17) used in your Docker container in the log file output. 
    ![image of java logs](/../images/java-logs.png)

  > **Note:** You should only use this configuration with trusted containers or where you do not require isolation between the host and the container, or between containers.

2. You may now check your Fleet in OCI console to see if your Docker container was detected. You should be able to see the OddNumbers.jar under **Applications**.
  ![image of fleet details page showing jar file in container](/../images/fleets-details-docker.png)

## Want to Learn More?
You may also find more Oracle resources for your containers at the Oracle Github repository [here](https://github.com/oracle/docker-images).


## Acknowledgements
* **Author** - Alvin Lam, Java Management Service
* **Last Updated By/Date** - Alvin Lam, November 2021