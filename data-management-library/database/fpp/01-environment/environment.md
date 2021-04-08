# Get acquainted with the environment and rhpctl command line tool

## Introduction
Oracle Fleet Patching and Provisioning is part of the Oracle Grid Infrastructure stack. A full Grid Infrastructure environment is required. One node is enough, two are better for high availability. Oracle Restart cannot run the FPP Server component because of its ACFS requirement.
For this reason, you have to be familiar with the Grid Infrastructure stack.

Oracle Fleet Patching and Provisioning can be configured, stopped and started with `srvctl`. All the FPP operations are executed through its command line tool: `rhpctl`.

In this workshop, the FPP server is already configured, so beside checking the FPP Server status, you will use `rhpctl` most of the time.


### FPP or RHP?
When it has been released in 2013, the original name of the product was *Rapid Home Provisioning*, or *RHP*. All the commands, logs and component names have been named after the original name.
A few years later many features have been added and the name has been changed to *Fleet Patching and Provisioning*, or *FPP*. Now the name reflects better what the product does, but the underlying components and commands still use the old acronym. When talking about the product, both acronyms will show up. Most of the time, they are referring to the same thing.

For instance, the following names refer to the same thing:
* *FPP Server* and *rhpserver*
* *FPP Client* and *rhpclient*

You may also hear some Oracle employees referring to *FPP* as *RHP*. Again, they refers to the same product.


## Step 1: Connect to the FPP Server via SSH
Connect to the FPP Server via SSH using the user `opc` and the private key that you have created during the LiveLab setup.
As IP address, specify the public address of the FPP Server.
E.g. if you have a terminal with ssh available:
```
$ ssh -i ~/.ssh/id_rsa opc@xyz.xyz.xyz.xyz
Last login: Mon Mar 29 09:32:01 2021 from 178.193.174.11
[opc@fpps01 ~]$

```

If you are using other clients (Putty, MobaXTerm) and you are unsure about how to use private keys, please refer to their respective documentation.

Unless specified, all the commands on the FPP Server must be run with the `grid` user, so do not forget to switch to it after you connect.
```
[opc@fpps01 ~]$ sudo su - grid
Last login: Tue Mar 30 08:56:16 UTC 2021
[grid@fpps01 ~]$
```


## Step 2: Verify the Clusterware status and rhpserver status
Make sure that the Clusterware stack is in a healthy state:
```
[grid@fpps01 ~]$ crsctl stat res -t
--------------------------------------------------------------------------------
Name           Target  State        Server                   State details
--------------------------------------------------------------------------------
Local Resources
--------------------------------------------------------------------------------
ora.DATA.COMMONSTORE.advm
               ONLINE  ONLINE       fpps01                   STABLE
ora.DATA.GHCHKPT.advm
               ONLINE  ONLINE       fpps01                   STABLE
ora.LISTENER.lsnr
               ONLINE  ONLINE       fpps01                   STABLE
ora.chad
               ONLINE  ONLINE       fpps01                   STABLE
ora.data.commonstore.acfs
               ONLINE  ONLINE       fpps01                   mounted on /opt/orac
                                                             le/dcs/commonstore,S
                                                             TABLE
ora.data.ghchkpt.acfs
               ONLINE  ONLINE       fpps01                   mounted on /rhp_stor
                                                             age/chkbase,STABLE
ora.helper
               ONLINE  ONLINE       fpps01                   STABLE
ora.net1.network
               ONLINE  ONLINE       fpps01                   STABLE
ora.ons
               ONLINE  ONLINE       fpps01                   STABLE
ora.proxy_advm
               ONLINE  ONLINE       fpps01                   STABLE
--------------------------------------------------------------------------------
Cluster Resources
--------------------------------------------------------------------------------
ora.ASMNET1LSNR_ASM.lsnr(ora.asmgroup)
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.DATA.dg(ora.asmgroup)
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.LISTENER_SCAN1.lsnr
      1        OFFLINE OFFLINE                               STABLE
ora.MGMTLSNR
      1        ONLINE  ONLINE       fpps01                   192.168.16.18,STABLE
ora.RECO.dg(ora.asmgroup)
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.asm(ora.asmgroup)
      1        ONLINE  ONLINE       fpps01                   Started,STABLE
ora.asmnet1.asmnetwork(ora.asmgroup)
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.cdbtst01_lhr1gf.db
      1        ONLINE  ONLINE       fpps01                   Open,HOME=/u01/app/o
                                                             racle/product/19.0.0
                                                             .0/dbhome_1,STABLE
ora.cvu
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.fpps01.vip
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.gns
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.gns.vip
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.mgmtdb
      1        ONLINE  ONLINE       fpps01                   Open,STABLE
ora.qosmserver
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.rhpplsnr
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.rhpserver
      1        ONLINE  ONLINE       fpps01                   STABLE
ora.scan1.vip
      1        OFFLINE OFFLINE                               STABLE
--------------------------------------------------------------------------------
```

