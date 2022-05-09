# GraalVMとDockerコンテナ

## 概要

この演習では、演習4で作成したSpring BootのRESTFulサービスをDockerコンテナにビルドします。jar形式とnaitve image形式でそれぞれコンテナにビルドし、両者のパフォーマンスを比較します。以下３種類のDockerイメージを作成します。
* openjdkのベースイメージにFat.jarを組み込む
* Oracle Linux8のベースイメージにnative imageを組み込む
* Distrolessのベースイメージにstaticなnative imageを組み込む

*所要時間: 15分*

### ■目標
* 3種類のベースイメージを使用して、より軽量で高速起動するコンテナイメージを作成

### ■前提条件
* 演習4「GraalVMとマイクロサービスフレームワークによるRESTFulサービス開発」を実施済みであること  

## Task 1: OpenJDKとOracle Linux8とfat jarの組み合わせ
1. OpenJDKとOracle Linux8を含むベースイメージをダウンロードし、それをベースに演習4のTask2で作成したSpring Bootのjarファイルをコンテナに入れます。spdemo配下に、Dockerfile.openjdkという名前のDockerファイルを作成します。

    ```
    <copy>nano Dockerfile.openjdk</copy>
    ```
       
    以下の内容をDokcerfile.openjdkに貼り付け、ファイルを保存します。
    ```
    <copy>
    FROM container-registry.oracle.com/java/openjdk:17-oraclelinux8

    EXPOSE 8080

    COPY target/demo-0.0.1-SNAPSHOT-exec.jar demo.jar
    CMD ["java","-jar","demo.jar"]
    </copy>
    ```
       
2. Dockerコンテナをビルドします。以下のコマンドをspdemo配下で実行します。

    ```
    <copy>
    sudo docker build -f Dockerfile.openjdk -t spring:openjdk .
    </copy>
    ```
    ![docker in spring](images/docker-spring.png)
       
3. コンテナイメージが生成されたことを確認し、コンテナを実行します。
    ```
    <copy>
    sudo docker images
    </copy>
    ```
    ![docker in spring1](images/docker-spring1.png)
       
    ```
    <copy>
    sudo docker run --rm -p 8080:8080 spring:openjdk
    </copy>
    ```
    ![docker in spring2](images/docker-spring2.png)

    RESTfulサービスの起動時間を確認します。この例では1.441秒です。  

4. 別ターミナルを立ち上げ、以下のコマンドを実行し、HTTPリクエストからレスポンスが正常にリターンされることを確認します。
        
    ```      
    <copy>curl http://localhost:8080/greeting</copy>
    ```
    ![docker in spring3](images/docker-spring3.png)

5. Ctrl+CでDockerコンテナからexitします。

    > **Note:** コンテナが起動しているターミナルでSSH接続が既に切断されている場合、SSH接続を再度実行し、sudo docker ps -a　を実行し、コンテナが実行中かどうかを確認してください。

## Task 2: Oracle8-slimとnative imageの組み合わせ

1. Oracleが公開しているコンテナベースイメージとnative imageでコンテナを作成します。spdemo配下に、Dockerfile.nativeという名前のDockerファイルを作成します。

    ```
    <copy>nano Dockerfile.native</copy>
    ```
       
    以下の内容をDokcerfile.nativeに貼り付け、ファイルを保存します。
    ```
    <copy>
    # FROM container-registry.oracle.com/graalvm/native-image-ee:java11-21.3.0
    FROM container-registry.oracle.com/os/oraclelinux:8-slim
    COPY target/demo app
    ENTRYPOINT ["/app"]
    </copy>
    ```
       
2. Dockerコンテナをビルドします。以下のコマンドをspdemo配下で実行します。

    ```
    <copy>
    sudo docker build -f Dockerfile.native -t spring:native .
    </copy>
    ```
    ![docker in spring4](images/docker-spring4.png)

       
3. コンテナイメージが生成されたことを確認し、コンテナを実行します。

    ```
    <copy>
    sudo docker images
    </copy>
    ```
    ![docker in spring5](images/docker-spring5.png)

    ```
    <copy>
    sudo docker run --rm -p 8080:8080 spring:native
    </copy>
    ```
    ![docker in spring6](images/docker-spring6.png)

4. 別ターミナルを立ち上げ、以下のコマンドを実行し、HTTPリクエストからレスポンスが正常にリターンされることを確認します。
    ```      
    <copy>curl http://localhost:8080/greeting</copy>
    ```
    ![docker in spring3](images/docker-spring3.png)
       
    RESTfulサービスの起動時間を確認します。この例では0.022秒です。JITモードより100倍速く起動できました。

5. Ctrl+CでDockerコンテナからexitします。

## Task 3: Distrolessと静的native imageの組み合わせ

1. より軽量なコンテナをビルドするため、ベースイメージをGoogleが公開しているdistrolessベースイメージを使用します。distrolessは、パッケージマネージャやシェルを含まない、アプリケーション実行に特化したコンテナイメージです。distrolessと上記Task2で作成したnative imageでコンテナを作成します。pom.xmlに以下の部分を追加して、native imageを再度ビルドします。
    spdemo配下でpom.xmlを開きます。
    ```
    <copy>nano pom.xml</copy>
    ```
    以下の部分をprofileタグのconfiguration部分に追加します。
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
    Ctrl＋Xを押し、内容保存の確認メッセージに対し、"Y"を入力し、Enterを押下してソースファイルを保存します。

2. spdemo配下に、以下のコマンドを実行し、native imageを再度ビルドします。

    ```
    <copy>./mvnw -Pnative -DskipTests package</copy>
    ```

3. ビルドが正常に終了したことを確認した上、spdemo配下に、Dockerfile.native-lightという名前のDockerファイルを作成します。

    ```
    <copy>nano Dockerfile.native-light</copy>
    ```
       
    以下の内容をDokcerfile.native-lightに貼り付け、ファイルを保存します。
    ```
    <copy>
    FROM gcr.io/distroless/base
    COPY /target/demo app
    ENTRYPOINT ["/app"]
    </copy>
    ```
       
4. Dockerコンテナをビルドします。以下のコマンドをspdemo配下で実行します。

    ```
    <copy>
    sudo docker build -f Dockerfile.native-light -t spring:native-light .
    </copy>
    ```
       
5. コンテナイメージが生成されたことを確認し、コンテナを実行します。
    ```
    <copy>
    sudo docker images
    </copy>
    ```
    ![docker in spring7](images/docker-spring7.png)
       
    ```
    <copy>
    sudo docker run --rm -p 8080:8080 spring:native-light
    </copy>
    ```

    ![docker in spring8](images/docker-spring8.png)
    RESTfulサービスの起動時間を確認します。この例では0.026秒です。JITモードより100倍速く起動できました。

6. 別ターミナルを立ち上げ、以下のコマンドを実行し、HTTPリクエストからレスポンスが正常にリターンされることを確認します。
    ```      
    <copy>curl http://localhost:8080/greeting</copy>
    ```

7. Ctrl+CでDockerコンテナからexitします。  

    以下は3種類のDockerコンテナイメージをベースに作成したコンテナの起動時間とイメージサイズの比較です。

    | ベース | jar | native image | naitve image with distroless |
    | --- | --- | --- | --- |
    | 起動時間(秒) | 1.441 | 0.022  | 0.027 |
    | コンテナイメージサイズ(MB) | 594 | 184  | 94.2  |
  
## Acknowledgements

- **Created By/Date** - Jun Suzuki, Java Global Business Unit, April 2022
- **Contributors** - 
- **Last Updated By/Date** - Jun Suzuki, April 2022
