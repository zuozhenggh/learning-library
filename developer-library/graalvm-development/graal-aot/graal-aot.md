# 高速に起動するNative Image

## 概要

*Describe the lab in one or two sentences, for example:* この演習では、javaアプリケーションをnative image化、通常のJIT方式の実行とパフォーマンスを比較します。

Estimated Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


*Below, is the "fold"--where items are collapsed by default.*

## Task 1: サンプルアプリケーションの導入

1. Lab3でダウンロードしたサンプルアプリケーションを利用します。

    ```
    <copy>cd graalvm-demos</copy>
    ```

    ```
    <copy>cd native-list-dir</copy>
    ```

  > Note: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)

2. サンプルコードの中身を確認します。

 ```
  <copy>nano /graalvm-demos/native-list-dir/ListDir.java</copy>
 ```

 ```
 import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class ListDir {
        public static void main(String[] args) throws java.io.IOException {

                String root = ".";
                if(args.length > 0) {
                        root = args[0];
                }
                System.out.println("Walking path: " + Paths.get(root));

                long[] size = {0};
                long[] count = {0};

                try (Stream<Path> paths = Files.walk(Paths.get(root))) {
                        paths.filter(Files::isRegularFile).forEach((Path p) -> {
                                File f = p.toFile();
                                size[0] += f.length();
                                count[0] += 1;
                        });
                }

                System.out.println("Total: " + count[0] + " files, total size = " + size[0] + " bytes");
        }
}
```

## Task 2: サンプルアプリケーションのビルドおよび実行

1. ソースコードをビルドします。

    ```
    <copy>cd native-list-dir</copy>
    ```

    ```
    <copy>./build.sh</copy>
    ```
このシェルの中で、以下二つのコマンドを実行されています。

    - $JAVA_HOME/bin/javac ListDir.java
    - $JAVA_HOME/bin/native-image ListDir
それぞれ通常のJavaクラスとNative Imageが生成されます。
    - ListDir.class
    - listdir

2. JITモードとAOTモードでそれぞれ実行します。引数をディレクトリーのパスを渡します。例えば、ログインユーザーのホームディレクトリー配下のパスを引数としてして
  ```
    <copy>cd native-list-dir</copy>
    ```

    ```
    <copy>./run.sh ~/.</copy>
    ```

3. 二つのモードで同じアプリの実行時間を比較します。 
![Image of run.sh](/../images/graal-aot-run.png)


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
