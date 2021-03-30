# Provision an Oracle Restart environment

## Introduction
Oracle Fleet Patching and provisioning can provision Grid Infrastructure software on remote targets using the command `rhpctl add workingcopy`.

```
[grid@fpps01 ~]$ rhpctl add workingcopy -help GRIDHOMEPROV

Creates and configures a new cluster with Oracle Clusterware.

Usage: rhpctl add workingcopy -workingcopy <workingcopy_name>
        {-image <image_name> |
         -series <series_name>}
        {-root |
         -cred <cred_name> |
         -sudouser <sudo_user_name> -sudopath <sudo_binary_path> |
         -auth <plugin_name>
                [-arg1 <name1>:<value1>
                        [ -arg2 <name2>:<value2>...]]}
        [-setupssh] -responsefile <response_file>
        [-clusternodes <nodelist>]
        [-user <user_name> ]
        [-oraclebase <oraclebase_path>]
        [-path <where_path>]
        [-asmclientdata <data_path>]
        [-gnsclientdata <data_path>]
        [-clustermanifest <data_path>]
        [-agpath <read_write_path> -aupath <gold_image_path>]
        [-ignoreprereq |
         -fixup]
        [-schedule <timer_value>]
        [-scan <scan_name>]
        [-diskDiscoveryString <disk_discovery_string>]

    -workingcopy <workingcopy_name>        Name of the working copy to be created
    -image <image_name>                    Image name from the configured images
    -series <series_name>                  Image series from which the latest image will be taken when adding a working copy.
    -responsefile                          response file to be used to perform Oracle Grid Infrastructure provisioning
    -clusternodes <node_name>:<node_vip>[:<node_role>][,<node_name>:<node_vip>[:<node_role>]...]
                                           Comma-separated list of node information on which Oracle Clusterware will be provisioned
    -user <user_name>                      Name of the user for whom the software home is being provisioned
    -root                                  Use root credentials to access the remote node
    -sudouser <username>                   perform super user operations as sudo user name
    -sudopath <sudo_binary_path>           location of sudo binary
    -cred <cred_name>                      Credential name to associate the user/password credentials to access a remote node
    -auth <plugin_name> [<plugin_args>]    Use an authentication plugin to access the remote node
    -client <cluster_name>                 Client cluster name
    -oraclebase <oraclebase_path>          ORACLE_BASE path for provisioning Oracle database home or Oracle Grid Infrastructure home
    -path <path>                           The absolute path for provisioning software home (For database images, this will be the ORACLE_HOME)
    -ignoreprereq                          To ignore the CVU pre-requisite checks
    -fixup                                 Execute fixup script. Valid only for Grid Infrastructure provisioning.
    -setupssh                              sets up passwordless SSH user equivalence on the remote nodes for the provisioning user
    -asmclientdata <data_path>             File that contains the ASM client data
    -gnsclientdata <data_path>             File that contains the GNS client data
    -clustermanifest <data_path>           Location of Cluster Manifest File
    -agpath <read_write_path>              Read/write path for the persistent Oracle home path
    -aupath <gold_image_path>              Read-only gold image path for the persistent Oracle home path
    -schedule { <timer_value> | NOW }      Preferred time to execute the operation. If an absolute timer_value is specified, it should be in ISO-8601 format. For example: 2016-12-21T19:13:17+05. If offset is specified as the timer value, it should be in the format +dd:mm:yy:hh:mm:ss. For example: +02:22:22. If NOW is specified, job will be scheduled immediately.
    -scan <scan_name>                      SCAN name
    -diskDiscoveryString <disk_discovery_string>
                                           disk discovery string
```

### Software Only provisioning
If the target server already has a GI stack (either Oracle Restart or a full GI stack), the new working copy is provisioned as Software Only: the existing stack is untouched.
In this case, once the new home is installed, the existing Grid Infrastructure stack can be patched or upgraded by using either `rhpctl move gihome` or `rhpctl upgrade gihome`. FPP automates all the steps, including the stop, move, rootupgrade and start of the Clusterware stack.

### New Cluster or Restart provisioning
If you need to provision the GI working copy on a brand new cluster, once the servers have been set up to host the cluster (this is a step that you need to take care of, either manually or using your favorite OS configuration management tool), all you need to do is to run `rhpctl add workingcopy` specifying the response file to be passed to gridSetup.sh.

## Step 1: Provision the Restart environment on a new target using the response file

Prepare a response file containing the following content:

```
# ~grid/fppc.rsp
oracle.install.responseFileVersion=/oracle/install/rspfmt_crsinstall_response_schema_v19.0.0
INVENTORY_LOCATION=/u01/app/oraInventory
oracle.install.option=HA_CONFIG
ORACLE_BASE=/u01/app/grid
oracle.install.asm.OSDBA=dba
oracle.install.asm.OSOPER=oper
oracle.install.asm.OSASM=asmadmin
oracle.install.asm.SYSASMPassword=WelcomeWelcome##123
oracle.install.asm.diskGroup.name=DATA
oracle.install.asm.diskGroup.redundancy=EXTERNAL
oracle.install.asm.diskGroup.AUSize=4
oracle.install.asm.diskGroup.disks=/dev/oracleasm/asm-disk1
oracle.install.asm.diskGroup.diskDiscoveryString=/dev/oracleasm/*
oracle.install.asm.monitorPassword=WelcomeWelcome##123
```

Alternatively, you can download it directly on the host:
```
wget 
```
