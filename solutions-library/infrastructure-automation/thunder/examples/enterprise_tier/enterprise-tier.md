# Enterprise Tier Resources

## Introduction
In this example, all the resources from crawl and walk are instantiated.
You have full flexibility on provisioning the resources from here (you can scale anything up or down, modify resources parameters), just by modifying the **terraform.tfvars** files as explained in the crawl/walk examples.
There are no other external variables in this example.

Don't forget to populate the provider with the details of your tenancy as specified in the prerequisites lab.

## Running the code

In order to be able to spin up the enterprise tier resources, you will have to navigate to **thunder -> examples -> enterprise_tier**.

```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars_file

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars_file
```