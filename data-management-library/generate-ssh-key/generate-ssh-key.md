# Generate SSH Key Pair #

## Introduction
If you already have an ssh key pair, you may use that to connect to your environment.  We recommend you use the Oracle Cloud Shell to connect to your instance.  However if you prefer to connect via your laptop, please choose based on your configuration.

`IMPORTANT:  If the ssh key is not created correct, you will not be able to connect to your environment and will get errors.  Please ensure you create your key properly. ` 


## Option 1:  Oracle Cloud Shell

The Cloud Shell machine is a small virtual machine running a Bash shell which you access through the OCI Console. Cloud Shell comes with a pre-authenticated OCI CLI, set to the Console tenancy home page region, as well as up-to-date tools and utilities. To use the Cloud Shell machine, your tenancy administator must grant the required IAM policy.

1.  To start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.

    ![](./images/cloudshell.png " ") 

2.  Once the cloud shell has started, enter the following command.  Do not enter a passphrase, press Enter twice.
    ````
    mkdir .ssh
    cd .ssh
    ssh-keygen -b 2048 -t rsa -f <<sshkeyname>>
    ````
    ![](./images/cloudshell-ssh-keygen.png " ") 
    ![](./images/cloudshell-ssh-keygen-2.png " ") 

3.  Examine the two files that you just created
    ````
    ls
    ````
    ![](./images/examine-cloudshell-keys.png " ") 
    

## Option 2:  For MAC Users 

1.  Open up a terminal and type the following commands.  When prompted for a passphrase click **enter**. *Do not enter a passphrase*.
     ````
    cd ~
    cd .ssh
    ssh-keygen -b 2048 -t rsa -f <<sshkeyname>>
    ````

    ![](./images/sshkeygen.png " ") 

3.  Inspect your .ssh directory.  You should see two files.  `<<sshkeyname>>` and `<<sshkeyname>>`.pub.  Copy the contents of the pub file `<<sshkeyname>>.pub` into notepad.  Your key file should be one line. You will need this to access your instance later.  

    ````
    ls -l .ssh
    more <<sshkeyname>>.pub
    ````


## Option 3:  For Windows - Using GitBash or Windows Subsystem for Linux (WSL)

1. Open the terminal tool of your choice
2. Type the following command at the prompt to generate keys for your instance.
    ````
    ssh-keygen -f <<sshkeyname>>
    ````
3. Press enter to accept the default values
4. Do not assign a password for this exercise. (note you should always assign an SSH key password in production)
5. Type the following to retrieve your public key.  You will need this to access your instance in Step 5.  
    ````
    cat ~/.ssh/<<sshkeyname>>.pub 
    ````



## Option 4:  For Windows - Using PuttyGen

1. Open PuttyGen
2. Click the [Generate] button

    ![](./images/puttygen-generate.jpg) 
3. Move your mouse around the screen randomly until the progress bar reaches 100%
4. Click the [Save private key] button. Name the file `<<sshkeyname>>`.  This file will not have an extension.

    ![](./images/puttygen-saveprivatekey.jpg) 
5. Save the public key (displayed in the text field) by copying it to the clipboard and saving it manually to a new text file. Name the file `<<sshkeyname>>.pub`.   You will need this to access your instance in Step 5.  

6. Note: Sometimes PuttyGen does not save the public key in the correct format. The text string displayed in the window is correct so copy/paste to be sure.