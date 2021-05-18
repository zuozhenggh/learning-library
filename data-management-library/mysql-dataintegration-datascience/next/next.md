# Next Steps

## Want to learn more?

[Getting Started with Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/preparing-for-connectivity.htm)

## Troubleshooting

---

Lab 2: Create MySQL Database System - Enable HeatWave

Error: `attribute = {heatWaveCluster.shapeFamily}, value = {MySQL.HeatWave.VM.Standard.E3} - for this cluster shape the MySQL instance shape must be the same`

![](images/heatwave_error_shape.png)

> Note: You need to use HeatWave Shape when you created MySQL Database System.
>
> Terminate your current MySQL Instance and create a new one with HeatWave valid shape, for example: `MySQL.HeatWave.VM.Standard.E3`.
>
> Enable HeatWave should work with the new shape.

---

Lab 3: Create Data Integration Instance

`java.io.IOException: Unable to determine if path is a directory`

Review Policy:

```
<copy>allow any-user to read objectstorage-namespaces at tenancy</copy>
```

---

Lab 3: Create Data Integration Instance

![Data Integration VNC policy missing](images/di_error_vcn.png.png)

```
Following VCN not found or user not authorized: ocid1.vcn.oc1.uk-london-1.aaaaasdlnsdfjnskjgndfkjbdkjfgbdkjfbgdjkf ,or there might be missing network policies, please refer this link for more information https://docs.cloud.oracle.com/en-us/iaas/data-integration/using/
```

You forgot to create the policy for Data Integration to use Virtual Cloud Network.

```
<copy>allow service dataintegration to use virtual-network-family in tenancy</copy>
```

---

## **Acknowledgements**

- **Author** - Victor Martin, Technology Product Strategy Manager
- **Contributors** - Priscila Iruela
- **Last Updated By/Date** - Kamryn Vinson, May 2021

## See an issue

Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the **workshop name**, **lab**, and **step** in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the **Feedback Comments** section.
