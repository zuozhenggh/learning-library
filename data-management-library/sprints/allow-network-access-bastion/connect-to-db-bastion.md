# How do you allow network access from the Bastion?

1. Open the navigation menu and click Identity & Security. Click Bastion.

2. Under List Scope, in the Compartment list, click the name of the compartment where the bastion was created.

3. Click the name of the bastion.

4. Copy the Private endpoint IP address.

![Image alt text](images/endpoint_address.png)

5. Click the Target subnet.
If the target resource is on a different subnet than the one used by the bastion to access this VCN, edit the target resource's subnet.

![Image alt text](images/target_subnet.png)

6. From the Subnet Details page, click an existing security list that is assigned to this subnet.
Alternatively, you can create a security list and assign it to this subnet.

![Image alt text](images/security_list.png)

7. Click Add Ingress Rules.

![Image alt text](images/ingress_rule.png)

8. For Source CIDR, enter a CIDR block that includes the Private endpoint IP address of the bastion.
For example, the CIDR block <bastion_private_IP>/32 includes only the bastion's IP address.
example: 10.140.250.22/32

9. For IP Protocol, select TCP.

10. For Destination Port Range, enter the port number on the target resource.
For Managed SSH sessions, specify port 22.

11. Click Add Ingress Rules.

![Image alt text](images/add_ingress_rule.png)



## Acknowledgements
* **Author** - Thea Lazarova, Solution Engineer Santa Monica
* **Contributors** - Andrew Hong, Solution Engineer Santa Monica

