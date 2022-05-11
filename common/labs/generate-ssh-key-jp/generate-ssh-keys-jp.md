# Create SSH Keys

## Introduction

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

If you already have an SSH key pair, you may use that to connect to your environment. We recommend you use the *Oracle Cloud Shell* to interface with the OCI compute instance you will create. Oracle Cloud Shell is browser-based, does not require installation or configuration of anything on your laptop, and works independently of your network setup. However, if you prefer to connect via your laptop, please select an option based on your configuration.

*IMPORTANT:  If the SSH key is not created correctly, you will not be able to connect to your environment and will get errors.  Please ensure you create your key properly.*

### LiveLabs (Green Button) Reservations - Please Read
If you are creating an SSH Key for a workshop that will be running *inside a LiveLabs tenancy*, do not select Oracle Cloud Shell.  Select the options that correspond to the OS running on your local laptop.  You will be pasting your key into the LiveLabs reservation page so that we can pre-create your instance for you.

![LiveLabs Reservation.](./images/livelabs-reservation.png " ")

## Option 1:  Windows10

Windows 10においては、早期ビルドを除けば、SSHキー生成機能"ssh-keygen"を備えています。

1.  **Powershell** コマンドウィンドウを開きます。スタート->サーチフィールドに*powershell*を入力することで、"Windows Powershell"アプリケーションを検索できます。Powershellを起動します。

    ![Open a Powershell.](images/keylab-005.png " ")

2.  Powershellターミナルウィンドウに ```ssh-keygen``` を入力します。その際、コマンドが実行されるディレクトリーを確認しておいてください。通常SSHキーはこのディレクトリー*C:¥Users¥<ユーザ名>*の*.ssh*配下に生成されます。

    ```
    <copy>ssh-keygen</copy>
    ```

3.  Enterキーを押下します。すべてのメッセージに対して、デフォルト値のまま（パスフレーズなし）でEnterを押下して進みます。

    ![Press enter at all of the prompts.](images/keylab-006.png " ")

4.  *C:¥Users¥<ユーザ名>*配下に以下のコマンドでSSHキー・ペアが正常に生成されたことを確認します。

    ```
    <copy>cd .ssh</copy>
    ```

    ```
    <copy>ls</copy>
    ```

    ```
    <copy>cat id_rsa.pub</copy>
    ```

    ![Confirm keys were created properly.](images/keylab-007.png " ")

    *private key* `id_rsa` を決して他人にシェアしないでください。 *public key* `id_rsa.pub`のみシェア、コピーしてください。後の手順でワークショップの予約ページに*public key* `id_rsa.pub`の内容を貼り付ける必要があります。その場合、Notepad, Wordpadなどのテキストエディターで`id_rsa.pub`を開き、内容をコピーしてください。

    *Note: MS Word のようなリッチテキストエディターを使用しないでください。*

    ![Or open file with plain text editor.](images/keylab-009.png " ")

    * [Click here for more details on PowerShell for Windows](https://docs.microsoft.com/en-us/powershell/)
    * [Click here for more details on OpenSSH Key Management for Windows](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement)

## Option 2:  MacOS

Watch the video below for an overview of the Generate SSH Keys Mac option.
[This video shows an overview of the Mac option.](youtube:0Q6_fvJGgMA)

1.  MacOSのターミナルのショートカットを下記場所にて見つけることができます。 **Applications** > **Utilities** メニュー。あるいは(Shift+Command+U) を押下します。

2.  **Terminal** を立ち上げ、以下のコマンドを入力します。 ```ssh-keygen```. キーの保存先はデフォルトのホームディレクトリーの.sshフォルダー配下を受け入れ、Enterキーを押下します。 ファイル名は ```id_rsa``` あるいは任意の名前を付けます。Enterキーを2回押下します（パスフレーズなし）。SSHキー・ペアの保存場所を確認します。（デフォルトは~/.ssh）。

    ````
    <copy>ssh-keygen</copy>
    ````

    ![SSH key Mac option.](images/keylab-028.png " ")


3.  以下のコマンドを実行し、SSHキー・ペアが正常に生成されていることを確認します。今後のハンズオン演習では公開キーの内容をコピーする必要があるので、その際テキストエディターで公開キーを開いて中身をコピーしてください。

    ```
    <copy>cd .ssh</copy>
    ```

    ```
    <copy>ls</copy>
    ```

    ```
    <copy>cat id_rsa.pub</copy>
    ```

    ![Verify creation of public and private keys.](images/keylab-032.png " ")

    二つのファイルが作成されています。 *秘密キー:* ```id_rsa``` と*公開キー:* ```id_rsa.pub```. 秘密キーを安全な場所に保存し、決して他人にシェアしないでください。公開キーは演習の内容に応じて、アップロードもしくは内容をコピーした上シェアしてください。


[Click for the MacOS Terminal User Guide](https://support.apple.com/guide/terminal/welcome/mac)

## Option 3: Linux

1. ターミナルウィンドウを立ち上げ、以下のコマンド入力します。

    ```
    <copy>ssh-keygen</copy>
    ```
2. ホームディレクトリー配下でコマンドを実行してください。この例ではユーザ名は ```opc```になります。デフォルトではホームディレクトリー配下の ```~/.ssh```になります。  If you don't already have keys created, accept the default file name ```id_rsa``` by hitting the Enter key.   Press the Enter key two more times to create a key with no passphrase.   The best practice in a production environment would be to use a secure passphrase; however, we don't need to bother with these practice labs.

    ![Run this command from home directory.](images/keylab-001.png " ")

    The dialog will indicate that the key pair has been saved in the ```/home/username/.ssh``` directory and is now ready for use.

3.  ```.ssh``` ディレクトリー配下に移動し、作成されたキーを確認します。

    ```
    <copy>cd .ssh</copy>
    ```
    ```
    <copy>ls</copy>
    ```

    ![List and examine your keys.](images/keylab-002.png " ")

    二つのファイルが作成されています。 *秘密キー:* ```id_rsa``` と*公開キー:* ```id_rsa.pub```. 秘密キーを安全な場所に保存し、決して他人にシェアしないでください。公開キーは演習の内容に応じて、アップロードもしくは内容をコピーした上シェアしてください。

4.  Use the Linux ```cat``` command to list the contents of ```id_rsa.pub```.

    ```
    <copy>cat id_rsa.pub</copy>
    ```

    ![Use Linux cat command.](images/keylab-003.png " ")

5.  In some labs you will be asked to upload or copy (rcp) the public key to an instance in order to facilitate communications. So remember where the file is kept. Other labs will ask for the 'contents' of the key to be pasted into various dialog boxes to facilitate secure connections. Use the ```cat``` command and copy/paste the information from the key starting at the word "ssh-rsa" and copy everything up to the final character in the line. In the example below, you would copy from "ssh-rsa ... " and to exactly after "... -01". Copy the key contents exactly, capturing space after the key characters may render your key invalid.

    ![Copy the key contents exactly.](images/keylab-004.png " ")

    You have created a public/private SSH key pair and can utilize it in any of the Oracle OCI labs that require an SSH key.

    In case you're interested, click [here](https://www.ssh.com/ssh/key) for more details on SSH, a short tutorial on initiating a connection from a Linux instance with the SSH keys we just created.

You may now proceed to the next lab or paste it in the LiveLabs reservation page.


## Acknowledgements
* **Author** - Dan Kingsley, Enablement Specialist, OSPA
* **Contributors** - LiveLabs Team, Kamryn Vinson, Anil Nair
* **Last Updated By/Date** - Madhusudhan Rao, Apr 2022

