# Generate SSH Key Pair #

## Introduction
If you already have an ssh key pair, you may use that to connect to your environment.  We recommend you use the Oracle Cloud Shell to connect to your instance.  However if you prefer to connect via your laptop, please choose based on your configuration.

*IMPORTANT:  If the ssh key is not created correct, you will not be able to connect to your environment and will get errors.  Please ensure you create your key properly.*



1.  You should have received two emails.  **Email 1:**  From noreply with the subject **Verify Email Request** (check your spam and junk folders).  This has the link that verifies your email.  Without clicking on this link you cannot login to the tenancy.  Open up this email.  Click on the **Sign In to Oracle Cloud** link.  

    ![](./images/signin.png " ")


2.  You should have received a 2nd email with your temporary password.  Enter your username and your password (Email 2) in the box on the right hand side that says *Oracle Infrastructure* (Do not use Single Sign-On (SSO), SSO is not enabled for this tenancy).  

    ![](./images/loginpage.png " ")
   
3. You will then be taken to a screen to change your password.  Choose a new password that you can remember and click **Sign In** (make sure you are using an approved browser.  IE is not supported)

    ![](./images/changepwd.png " ")


4. Once you successfully login, you will be presented with the Oracle Cloud homepage. (NOTE: If you get an *Email Activation Unsuccessful* message, check to see if you can still access the cloud by looking for the hamburger menu to the left). 
  ![](./images/cloud-homepage.png " ") 


5.  In Email 2, you were also assigned a region.  Click in the upper right hand corner and set your Region appropriately.   (*NOTE:  Setting the region is important, your network is region specific.  If you choose a different region that does not match your subnet, you will get an error on environment creation*) 

    ![](./images/changeregion.png " ") 