In the above output, you can already see that the FPP Server (rhpserver) is running, but you can double-check:
```
[grid@fpps01 ~]$ srvctl status rhpserver
Rapid Home Provisioning Server is enabled
Rapid Home Provisioning Server is running on node fpps01
[grid@fpps01 ~]$
```
You can see how the FPP Server has been configured:
```
[grid@fpps01 ~]$ srvctl config rhpserver
Storage base path: /rhp_storage
Disk Groups: DATA
Port number: 8896
Transfer port range: 8901-8906
Rapid Home Provisioning Server is enabled
Rapid Home Provisioning Server is individually enabled on nodes:
Rapid Home Provisioning Server is individually disabled on nodes:
Email address:
Mail server address:
Mail server port:
Transport Level Security disabled
HTTP Secure is enabled
```
In particular, the *Transfer port range* has been customized from the default so that is uses a fixed port range (by default it is dynamic and would require permissive firewall rules).

## Step 3: Play with the rhpctl inline help
`rhpctl` is the command line tool for all FPP Server operations. You can use the switch `-help` to get the available commands along with their syntax:
```
[grid@fpps01 ~]$ rhpctl -help
Performs Rapid Home Provisioning operations and manages Rapid Home Provisioning Servers and Clients.

Usage:
         rhpctl add                   Adds a resource, type or other entity.
         rhpctl addnode               Adds nodes or instances of specific resources.
         rhpctl addpdb                Adds a pluggable database to the specified multitenant container database.
         rhpctl allow                 Allows access to the image, series or image type.
         rhpctl collect               Collects backup of operating system configuration for the cluster.
         rhpctl compare               Compares operating system configurations for the specified cluster.
         rhpctl delete                Deletes a resource, type or other entity.
         rhpctl deleteimage           Deletes an image from a series.
         rhpctl deletenode            Deletes nodes or instances of specific resources.
         rhpctl deletepdb             Removes a pluggable database from the specified multitenant container database.
         rhpctl deploy                Deploys OS image for the cluster.
         rhpctl disable               Disables the scheduled daily backup of operating system configuration for the cluster.
         rhpctl disallow              Disallows access to the image, series or image type.
         rhpctl discover              Validates and discovers parameters to generate a response file.
         rhpctl enable                Enables the scheduled daily backup of operating system configuration for the cluster.
         rhpctl export                Exports data from the repository to a client or server data file.
         rhpctl grant                 Grants a role to a client user.
         rhpctl import                Creates a new image from the specified path.
         rhpctl insertimage           Inserts a new image into a series.
         rhpctl instantiate           Requests images from another server.
         rhpctl modify                Modifies a resource, type or other entity.
         rhpctl move                  Moves a resource from a source path to a destination path.
         rhpctl movepdb               Moves a pluggable database from the specified source multitenant container database to the specified destination multitenant container database.
         rhpctl promote               Promotes an image.
         rhpctl query                 Gets information of a resource, type or other entity.
         rhpctl recover               Recovers a node after its failure.
         rhpctl register              Registers an image, user or server.
         rhpctl replicate             Replicate image from server to a specified client.
         rhpctl revoke                Revokes a role of a client user.
         rhpctl subscribe             Subscribes the specified user to an image series.
         rhpctl uninstantiate         Stops updates for previously requested images from another server.
         rhpctl unregister            Unregisters an image, user or server.
         rhpctl unsubscribe           Unsubscribes the specified user to an image series.
         rhpctl upgrade               Upgrades a resource.
         rhpctl verify                Validates and creates or completes a response file.
         rhpctl zdtupgrade            Performs zero downtime upgrade of a database.

For detailed help on each command use:
        rhpctl <command> -help
```

