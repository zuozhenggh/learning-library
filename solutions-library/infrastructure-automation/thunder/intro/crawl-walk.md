# How to use Crawl and Walk Examples

## Introduction

All of the examples from crawl and walk work on the same principle.
In both of these folders there are independent examples for different OCI Components.
After setting up the **provider.auto.tfvars**, you will have to check out the **terraform.tfvars** files for each of the examples in crawl and walk.
In all of these examples, there will be some external dependencies, that you will have to fill in.

The network example, will have a dependency to a compartment resource.
In the below examples, there are 2 vcns created **hur1** and **hur2** in a compartment called **sandbox** which already existed before running this code. 

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  hur1 = {
    compartment_name = "sandbox"
    display_name     = "hur1"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "hur1"
  }
  hur2 = {
    compartment_name = "sandbox"
    display_name     = "hur2"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "hur2"
  }
}
```

You will have to change the **compartment_ids** variable to something that reflects your tenancy, and do the changes to the vcn resources in order to have them created in the correct compartments.

Let's suppose you already have 2 compartments (**comp1** and **comp2**) and you want to create 2 vcns (**vcnA**, **vcnB**) in **comp1** and 1 vcn (**vcnC**) in **comp2**.
Due to the fact that compartments are external to this example, you will have to go the console, and get the ids for **comp1** and **comp2** and add them to the **compartment_ids** variable. Let's suppose the id for **comp1** is **ocid1.compartment.oc1..aaaaaaaacomp1** and for **comp2** is **ocid1.compartment.oc1..aaaaaaaacomp2**.

The **compartment_ids** variable will look like this:
```
compartment_ids = {
  comp1 = "ocid1.compartment.oc1..aaaaaaaacomp1"
  comp2 = "ocid1.compartment.oc1..aaaaaaaacomp2"
}
```

You will also have to change the **vcn_params** in order to reflect the creation of 3 vcns instead of 2, with the correct mappings to comp1 and comp2 and the name change.

```
vcn_params = {
  vcnA = {
    compartment_name = "comp1"
    display_name     = "vcnA"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "vcnA"
  }
  vcnB = {
    compartment_name = "comp1"
    display_name     = "vcnB"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "vcnb"
  }
  vcnC = {
    compartment_name = "comp2"
    display_name     = "vcnC"
    vcn_cidr         = "12.0.0.0/16"
    dns_label        = "vcnc"
  }
}
```

All the mappings between all the resources are made by name and all of them will have a parameter that does the linking. Everything can be easily scaled up, just by adding another map in the params of the resources you are interested in (as you've seen in the example above).

Some of these independent examples will have more than one external variable, but all of them are easily spotted at the beginning of their corresponding README.md file.

### Crawl and Walk Components

#### [IAM](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/crawl/iam/iam.md)
#### [Network](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/crawl/network/network.md)
#### [ADW](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/crawl/adw/adw.md)
#### [DBaaS](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/crawl/dbaas/dbaas.md)
#### [Compute Instances](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/crawl/instances/compute.md)
#### [DNS](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/walk/dns/dns.md)
#### [FSS](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/walk/fss/fss.md)
#### [Instance Principal](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/walk/instance-principal/instance-principal.md)
#### [Load Balancer](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/walk/load-balancer/load-balancer.md)
#### [Object Storage](https://github.com/oracle/learning-library/blob/master/solutions-library/infrastructure-automation/thunder/examples/walk/object-storage/object-storage.md)

In each of these components, you will find examples on how to modify the **terraform.tfvars** file and how to run the code after achieving your desired infrastructure.