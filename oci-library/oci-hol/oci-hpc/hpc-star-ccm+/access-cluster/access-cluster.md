## **Access your Cluster**

The public IP address of the bastion can be found on the lower left menu under Outputs. If you navigate to your instances in the main menu, you will also find your bastion instance as well as the public IP.

The Private Key to access the machines can also be found there. Copy the text in a file on your machine, let's say/home/user/key:
    
    ```
    chmod 600 /home/user/key 
    ssh -i /home/user/key opc@ipaddress 
    ```

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.