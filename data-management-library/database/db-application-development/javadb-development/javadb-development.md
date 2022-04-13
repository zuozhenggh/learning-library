# Developing Java Applications for Oracle Database

## Introduction

Oracle provides enterprise application developers with an end-to-end Java solution for creating, deploying, and managing Java applications. The total solution consists of client-side and server-side programmatic interfaces, tools to support Java development, and a JVM integrated with Oracle Database. All these products are fully compatible with Java standards. JDBC is a database access protocol that enables you to connect to a database and run SQL statements and queries to the database. The core Java class libraries provide the JDBC APIs: java.sql and javax.sql. However, JDBC  enables vendors to supply drivers that offer the necessary specialization for a particular database. 

Estimated Time: 20 minutes
 
### Objectives
 
In this lab, you will: 

* Write Java code to access Oracle Database 
* Run the code

### Prerequisites 
This lab assumes you have:

* JDK 8 and SQL Developer has been installed 
* Database user has been created
* Access to Oracle Database 19c instance
* A valid SSH key pair
   
## Task 1: Set Environment variables to access Oracle Database

1. Set environment variables and verify the java version and classpath

      ```
      <copy>
            orcl:oracle@lldb:~/javadb]$ echo $CLASSPATH 
      </copy>
      ``` 

      ```
      <copy> 
             /home/oracle/javadb:/home/oracle/Downloads/sqldeveloper/jdbc/lib/ojdbc8.jar
      </copy>
      ``` 

      ```
      <copy>
            orcl:oracle@lldb:~/javadb]$ java -version
            java version "1.8.0_321"
            Java(TM) SE Runtime Environment (build 1.8.0_321-b07)
            Java HotSpot(TM) 64-Bit Server VM (build 25.321-b07, mixed mode)
      </copy>
      ``` 

      ```
      <copy>
            orcl:oracle@lldb:~/javadb]$ echo $JAVA_HOME
            /home/oracle/Downloads/jdk1.8.0_321
      </copy>
      ``` 

## Task 2: Write and run hello world *Java* program

1. Write Hello.java to print Hello World message

      ```
      <copy>
            class Hello {
            public static void main(String args[]) {
                  System.out.println("Hello World!");
            } 
      </copy>
      ``` 

      ```
      <copy>
            orcl:oracle@lldb:~/javadb]$ javac Hello.java
      </copy>
      ``` 

      ```
      <copy>
            orcl:oracle@lldb:~/javadb]$ java Hello
      </copy>
      ``` 

      ```
      <copy>
            orcl:oracle@lldb:~/javadb]$ Hello World
      </copy>
      ``` 

## Task 3: Write and run *Java* program to access Oracle 19c Database

1. In the vi editor or Visual studio code write departments.java in /home/oracle/javadb folder, replace hostname ,service name, database username and password as per your installation and configuration

      ```
      <copy>
            import java.sql.*;  
            class departments {

                  public static void main(String args[]){  

                  try {  
                        //step1 load the driver class  
                        Class.forName("oracle.jdbc.driver.OracleDriver");  
                        
                        //step2 create  the connection object  
                        //jdbc:oracle:thin:@//HOSTNAME:PORT/SERVICENAME

                        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@//lldb.livelabs.oraclevcn.com:1521/pdb1.livelabs.oraclevcn.com","james","welcome1");  
                        
                        //step3 create the statement object  
                        Statement stmt=con.createStatement();  
                        
                        //step4 execute query  
                        ResultSet rs=stmt.executeQuery("select * from HR.departments");  
                        while(rs.next())  
                        System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));  
                        
                        //step5 close the connection object  
                        con.close();  
                  
                  }
                  catch(Exception e){ 
                        System.out.println(e);}  
                  
                  }  
            }  
      </copy>
      ``` 
 
   You successfully made it to the end this lab. You may now  *proceed to the next lab* .  

## Learn More

* [Developing Python Applications for Oracle Autonomous Database](https://www.oracle.com/database/technologies/appdev/python/quickstartpythononprem.html#linux-tab) 
* [How do I start with Node.js](https://nodejs.org/en/docs/guides/getting-started-guide/) 
* [Node Oracle DB examples](https://github.com/oracle/node-oracledb) 
* [Node API Examples](https://oracle.github.io/node-oracledb/doc/api.html#getstarted)   
* [Oracle NodeDB](https://oracle.github.io/node-oracledb/)
 
## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** - Kevin Lazarz, Senior Principal Product Manager, Database 
* **Last Updated By/Date** -  Madhusudhan Rao, Mar 2022 
