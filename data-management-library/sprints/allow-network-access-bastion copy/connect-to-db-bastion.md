# How do you connect to a managed SSH session?
Before you begin, you must create a Managed SSH session to the target instance

1. Open the navigation menu and click Identity & Security. Click Bastion.

2. Under List Scope, in the Compartment list, click the name of the compartment where the bastion was created.

3. Click the name of the bastion, and then, under Sessions, locate the session that you want to use to connect to the intended target resource.

4. In the Actions menu for the session, click View SSH command.

![Image alt text](images/ssh_command.png)

5. To copy the command, next to SSH command, click Copy, and then click Close.

![Image alt text](images/copy_close.png)

6. Using a text editor, replace <privateKey> with the pSSath to the private key of the SSH key pair that you provided when you created the session.

7. Use a command line to issue the customized SSH command and connect to the bastion session.
If your private key was created with a passphrase, you are prompted to enter it.




## Acknowledgements
* **Author** - Thea Lazarova, Solution Engineer Santa Monica
* **Contributors** -  Andrew Hong, Solution Engineer Santa Monica

