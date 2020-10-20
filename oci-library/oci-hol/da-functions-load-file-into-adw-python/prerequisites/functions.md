# Prerequisites for Functions

## Create compartment

If you want to use an existing compartment, skip to the next step, otherwise, click **Compartments** and then **Create Compartment**, to create a new compartment.

## Create VNC and subnets

If a suitable VCN in which to create network resources doesn't exist already, log in to the Console as a tenancy administrator and under Core Infrastructure, go to **Networking** and then:

1. Click **Virtual Cloud Networks** and choose a compartment from the previous step.
2. Click **Start VCN Wizard**, then **VCN with Internet Connectivity**, then **Start VCN Wizard**.
3. Enter a name for the new VCN (for example: `fn-vcn`), click **Next**, and then click **Create** to create the VCN along with the related network resources.

## Create policy for Oracle Functions

Log in to the Console as a **tenancy administrator** and under Governance and Administration, go to **Identity** and click **Policies** and then do the following:

1. Select the tenancy's **root compartment**
2. Click **Create Policy**.
3. For name, enter `faas-policy`.
4. For description, etner `Policy for Functions`.
5. Add the following two statements for the Oracle Functions service:
  ```
  Allow service FaaS to read repos in tenancy
  Allow service FaaS to use virtual-network-family in tenancy
  ```
6. Click **Create**.

Note, if the account you're using is not a tenancy administrator, add the following statements to the policy: 

```
Allow group <group-name> to read metrics in tenancy
Allow group <group-name> to read objectstorage-namespaces in tenancy
Allow group <group-name> to use virtual-network-family in tenancy
Allow group <group-name> to manage functions-family in tenancy
Allow group <group-name> to use cloud-shell in tenancy
```

Make sure the user is part of the group referenced in the policy statements above. To create groups and add users to groups, refer to [Create a group](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managinggroups.htm#To).