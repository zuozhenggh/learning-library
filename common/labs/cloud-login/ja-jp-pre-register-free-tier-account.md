# 前提条件

## はじめに

始める前に、Oracle Cloudアカウントが必要です。この5分間のラボでは、Oracle Cloud Free Tierアカウントの取得とサインインの手順を説明します。

### 既存のクラウドアカウント

 [Oracle Universal Credits](https://docs.oracle.com/en/cloud/get-started/subscriptions-cloud/csgsg/universal-credits.html)を使用したOracle Cloudアカウントなど、すでにOracle Cloudアカウントをお持ちの場合は、ステップ2に進んで、お持ちのクラウド・テナントにサインインしてください。

### 一度のサインアップで2種類の無料サービス

Oracle Cloud Free Tierでは、Oracle Cloudアカウントにサインアップすることで、多数のAlways Freeサービスと、対象となるすべてのOracle Cloud Infrastructureサービスで最大30日間使用できるUS$300の無料クレジットが付いたFree Trialを提供します。Always Freeサービスは、期間無制限でご利用いただけます。Free Trialサービスは、300米ドルの無料クレジットが消費されるまで、または30日間の有効期限が切れるまでご利用いただけます。Oracle Cloud Free Tierでは、Oracle Cloudアカウントにサインアップすることで、多数のAlways Freeサービスと、対象となるすべてのOracle Cloud Infrastructureサービスで最大30日間使用できるUS$300の無料クレジットが付いたFree Trialを提供します。Always Freeサービスは、期間無制限でご利用いただけます。Free Trialサービスは、300米ドルの無料クレジットが消費されるまで、または30日間の有効期限が切れるまでご利用いただけます。Oracle Cloud Free Tierでは、Oracle Cloudアカウントにサインアップすることで、多数のAlways Freeサービスと、対象となるすべてのOracle Cloud Infrastructureサービスで最大30日間使用できるUS$300の無料クレジットが付いたFree Trialを提供します。Always Freeサービスは、期間無制限でご利用いただけます。Free Trialサービスは、300米ドルの無料クレジットが消費されるまで、または30日間の有効期限が切れるまでご利用いただけます。

![](images/freetrial.png " ")

### 必要なもの

* 有効なメールアドレス
* SMSテキスト認証を受信する機能（メールが登録されていない場合のみ）

## **STEP 1**: Free Trialアカウントの作成

Oracle Universal Creditsを使用したOracle Cloudアカウントなど、すでにOracle Cloudアカウントをお持ちの場合は、 **STEP 2**に進んで、お持ちのクラウド・テナントにサインインしてください

1. Webブラウザを開いて、 [oracle.com/cloud/free](https://myservices.us.oraclecloud.com/mycloud/signup?language=en)にアクセスします
2.  登録ページを表示します.
       ![](images/ja-jp-cloud-infrastructure.png " ")
3.  次の情報を入力して、Oracle Cloud Free Tierアカウントを作成します。
    *  **国**
    * **氏名**と**メールアドレス**

4. 有効なメールアドレスを入力したら、 **電子メールの検証** ボタンを選択します。ボタンを選択すると以下のような画面が表示されます。
    ボタンを選択すると以下のような画面が表示されます:
       ![](images/ja-jp-verify-email.png " ")

5. 電子メールを確認します。受信トレイにオラクルからのアカウント検証メールが表示されます。メールは以下のような内容になります:
       ![](images/ja-jp-verification-mail.png " ")

6. （可能であれば）リンクを選択するか、リンクをコピーしてブラウザに貼り付けます。

7. 以下の情報を入力してOracle Cloud Free Tierアカウントを作成します。
       * **パスワード**
       * **会社名**
       * **クラウド・アカウント名** 入力に基づいて自動的に生成されますが、新しい値を入力することで変更できます。入力した内容を覚えておいてください。この名前は後でサインインする際に必要になります。
       * **ホーム・リージョン**  ホーム・リージョンはサインアップ後に変更することはできません。
       * **「続行」**をクリック
       ![](images/ja-jp-account-info.png " ")


8.  住所情報を入力します。**「続行」**をクリックしてください。
          ![](images/ja-jp-free-tier-address.png " ")

9.  国を選択し、確認のために携帯電話番号を入力します。**「Text me a code」**ボタンをクリックします。

       ![](images/ja-jp-free-tier-address-2.png " ")

10. コードを受け取ったら、コードを入力して **「コードの確認」**をクリックします。
       ![](images/ja-jp-free-tier-address-4.png " ")

11. **「支払い検証方法の追加」**ボタンをクリックします。
       ![](images/ja-jp-free-tier-payment-1.png " ")  

12.  確認方法を選択します。この場合は **「Credit Card」**ボタンをクリックします。お客様の情報とお支払い内容を入力します。*注：これは無料のクレジットプロモーションアカウントです。アカウントのアップグレードを選択しない限り、課金されることはありません。*
       ![](images/ja-jp-free-tier-payment-2.png " ")

13. お支払いの確認が完了したら チェックボックスをクリックして、「同意」の内容を確認し、同意します。**「無料トライアルの開始」**ボタンをクリックします。
       ![](images/ja-jp-free-tier-agreement.png " ")

14. あなたのアカウントはプロビジョニング中となり、数秒で利用可能になります。準備ができたら、自動的にサインイン・ページに移動します。また、オラクルから2通のメールが届きます。1つは、プロビジョニングが進行中であることを最初に通知するメールです。もう1通は、プロビジョニングが完了したことを通知するメールです。こちらが最終通知のコピーです:
       ![](images/account-provisioned.png " ")

## **STEP 2**: アカウントへのサインイン

Oracle Cloudからサインアウトした場合は、以下の手順を使用してサインインし直してください。

1. Go to [cloud.oracle.com](https://cloud.oracle.com) and click the **View Accounts** button.

    ![](images/cloud-oracle.png " ")

2. Click **Sign in to Cloud**.

    ![](images/signin-to-cloud.png " ")

3. Enter your Cloud Account Name and click **Next**. This is the name you chose while creating your account in the previous section. It's NOT your email address. If you've forgotten the name, see the confirmation email.

    ![](images/cloud-login-tenant.png " ")

4. Enter your Cloud Account credentials and click **Sign In**. Your username is your email address. The password is what you chose when you signed up for an account.

    ![](images/oci-signin.png " ")

5. You are now signed in to Oracle Cloud!

    ![](images/oci-console-home-page.png " ")

You may now [proceed to the next lab](#next).

## **Acknowledgements**

- **Created By/Date** - Tom McGinn, Database Innovations Architect, Database Product Management, March 2020
- **Last Updated By/Date** - John Peach, Kamryn Vinson, Database Product Management, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
