# How can I download my ADB Wallet using command line?

## Use OCI CL tool

After installing and configuring ocicli by following the doc, you can use the oci db ```autonomous-database generate-wallet``` command to download the wallet.

```
<copy>
oci db autonomous-database generate-wallet --autonomous-database-id <OCID of your ADB instance> --file <filename>.zip --password <your password>
</copy>
```

## Learn More

* [OCI CLI documentation](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
* [generate-wallet command](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.1.1/oci_cli_docs/cmdref/db/autonomous-database/generate-wallet.html)

## Acknowledgements
* **Author** - Kevin Lazarz, Senior Principal Product Manager, Database Product Management
* **Last Updated By/Date** - Kevin Lazarz, January 2022
