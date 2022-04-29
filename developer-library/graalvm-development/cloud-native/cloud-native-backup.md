# Title of the Lab

## Introduction

*Describe the lab in one or two sentences, for example:* この演習では、MicronautおよびSpring Bootを使用してCloud Native アプリケーションを開発します。

Estimated Lab Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is necessary to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Micronautアプリケーションを開発

1. Micronautのテンプレートをダウンロードします。

    ```
    <copy>curl --location --request GET 'https://launch.micronaut.io/create/default/com.example.graal?lang=JAVA&build=MAVEN&test=JUNIT&javaVersion=JDK_11&features=graalvm' --output graal-mn.zip</copy>
    ```

    ```
    <copy>unzip graal-mn.zip -d ./</copy>
    ```
    
    ```
    <copy>cd graal</copy>
    ```

2. エディターでJavaソースファイルを作成します。

    ```
    <copy>nano src/main/java/com/example/HelloController.java</copy>
    ```

    以下のソースを貼り付けます。
    ```
    <copy>
    package com.example;

    import io.micronaut.http.MediaType;
    import io.micronaut.http.annotation.Controller;
    import io.micronaut.http.annotation.Get;
    import io.micronaut.http.annotation.Produces;

    @Controller("/hello")
    public class HelloController {
        @Get
        @Produces(MediaType.TEXT_PLAIN)
        public String index() {
            return "Hello World\n";
        }
    }
    </copy>
    ```


3. ソールファイルをビルドします。

    ```
    <copy>cd graal</copy>
    ```

    ```
    <copy>./mvnw clean -DskipTests package</copy>
    ```

4. Micronautアプリケーションを起動します。

    ```
    <copy>cd graal</copy>
    ```

    ```
    <copy>java -jar target/graal-0.1.jar</copy>
    ```

   > **Note:** もし8080ポートが既に使用されている場合、以下のコマンドでポートを使用しているプロセスを調べ、プロセスを停止してください。
   ```
   <copy>lsof -i -P | grep 8080</copy>
   ```
   ```
   <copy>kill -9 プロセスID</copy>
   ```
5. Micronautサービスの起動時間を確認します。この例では824msです。

	![Image alt text](/../images/micronaut-start.png)

   CTRLCでMicrounautアプリケーションを停止します。

6. Native Imageをビルドします。

    ```
    <copy>cd graal</copy>
    ```

    ```
    <copy>./mvnw package -Dpackaging=native-image</copy>
    ```

7. MicronautアプリケーションをNativeモードで起動します。

    ```
    <copy>cd graal</copy>
    ```

    ```
    <copy>./target/graal</copy>
    ```

8. Micronautサービスの起動時間を確認します。この例では15msです。

	![Image alt text](/../images/micronaut-start1.png)


   CTRLCでMicrounautアプリケーションを停止します。

  | Column 1 | JITモード | Nativeモード |
  | --- | --- | --- |
  | 1 | 842ms | 15ms  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

## Task 2: Spring Bootアプリケーションの開発

1. Spring Bootのサンプルソースコードをダウンロードします。

    ```
    <copy>git clone https://github.com/spring-guides/gs-rest-service</copy>
    ```
    ```
    <copy>cd gs-rest-service/complete</copy>
    ```


2. HTTPリクエストをハンドリングするResource Controller。src/main/java/com/example/restservice/GreetingController.java

    ```
    package com.example.restservice;

    import java.util.concurrent.atomic.AtomicLong;

    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.RequestParam;
    import org.springframework.web.bind.annotation.RestController;

    @RestController
    public class GreetingController {

      private static final String template = "Hello, %s!";
      private final AtomicLong counter = new AtomicLong();

      @GetMapping("/greeting")
      public Greeting greeting(@RequestParam(value = "name", defaultValue = "World") String name) {
        return new Greeting(counter.incrementAndGet(), String.format(template, name));
      }
    }
    ```
   
3. Plain Java Objectクラス。src/main/java/com/example/restservice/Greeting.java

    ```
    package com.example.restservice;

    public class Greeting {

      private final long id;
      private final String content;

      public Greeting(long id, String content) {
        this.id = id;
        this.content = content;
      }

      public long getId() {
        return id;
      }

      public String getContent() {
        return content;
      }
    }
    ```
      
