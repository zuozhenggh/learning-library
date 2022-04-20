# ハンズオン概要

GraalVM Enterprise は高い信頼性と安全性を提供するOracle Java Standard Edtionをベースに開発した次世代多言語実行環境です。GraalVM EnterpriseはJavaアプリケーションに二つの稼働方法を提供します。　
1. Just-In-Timeコンパイラ(JIT)モード
JITコンパイラにinliningなどの最適化手法を施し、アプリケーションのコードを変更せずパフォーマンスの向上実現します。
2. Native Imageモード
AOTコンパイラ(事前コンパイラ)を利用してJavaアプリケーションをnative imageにビルドし、プラットフォーム固有なnative実行ファイルに変換します。実行時JVMを必要とせず、JITモード実行時のオームアップタイムが不要のため、軽量で高速に起動できるとともに、瞬時にピーク時スループットを達成することができます。

このハンズオンでは、GraalVM Enterprise版の導入から、GraalVMの高性能JITコンパイラの活用、Native Imageを利用してCloud Naitveアプリケーションの開発を体験できます。

*予定時間：60分*

### ■目標

このハンズオンを実施することにより、以下の目標達成を目指します：
* GraalVM Enterprise EditionをLinux環境に導入
* JITコンパイラでJavaアプリケーションを実行
* Naitve Image対応のマイクロサービスフレームワークによるJavaアプリケーション開発
* コンテナ化したマイクロサービスのデプロイと稼働

### ■前提条件

以下の項目の完了が前提としています：
* 事前にOracleアカウント取得済みであること
   
## 
   
## Learn More

*参考リンク*
* [GraalVM Enterprise product page](https://www.oracle.com/java/graalvm/)
* [GraalVM Enterprise product page(日本語)](https://www.oracle.com/jp/java/graalvm/)
* [GraalVM Enterprise downloads page](https://www.oracle.com/downloads/graalvm-downloads.html)
* [GraalVM Enterprise マニュアル](https://docs.oracle.com/en/graalvm/enterprise/21/docs/reference-manual/)
* [GraalVM Enterprise マニュアル(日本語)](https://docs.oracle.com/cd/F44923_01/index.html)
* [GraalVM Enterprise Blog](https://blogs.oracle.com/java/category/j-graalvm-technology)

## Acknowledgements
* **Author** - Jun Suzuki, Java Value Solutions Consultant, Java GBU
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - Jun Suzuki, Java Value Solutions Consultant, March, 2022