```
[grid@fpps01 ~]$ rhpctl import -help
Creates a new image from the specified path.

Usage:
         rhpctl import credentials         Import client credentials from a wallet file and store them in the OCR.
         rhpctl import image               Create a new image from the specified path.

For detailed help on each command and object and its options use:
  rhpctl <command> <object> -help
```

```
[grid@fpps01 ~]$ rhpctl import image -help

Create a new image from the specified path.

Usage: rhpctl import image -image <image_name>
        {-path <path> |
         -zip <zipped_home_path> |
         -notify
                [-cc <users_list>] }
        [-imagetype <image_type>]
        [-pathowner <username>]
        [-version <image_version>]
        [-state
                {TESTABLE|
                RESTRICTED|
                PUBLISHED}]
        [-location <zipped_home_path>]
        [-client <cluster_name>]
        [-targetnode <node_name>
                [-sudouser <sudo_user_name> -sudopath <sudo_binary_path> |
                 -root |
                 -cred <cred_name> |
                 -auth <plugin_name>
                        [-arg1 <name1>:<value1>
                                [ -arg2 <name2>:<value2>...]]]]
        [-useractiondata <user_action_data>]
        [-series <series_name>]

    -image <image_name>                       Name of the image
    -path <path>                              Absolute path location of the software home to be imported (For database images, this will be the ORACLE_HOME)
    -zip <zipped_home_path>                   Absolute path of the compressed software home to be imported (a ZIP or TAR file).
    -imagetype <image_type>                   The software type, ('ORACLEDBSOFTWARE' (default) for Oracle Database software, 'ORACLEGISOFTWARE' for Oracle Grid Infrastructure software, ORACLEGGSOFTWARE for Oracle GoldenGate software, and 'SOFTWARE' for all other software. For a custom image type, use the image type name.)
    -pathowner <username>                     User with read access to files under the specified path.
    -version <image_version>                  Oracle database version for GIAAS, ODA patchbundle version for ODAPATCHSOFTWARE
    -state {TESTABLE|RESTRICTED|PUBLISHED}    State name
    -location <zipped_home_path>              Location of the compressed image file on the target
    -client <cluster_name>                    Client cluster name
    -targetnode <node_name>                   Node on which operation needs to be executed
    -sudouser <username>                      perform super user operations as sudo user name
    -sudopath <sudo_binary_path>              location of sudo binary
    -root                                     Use root credentials to access the remote node
    -cred <cred_name>                         Credential name to associate the user/password credentials to access a remote node
    -auth <plugin_name> [<plugin_args>]       Use an authentication plugin to access the remote node
    -useractiondata <user_action_data>        Value to be passed to useractiondata parameter of useraction script
    -notify                                   Send email notification
    -cc <users_list>                          List of users to whom email notifications will be sent, in addition to owner of working copy
    -series <series_name>                     Name of the series
```

## Step 4: Find the rhpserver.log
All the FPP logfiles are stored in /u01/app/grid/crsdata/fpps01/rhp/:
```
[grid@fpps01 ~]$ ls -l /u01/app/grid/crsdata/fpps01/rhp/
total 17132
drwxr-xr-x 3 grid oinstall     4096 Mar 11 09:35 conf
drwxr-xr-x 2 grid oinstall     4096 Mar 30 09:16 logs
-rw-r--r-- 1 grid oinstall   114320 Mar 11 12:28 rhprepos.trc
-rw-r--r-- 1 grid oinstall 17403231 Mar 30 09:16 rhpserver.log.0
-rw-r--r-- 1 grid oinstall        0 Mar 25 10:18 rhpserver.log.0.lck
drwxrwxr-x 2 grid oinstall     4096 Mar 30 09:16 temp
drwxr-xr-x 2 grid oinstall     4096 Mar 11 09:35 webapps
drwxr-xr-x 3 grid oinstall     4096 Mar 11 11:52 work
```

The main log file is `rhpserver.log.0`, you can use it during the workshop to verify what happens. It is verbose, but useful whenever you encounter any problems.

In real life, it is a good idea to have an environment variable for it.
E.g.:
```
export RHPLOG=/u01/app/grid/crsdata/fpps01/rhp/rhpserver.log.0
```

You have now successfully connected and verified the environment. You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Ludovico Caldara
- **Contributors** -
- **Last Updated By/Date** -  Ludovico Caldara, April 2021
