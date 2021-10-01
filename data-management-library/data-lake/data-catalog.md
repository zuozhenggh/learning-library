# OCI Data Catalog, OCI Data Integration and Data Assets

## Introduction

Here we will create our OCI Data Catalog and OCI Data Integration workspace first and create a couple of additional data assets along with discovering our ADW database as a data asset.

Estimated Time:15 minutes

### About Product

In this lab, we will learn more about the OCI Data Catalog which is used in enterprises to manage technical, business and operational metadata - see the [documentation](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm) for more information.

We will also discuss OCI Data Integration as part of data asset ETL and you can learn more here - [documentation](https://docs.oracle.com/en-us/iaas/data-integration/home.htm).

### Objectives

- Learn how to create OCI Data Catalog
- Learn how to create OCI Data Integration Workspace
- Learn how to discover and create new data assets

## Task 1: Create the OCI Data Catalog

In this task, you will create the OCI Data Catalog. Review options for creating business term to sync with the metadata for the data assets

![Navigate to Analytics](./images/nav_datacatalog.png " ")

Click on Create Data Catalog. Create in Compartment, lakehouse1, and name the catalog, lakehousecatalog. Click on Create.

![Create Catalog](./images/create_datacatalog.png " ")

Explore the Data Catalog:
- Data Assets, some we will discover and others we will just create to use with this data lake.
- Data Entities, these come from the data assets as there can multiple entities in each data asset
- Glossaries, these are business terms for mappings of the data and definitions with columns and data assets.
- Catagories and Terms, more business terms can be defined here to maintain consistent groupings of data.
- Jobs, refresh and harvest data jobs that will be run and scheduled to keep data current.

![View Catalog](./images/datacatalog_overview.png " ")

## Task 2: Discover data assets and configure connections for new data assets

In this step, you will discover the data assets already available in the ADW and Object Storage. We will also create new data assets that we might get from another source or API.
From the Quick Menu on the Home tab, click Discover Data Sources.

![Data Discovery](./images/discoverdata.png " ")

As you can we have our data warehouse database available and our object storage buckets. Click the box and then click Create Data Asset. The name and description and type will automatically be filled in and you can adjust and make changes as needed. Do these steps for both the ADW Database and object storage buckets.


![Add Data Assets](./images/catalog_addasset.png " ")

The data asset will then be added to this data catalog.

## Task 3: Create the OCI Data Integration workspace

Creation of the OCI Data Integration workspace required the VPN for private endpoints, groups and policies that we configured during the setup of the environment for the Lakehouse. Now it is a matter of navigating to the Data Integration space and creating the workspace which will in turn allow us to create ETL processes.

From the home navigation menu, click Analytics & AI and then click Data Integration.

![Data Integration](./images/nav_dataintegration.png " ")

From the Data Integration Service we will create a Workspace which will allow for diagramming the data flows with filters and create execution plans for data into the data assets. First we must create the workspace and a couple more policies for the workspace to access the object storage and use and update the data in the data lake.

Click on Create Workspace. Name it Workspace Lakehouse and click the Create button.

![Create Workspace](./images/create_workspace.png " ")

While that is creating navigate back to Policies. Click on Identity & Security and then Policies.
Select dataintegrationWS policies and clik Edit Policy Statements. From here you can + Another Statement.

![Add Policies](./images/add_policies.png " ")

Use the follow three allow statements to add into the existing policy, and then Save Changes.
```
<copy>
allow any-user to use buckets in compartment lakehouse1 where ALL {request.principal.type='disworkspace',request.principal.id='ocid1.disworkspace.oc1.iad.anuwcljt2ow634yaaq4pl6jbvhhudjkchsdwrw3q3hkmlpoyfilwyyjqykjq'}

allow any-user to manage objects in compartment lakehouse1 where ALL {request.principal.type='disworkspace',request.principal.id='ocid1.disworkspace.oc1.iad.anuwcljt2ow634yaaq4pl6jbvhhudjkchsdwrw3q3hkmlpoyfilwyyjqykjq'}

allow any-user {PAR_MANAGE} in compartment lakehouse1 where ALL {request.principal.type='disworkspace',requesst.principal.id='ocid1.disworkspace.oc1.iad.anuwcljt2ow634yaaq4pl6jbvhhudjkchsdwrw3q3hkmlpoyfilwyyjqykjq'
}

</copy>
```

Once the workspace has been created (a refresh of the screen might be needed to go from Processing to Active). 

- Click on the Workspace Lakehouse. 
- Click on Create a Project.
- Enter Name Project_lakehouse
- Click Create

![Create Project](./images/create_project.png " ")

We have now configured our Data Lakehouse by creating a database, data sources in object storage and setup up our services ready to use and set up processes for data loading and ETL with OCI Data Flow.

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** - Michelle Malcher, Database Product Management
* **Contributors** -  
* **Last Updated By/Date** - Michelle Malcher, Database Product Management, September 2021