4. Mavenを使い実行可能なJARファイルにビルドし、実行します。
     
    ```
    <copy>cd gs-rest-service/complete</copy>
    ```
      
    ```
    <copy>./mvnw clean package</copy>
    ```
        
    正常ビルド完了後、JARファイルを実行します。Web Serviceの起動時間を確認します。
    ```
    <copy>java -jar target/rest-service-complete-0.0.1-SNAPSHOT.jar</copy>
    ```
       
    この例では、Web Serviceの起動時間は約1.5秒。
    ```
    [opc@instance-20220407-graalvm complete]$ java -jar target/rest-service-complete-0.0.1-SNAPSHOT.jar
    2022-04-14 07:53:38.731  INFO 641235 --- [           main] o.s.nativex.NativeListener               : AOT mode disabled

      .   ____          _            __ _ _
    /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
    ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
    \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
      '  |____| .__|_| |_|_| |_\__, | / / / /
    =========|_|==============|___/=/_/_/_/
    :: Spring Boot ::       (v0.0.1-SNAPSHOT)

    ...............
    ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 827 ms
    2022-04-14 07:53:39.987  INFO 641235 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
    2022-04-14 07:53:39.997  INFO 641235 --- [           main] c.e.restservice.RestServiceApplication   : Started RestServiceApplication in 1.551 seconds (JVM running for 2.007)
    ```
       
    別ターミナルを立ち上げ、以下のコマンドを実行し、HTTPリクエストからレスポンスが正常にリターンされることを確認します。
        
    ```      
    $ curl http://localhost:8080/greeting
    {"id":1,"content":"Hello, World!"}   
    ```
       
