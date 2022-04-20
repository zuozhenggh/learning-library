# 演習 2: GraalVM Enterprise Edition のインストール

## 概要

この演習では、演習１で作成した仮想マシンインスタンスにGraalVM Enterprise Editionをインストールします。

*所要時間: 10 minutes*

### ■目標
* GraalVM Enterprise Edtion をOracle Linux上に導入
* クラスパスの設定
* Javaバージョンの確認

### ■前提条件

* 演習１が完了し、OCI上専用の仮想マシンインスタンスは作成済み
* インスタンスにアクセスするためのSSHキーをダウンロード済み

> **Note:** 演習中SSH接続の関係で有線LANで接続されていることが望ましい

## Task 1: SSH接続よりインスタンスへアクセス

1. OCIコンソール上、左上にあるナビゲーションメニューをクリックし、**Compute** → **instance** をクリックし、演習１で作成したインスタンスの**Public IP**をコピーします。(下記例では**152.70.134.51**になります。)

  ![image of instance creation](/../images/provisioning-instance2.png)


2. 参加者のPC上任意のターミナルあるいはコマンドプロンプトを立ち上げ、SSHキーを保存しているディレクトリーに移動します。SSHコマンドでインスタンスに接続します。

	```
  <copy>ssh -i <your-private-key-file> opc@<x.x.x.x></copy>
  
  ```
> **Note:** Windowのコマンドプロンプトを使用する場合、SSHキーをユーザフォルダーに置く必要があります。例：C:\Users\<ユーザ名>  
   
> **Note:** Unix系ターミナルの場合、SSHキーをchmod 600でアクセス権を限定する必要があります。

## Task 2: GraalVM Enterprise Edition 21.3をインストール

1. 以下のコマンドを入力します。導入するかどうかの確認に対して、yesと入力してインストールを開始します。

    ```
    <copy>sudo yum install graalvm21-ee-11-jdk</copy>
    ```
　
![image of instance creation](/../images/install-graalvm1.png)


2. native imageの依存ライブラリを導入します。（※Oracle Linux8 のみ必要）

    ```
    <copy>sudo yum update -y oraclelinux-release-el8</copy>
    ```

    ```
    <copy>sudo yum config-manager --set-enabled ol8_codeready_builder</copy>
    ```
   
3. 以下のコマンドを入力します。native imageフィーチャーを導入します。

    ```
    <copy>sudo yum install graalvm21-ee-11-native-image</copy>
    ```

4. 以下のコマンドを入力します。GraalVMのクラスパスを設定します。

    ```
    <copy>echo "export JAVA_HOME=/usr/lib64/graalvm/graalvm21-ee-java11" >> ~/.bashrc</copy>
    ```

    ```
    <copy>echo "export PATH=$JAVA_HOME/bin:$PATH" >> ~/.bashrc</copy>
    ```

    ```
    <copy>source ~/.bashrc</copy>
    ```


## Task 3: その他必要なパッケージをインストール

1. MavenのインストールLab3以降アプリをビルドするためMavenを導入します。導入するかどうかの確認に対して、yesと入力してインストールを開始します。

    ```
    <copy>sudo yum install maven</copy>
    ```

**Complete!**　というメッセージを確認し、Mavenが正常に導入されることを確認します。

2. gitを導入します。導入するかどうかの確認に対して、yesと入力してインストールを開始します。

    ```
    <copy>sudo yum install git</copy>
    ```

**Complete!**　というメッセージを確認し、gitが正常に導入されることを確認します。

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
