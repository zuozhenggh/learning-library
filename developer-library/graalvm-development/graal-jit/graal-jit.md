# 演習 3: 高性能JITコンパイラ

## 概要

*Describe the lab in one or two sentences, for example:* この演習では、javaベンチマークを実行し、GraalVM JITコンパイラと通常のC2コンパイラのパフォーナンスを比較します。

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

1. SSH接続されているインスタンスでサンプルアプリケーションをダウンロードします。

    ```
    <copy>git clone https://github.com/graalvm/graalvm-demos.git</copy>
    ```

    ```
    <copy>cd graalvm-demos</copy>
    ```

    ```
    <copy>cd java-simple-stream-benchmark</copy>
    ```

  > Note: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)

2. サンプルコードの中身を確認します。

 ```
  <copy>nano src/main/java/org/graalvm/demos/JavaSimpleStreamBenchmark.java</copy>
 ```

 ```
   package org.graalvm.demos;

  import org.openjdk.jmh.annotations.*;

  import java.util.Arrays;
  import java.util.concurrent.TimeUnit;

  @Warmup(iterations = 1)
  @Measurement(iterations = 3)
  @BenchmarkMode(Mode.AverageTime)
  @OutputTimeUnit(TimeUnit.NANOSECONDS)
  @Fork(1)
  public class JavaSimpleStreamBenchmark {

  static int[] values = new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

  @Benchmark
  public int testMethod() {
    return Arrays.stream(values)
      .map(x -> x + 1)
      .map(x -> x * 2)
      .map(x -> x + 2)
      .reduce(0, Integer::sum);
  }
}
```

## Task 2: ベンチマークプロジェクトのビルドおよび実行

1. プロジェクトをビルドします。

    ```
    <copy>cd java-simple-stream-benchmark</copy>
    ```

    ```
    <copy>mvn package</copy>
    ```

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. プロジェクトをビルドします。

    ```
    <copy>java -jar target/benchmarks.jar</copy>
    ```


5. 以下のコマンドを実行し、ベンチマークを実行します。

	```
  <copy>java -XX:-UseJVMCICompiler -jar target/benchmarks.jar</copy>
  ```

6. Graal JIT Compiler

    ```
    Benchmark                             Mode  Cnt   Score      Error  Units
  JavaSimpleStreamBenchmark.testMethod  avgt    3  48.108 ± 1198.011  ns/op
    ```

7. C2 Compiler

    ```
  Benchmark                             Mode  Cnt    Score    Error  Units
JavaSimpleStreamBenchmark.testMethod  avgt    3  250.740 ± 37.220  ns/op
    ```


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