5. アプリケーションをnative image化するため、pom.xmlを編集します。以下の内容をpom.xmlに追加します。
    
   (1)Springアプリケーションをnative imageとして実行するため、Spring Frameworkより提供のSpring Native依存ライブラリを指定します。バージョンは0.11.2に指定します。

    ```
    <copy>
    <dependency>
        <groupId>org.springframework.experimental</groupId>
        <artifactId>spring-native</artifactId>
        <version>0.11.2</version>
    </dependency>
    </copy>
    ```
      
   (2) SpringアプリケーションをAOTコンパイラでビルドするため、Spring Frameworkより提供のspring-aot-maven-pluginを指定します。以下のplugin内容をbuildタグに追加します。
       
    ```      
    <copy>
    <plugin>
        <groupId>org.springframework.experimental</groupId>
        <artifactId>spring-aot-maven-plugin</artifactId>
        <version>0.11.2</version>
        <executions>
            <execution>
                <id>test-generate</id>
                <goals>
                    <goal>test-generate</goal>
                </goals>
            </execution>
            <execution>
                <id>generate</id>
                <goals>
                    <goal>generate</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
    </copy>
    ```
    (3) Springアプリケーションをnative imageとしてビルドするため、GraalVMより提供のnative-maven-plugin(0.9.11)をprofileタグの中で指定します。
    ```      
    <profiles>
        <profile>
            <id>native</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.graalvm.buildtools</groupId>
                        <artifactId>native-maven-plugin</artifactId>
                        <version>0.9.11</version>
                        <executions>
                            <execution>
                                <id>test-native</id>
                                <goals>
                                    <goal>test</goal>
                                </goals>
                                <phase>test</phase>
                            </execution>
                            <execution>
                                <id>build-native</id>
                                <goals>
                                    <goal>build</goal>
                                </goals>
                                <phase>package</phase>
                            </execution>
                        </executions>
                        <configuration>
                            <!-- ... -->
                        </configuration>
                    </plugin>
                    <!-- Avoid a clash between Spring Boot repackaging and native-maven-plugin -->
                    <plugin>
                        <groupId>org.springframework.boot</groupId>
                        <artifactId>spring-boot-maven-plugin</artifactId>
                        <configuration>
                            <classifier>exec</classifier>
                        </configuration>
                    </plugin>
                </plugins>
            </build>
        </profile>
    </profiles>
    ```

    (4)各依存ライブラリおよびプラグインのリポジトリーを追加します。
        
    ```      
    <copy>
    <repositories>
      <repository>
          <id>spring-release</id>
          <name>Spring release</name>
          <url>https://repo.spring.io/release</url>
		  </repository>
	  </repositories>
    </copy>   
    ```

    ```      
    <copy>
    <pluginRepositories>
      <pluginRepository>
        <id>spring-release</id>
        <name>Spring release</name>
        <url>https://repo.spring.io/release</url>
      </pluginRepository>
	  </pluginRepositories>
    </copy>   
    ```
        
    (5)以下はpom.xmlの内容です。必要に応じて既存pom.xmlをバックアップして、新規pom.xmlを作成して下記内容を貼り付けます。
    ```
    <copy>
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
            <modelVersion>4.0.0</modelVersion>
            <parent>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-parent</artifactId>
                    <version>2.6.5</version>
                    <relativePath/> <!-- lookup parent from repository -->
            </parent>
            <groupId>com.example</groupId>
            <artifactId>rest-service-complete</artifactId>
            <version>0.0.1-SNAPSHOT</version>
            <name>rest-service-complete</name>
            <description>Demo project for Spring Boot</description>
            <properties>
                    <java.version>11</java.version>
            </properties>
            <dependencies>
                    <dependency>
                            <groupId>org.springframework.boot</groupId>
                            <artifactId>spring-boot-starter-web</artifactId>
                    </dependency>
                    <dependency>
                            <groupId>org.springframework.boot</groupId>
                            <artifactId>spring-boot-starter-test</artifactId>
                            <scope>test</scope>
                    </dependency>
                    <dependency>
                            <groupId>org.springframework.experimental</groupId>
                            <artifactId>spring-native</artifactId>
                            <version>0.11.2</version>
                    </dependency>
            </dependencies>
            <build>
                <plugins>
                    <plugin>
                            <groupId>org.springframework.boot</groupId>
                            <artifactId>spring-boot-maven-plugin</artifactId>
                    </plugin>
                    <plugin>
                        <groupId>org.springframework.experimental</groupId>
                        <artifactId>spring-aot-maven-plugin</artifactId>
                        <version>0.11.2</version>
                        <executions>
                            <execution>
                                <id>test-generate</id>
                                <goals>
                                    <goal>test-generate</goal>
                                </goals>
                            </execution>
                            <execution>
                                <id>generate</id>
                                <goals>
                                    <goal>generate</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
            <profiles>
                <profile>
                    <id>native</id>
                    <build>
                        <plugins>
                            <plugin>
                                <groupId>org.graalvm.buildtools</groupId>
                                <artifactId>native-maven-plugin</artifactId>
                                <version>0.9.11</version>
                                <executions>
                                    <execution>
                                        <id>test-native</id>
                                        <goals>
                                            <goal>test</goal>
                                        </goals>
                                        <phase>test</phase>
                                    </execution>
                                    <execution>
                                        <id>build-native</id>
                                        <goals>
                                            <goal>build</goal>
                                        </goals>
                                        <phase>package</phase>
                                    </execution>
                                </executions>
                                <configuration>
                                    <!-- ... -->
                                </configuration>
                            </plugin>
                            <!-- Avoid a clash between Spring Boot repackaging and native-maven-plugin -->
                            <plugin>
                                <groupId>org.springframework.boot</groupId>
                                <artifactId>spring-boot-maven-plugin</artifactId>
                                <configuration>
                                    <classifier>exec</classifier>
                                </configuration>
                            </plugin>
                        </plugins>
                    </build>
                </profile>
            </profiles>
            <repositories>
                    <!-- ... -->
                    <repository>
                            <id>spring-release</id>
                            <name>Spring release</name>
                            <url>https://repo.spring.io/release</url>
                    </repository>
            </repositories>
            <pluginRepositories>
                    <!-- ... -->
                    <pluginRepository>
                            <id>spring-release</id>
                            <name>Spring release</name>
                            <url>https://repo.spring.io/release</url>
                    </pluginRepository>
            </pluginRepositories>
    </project>
    </copy>
    ```

6. pom.xmlを完成後、以下のコマンドでプロジェクトをnative imageにビルドします。
   
    ```
    <copy>./mvnw -Pnative -DskipTests package</copy>
    ```

7. 以下のコマンドでnative imageを実行します。
   
    ```
    <copy>target/rest-service-complete</copy>
    ```
       
    RESTfulサービスの起動時間はわずか0.023秒で、従来のJITモードより70倍以上の速さでサービスを起動しました。

    ```
    [opc@instance-20220407-graalvm target]$ ./rest-service-complete
    2022-04-14 07:43:09.352  INFO 638754 --- [           main] o.s.nativex.NativeListener               : AOT mode enabled

      .   ____          _            __ _ _
    /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
    ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
    \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
      '  |____| .__|_| |_|_| |_\__, | / / / /
    =========|_|==============|___/=/_/_/_/
    :: Spring Boot ::                (v2.6.5)

    
    2022-04-14 07:43:09.371  INFO 638754 --- [           main] c.e.restservice.RestServiceApplication   : Started RestServiceApplication in 0.022 seconds (JVM running for 0.023)
    ```   

