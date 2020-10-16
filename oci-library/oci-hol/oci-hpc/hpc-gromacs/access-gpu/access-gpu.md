## **Access your GPU Node**

Once your job has completed successfully in Resource Manager, you can find the Public IP Addresses for the GPU node and the Private Key on the lower left menu under **Outputs**. Copy the Private Key onto your local machine, change the permissions of the key and login to the instance:

```
chmod 400 /home/user/key
ssh -i /home/user/key opc@ipaddress

```
Once logged into your GPU node, you can run Gromacs from /mnt/block. Refer to the README.md file for specific commands on how to run Gromacs on your GPU instance.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.