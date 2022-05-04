# 高速に起動するNative Image

## 概要

この演習では、通常のJavaクラスをネイティブコンパイルした上、従来のJIT方式とネイティブ形式の実行時パフォーマンスを比較します。  
Graalコンパイラには、進化したJITコンパイラ機能に並び、ネイティブな実行ファイル(native image)を生成するAOT（Ahead-Of-Time)コンパイラ機能を持ち合わせています。Javaバイトコード（Javaクラス）を実行しながらコンパイルするJITモードとは異なり、AOTモードでは実行前のビルド時に、Javaバイトコードを静的解析をした上コンパイルされます。ネイティブな実行ファイルを生成するプロセスの中で、主に以下の作業が行われます。
* ポインタ解析（Points-to analysis）:　AOTコンパイラが、実行時に到達可能なクラス、メソッド、フィールド、依存ライブラリ、必要なJDKクラスを判別して、ネイティブ実行ファイルに格納します。
* ビルド時初期化（Initializations at build time）： ビルド時クラスを初期化し、実行時のオーバーヘッドを軽減します。
* ヒープスナップショット（Heap snapshotting）： 初期化オブジェクト、到達可能なオブジェクトをJVMヒープ上に事前に書き込みすることによって、実行時スピードを大幅に高めます。
![image of instance creation](/../images/native-image-build.png)


*所要時間: 10分*

### ■目標
* GraalVMのAOTコンパイラでJavaクラスをネイティブ実行ファイル(naitve image)に変換
* JavaアプリケーションをJITモードとネイティブモードでそれぞれ実行し、パフォーマンスを比較

### ■前提条件

* 演習１「GraalVM Enterprise Editionのインストール」を実施済みであること

## Task 1: サンプルアプリケーションの導入  

このサンプルはJava Stream APIを利用して、指定したディレクトリー配下のファイル一覧を表示するプログラムとなります。同じプログラムをJITモードとネイティブモードの両方で実行し、所要時間を比較します。  

1. 演習１の中でGitHubよりダウンロードしたGraalVM Demosサンプルアプリケーションを利用します。 
        > **Note:** まだダウンロードしていない場合、演習2のTask1に従ってサンプルをダウンロードしてください。
        サンプルソースをダウンロードしたフォルダー配下の"native-list-dir"フォルダーに移動してください。

        ```
        <copy>cd graalvm-demos</copy>

        ```  

        ```
        <copy>cd native-list-dir</copy>
        ```

        > ** Note:** 上記サンプル以外に、GraalVMの[複数サンプル](https://github.com/graalvm/graalvm-demos)をご参照頂けます。


2. サンプルコードの中身を確認します。 
  エディターでサンプルソースコードの内容を確認します。

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