## Task 3: Spring Boot アプリケーションのコンテナ化

1. OpenJDKとfat jarをベースにコンテナを作成します。complete配下に、Dockerfile.openjdkという名前のDockerファイルを作成します。

    ```
    <copy>nano Dockerfile.openjdk</copy>
    ```
       
    以下の内容をDokcerfile.openjdkに貼り付け、ファイルを保存します。
    ```
    <copy>
    FROM container-registry.oracle.com/os/oraclelinux:8

    RUN yum -y install wget unzip zip findutils tar

    RUN \
    # Install SDKMAN
    curl -s "https://get.sdkman.io" | bash; \
    source "$HOME/.sdkman/bin/sdkman-init.sh"; \
    # Install OpenJDK
    sdk install java 11.0.12-open;

    EXPOSE 8080

    COPY target/rest-service-complete-0.0.1-SNAPSHOT-exec.jar complete.jar
    CMD ["/root/.sdkman/candidates/java/current/bin/java","-jar","complete.jar"]
    </copy>
    ```
       
    Dockerコンテナをビルドします。以下のコマンドをcomplete配下で実行します。

    ```
    <copy>
    sudo docker build -f Dockerfile.openjdk -t spring:openjdk .
    </copy>
    ```
       
    コンテナイメージが生成されたことを確認し、コンテナを実行します。
    ```
    <copy>
    sudo docker images
    </copy>
    ```
       
    ```
    <copy>
    sudo docker run --rm -p 8080:8080 spring:openjdk
    </copy>
    ```
       
    RESTfulサービスの起動時間を確認します。この例では2.238秒です。
    ```
    $ sudo docker run --rm -p 8080:8080 spring:openjdk
    2022-04-16 11:17:21.767  INFO 1 --- [           main] o.s.nativex.NativeListener               : AOT mode disabled

      .   ____          _            __ _ _
    /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
    ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
    \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
      '  |____| .__|_| |_|_| |_\__, | / / / /
    =========|_|==============|___/=/_/_/_/
    :: Spring Boot ::       (v0.0.1-SNAPSHOT)

    2022-04-16 11:17:21.910  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : Starting RestServiceApplication v0.0.1-SNAPSHOT using Java 11.0.12 on 81a9827aea15 with PID 1 (/complete.jar started by root in /)
    2022-04-16 11:17:21.913  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : No active profile set, falling back to 1 default profile: "default"
    2022-04-16 11:17:23.045  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
    2022-04-16 11:17:23.062  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
    2022-04-16 11:17:23.062  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.60]
    2022-04-16 11:17:23.168  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
    2022-04-16 11:17:23.168  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 1186 ms
    2022-04-16 11:17:23.552  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
    2022-04-16 11:17:23.566  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : Started RestServiceApplication in 2.238 seconds (JVM running for 2.932)
    ```

2. Oracleが公開しているコンテナベースイメージとnative imageでコンテナを作成します。complete配下に、Dockerfile.nativeという名前のDockerファイルを作成します。

    ```
    <copy>nano Dockerfile.native</copy>
    ```
       
    以下の内容をDokcerfile.nativeに貼り付け、ファイルを保存します。
    ```
    <copy>
    FROM container-registry.oracle.com/graalvm/native-image-ee:java11-21.3.0
    COPY /target/rest-service-complete app
    ENTRYPOINT ["/app"]
    </copy>
    ```
       
    Dockerコンテナをビルドします。以下のコマンドをcomplete配下で実行します。

    ```
    <copy>
    sudo docker build -f Dockerfile.native -t spring:native .
    </copy>
    ```
       
    コンテナイメージが生成されたことを確認し、コンテナを実行します。
    ```
    <copy>
    sudo docker images
    </copy>
    ```
       
    ```
    <copy>
    sudo docker run --rm -p 8080:8080 spring:native
    </copy>
    ```
       
    RESTfulサービスの起動時間を確認します。この例では0.024秒です。JITモードより100倍速く起動できました。
       
    ```
    $ sudo docker run --rm -p 8080:8080 spring:native
    2022-04-16 11:50:40.594  INFO 1 --- [           main] o.s.nativex.NativeListener               : AOT mode enabled

      .   ____          _            __ _ _
    /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
    ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
    \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
      '  |____| .__|_| |_|_| |_\__, | / / / /
    =========|_|==============|___/=/_/_/_/
    :: Spring Boot ::                (v2.6.5)

    2022-04-16 11:50:40.595  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : Starting RestServiceApplication v0.0.1-SNAPSHOT using Java 11.0.14 on 84cc6a620aaf with PID 1 (/app started by root in /)
    2022-04-16 11:50:40.595  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : No active profile set, falling back to 1 default profile: "default"
    2022-04-16 11:50:40.601  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
    2022-04-16 11:50:40.602  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
    2022-04-16 11:50:40.602  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.60]
    2022-04-16 11:50:40.604  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
    2022-04-16 11:50:40.604  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 9 ms
    2022-04-16 11:50:40.613  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
    2022-04-16 11:50:40.613  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : Started RestServiceApplication in 0.024 seconds (JVM running for 0.025)
    ```

3. Googleが公開しているdistrolessベースイメージとnative imageでコンテナを作成します。pom.xmlに以下の部分を追加して、native imageを再度ビルドします。
    ```
    <copy>
    <configuration>
        <!-- add native-image build arguments -->
        <buildArgs>
          <buildArg>-H:+StaticExecutableWithDynamicLibC</buildArg>
        </buildArgs>
    </configuration>
    </copy>
    ```
       
   complete配下に、Dockerfile.native-lightという名前のDockerファイルを作成します。

    ```
    <copy>nano Dockerfile.native-light</copy>
    ```
       
    以下の内容をDokcerfile.native-lightに貼り付け、ファイルを保存します。
    ```
    <copy>
    FROM gcr.io/distroless/base
    COPY /target/rest-service-complete app
    ENTRYPOINT ["/app"]
    </copy>
    ```
       
    Dockerコンテナをビルドします。以下のコマンドをcomplete配下で実行します。

    ```
    <copy>
    sudo docker build -f Dockerfile.native-light -t spring:native-light .
    </copy>
    ```
       
    コンテナイメージが生成されたことを確認し、コンテナを実行します。
    ```
    <copy>
    sudo docker images
    </copy>
    ```
       
    ```
    <copy>
    sudo docker run --rm -p 8080:8080 spring:native-light
    </copy>
    ```

    RESTfulサービスの起動時間を確認します。この例では0.027秒です。JITモードより100倍速く起動できました。
       
    ```
    $ sudo docker run --rm -p 8080:8080 spring:native-light
    2022-04-16 12:01:17.205  INFO 1 --- [           main] o.s.nativex.NativeListener               : AOT mode enabled

      .   ____          _            __ _ _
    /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
    ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
    \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
      '  |____| .__|_| |_|_| |_\__, | / / / /
    =========|_|==============|___/=/_/_/_/
    :: Spring Boot ::                (v2.6.5)

    2022-04-16 12:01:17.235  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : Starting RestServiceApplication v0.0.1-SNAPSHOT using Java 11.0.14 on 0b754d744a87 with PID 1 (/app started by root in /)
    2022-04-16 12:01:17.236  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : No active profile set, falling back to 1 default profile: "default"
    2022-04-16 12:01:17.302  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
    2022-04-16 12:01:17.304  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
    2022-04-16 12:01:17.304  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.60]
    2022-04-16 12:01:17.314  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
    2022-04-16 12:01:17.314  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 78 ms
    2022-04-16 12:01:17.361  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
    2022-04-16 12:01:17.362  INFO 1 --- [           main] c.e.restservice.RestServiceApplication   : Started RestServiceApplication in 0.276 seconds (JVM running for 0.357)
    ```   
    
    コンテナのイメージサイズを確認します。
       
    ```
    $ sudo docker images
    REPOSITORY                                              TAG             IMAGE ID       CREATED        SIZE
    spring                                                  native-light    158239f8533e   9 hours ago    94.1MB
    spring                                                  native          8328a11ef0ff   9 hours ago    957MB
    spring                                                  openjdk         635302876f92   22 hours ago   954MB
    container-registry.oracle.com/os/oraclelinux            8               e6ca9618a97b   2 weeks ago    235MB
    container-registry.oracle.com/graalvm/native-image-ee   java11-21.3.0   42e4269c13cc   5 months ago   883MB
    gcr.io/distroless/base                                  latest          2e9fdb5bbbcb   52 years ago   20.3MB
    ```
  
## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
