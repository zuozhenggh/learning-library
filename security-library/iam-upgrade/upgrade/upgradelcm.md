# Oracle IAM 11.1.2.3 to 12.2.1.4 In-Place Upgrade

This section guides you through the steps to upgrade 11.1.2.3 LCM based OIM-OAM integrated environment with OUD as backend Directory Server &amp; OHS as webserver to 12.2.1.4

An Oracle Identity and Access Management (IAM) deployment consists of a number of different components:
- A database
- An LDAP directory to store user information
- Oracle Access Manager for Authentication
- Oracle Identity Governance (formally Oracle Identity Manager) for provisioning
- Optionally, Oracle HTTP Server and Webgate securing access to Oracle Access Manager and Oracle Identity Governance


*Estimated Lab Time*:  48-72 Hours

### Objectives
- Become familiar with the in-place upgrade process from IAM 11.1.2.3 to IAM 12.2.1.4

### Prerequisites  

This lab assumes you have:
- A Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment

```
- As part of pre-upgrade steps, customers have to delete any 10g agents in oamconsole. If they fail to do this UA readiness check will fail indicating presence of 10g agents. As part of pre-upgrade steps for OAM, delete any 10g agents in oamconsole.  UA readiness check will fail if 10g agents exist
- UA readiness check with fail at System Components Infrastructure with error OHS_managed_template.jar missing. This can be ignored as we are not upgrading OHS
```

## About the In-Place Upgrade Strategy

There are different upgrade strategies that you can employ for an upgrade of Oracle Internet Directory, Oracle Unified Directory, and Oracle Identity and Access Management. The strategy you choose will depend mainly on your business needs. This lab uses a Multi-hop in-place upgrade outlined in the Upgrade strategies document :
[Oracle IAM Upgrade Strategies](https://docs.oracle.com/en/middleware/fusion-middleware/iamus/place-upgrade-strategies.html#GUID-9F906AE2-5BDF-426D-A97C-AC546ABFBD28)  


The in-place upgrade allows you to take your existing deployment and upgrade it in place.

- When performing an upgrade, you should make as few changes as possible in each stage to ensure that the upgrade is successful.
- For example, it is not recommended to perform multiple upgrade activities such as upgrading Oracle Identity and Access Management, changing the directory, updating the operating system, and so on, all at the same time.
- If you want to perform such an upgrade, you must do it in stages. You must validate each stage before moving on to the next. The benefit of this approach is that it helps you to identify precisely where the issue occurred, and correct it or undo it before you continue the exercise.  


Steps involved in the upgrade process are below :

*Step 1:* Upgrade IAM Components from 11.1.2.3 to 12.2.1.3
  - Upgrade OID 11.1.2.3 to OUD 12.2.1.3
  - Upgrade OAM 11.1.2.3 - 12.2.1.3
  - Upgrade OIM 11.1.2.3 to OIG 12.2.1.3
  - Apply OAM and OIG latest Stack patch Bundle for 12.2.1.3  

*Step 2:* Upgrade IAM Components from 12.2.1.3 to 12.2.1.4
  - Upgrade OUD from 12.2.1.3 to 12.2.1.4
  - Upgrade OAM 12.2.1.3 to 12.2.1.4
  - Upgrade OIG 12.2.1.3 to 12.2.1.4
  - Apply OAM and OIG latest Stack patch Bundle for 12.2.1.4  

*Step 3:* Integrate OIG and OAM using LDAP Connector  

*Step 4:* Transition OHS from 11.1.1.9 to 12.2.1.4  

*Step 5:* Validate the IAM 12.2.1.4 Integrated environment   

Please follow the instructions below to execute each step.  

##  **STEP 1**: Upgrade IAM Components from 11.1.2.3 to 12.2.1.3

### *Step 1.1:* Upgrade OID 11.1.2.3 to OUD 12.2.1.3

Perform all steps outlined in *section 6.6* of Upgrading Oracle Unified Directory guide
- [6.6 Upgrading an Existing Oracle Unified Directory Server Instance](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.3/oudig/updating-oracle-unified-directory-software.html#GUID-506B9DAC-2FDB-47C9-8E00-CC1F99215E81)

### *Step 1.2:*  Update the keystore encryption strength

Please follow the steps below to update keystore encryption strength and change the password for 12c upgrade

1. List current keystore contents
```
keytool -list -v -keystore /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/default-keystore.jks -storepass IAMUpgrade12c##
```
2. Enter keystore password  
The output looks like:
```
***************** WARNING WARNING WARNING *****************
* The integrity of the information stored in your keystore *
* has NOT been verified! In order to verify its integrity, *
* you must provide your keystore password.                 *
***************** WARNING WARNING WARNING *****************
Keystore type: jks
Keystore provider: SUNYour keystore contains 2 entries
Alias name: xeltrusted
Creation date: Dec 11, 2020
Entry type: trustedCertEntryOwner: CN=Customer, OU=Customer, O=Customer, L=City, ST=NY, C=US
Issuer: CN=Customer, OU=Customer, O=Customer, L=City, ST=NY, C=US
Serial number: a
Valid from: Fri Dec 11 20:30:53 GMT 2020 until: Mon Dec 09 20:30:53 GMT 2030
Certificate fingerprints:
 SHA1: AD:4D:22:19:6F:D1:D2 40:1B:59:20:23:A5:8B:69:99:A0:79:B9
 SHA256: 4C:7F:6B:D8:6A:3E:02:96:194D:B4:F7:C5:3F:C0:E3:54:04:44:0D:C3:4D:D1:BF:C3:B5:6A:6A:A8:DC:69
Signature algorithm name: MD5withRSA
Subject Public Key Algorithm: 1024-bit RSA key (weak)
Version: 1
**************************************************************************************
Alias name: xell
Creation date: Dec 11, 2020
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=Customer, OU=Customer, O=Customer, L=City, ST=NY, C=US
Issuer: CN=Customer, OU=Customer, O=Customer, L=City, ST=NY, C=US
Serial number: a
Valid from: Fri Dec 11 20:30:53 GMT 2020 until: Mon Dec 09 20:30:53 GMT 2030
Certificate fingerprints:
 SHA1: AD:4D:22:19:6F:D1:D2 40:1B:59:20:23:A5:8B:69:99:A0:79:B9
 SHA256: 4C:7F:6B:D8:6A:3E:02:96:194D:B4:F7:C5:3F:C0:E3:54:04:44:0D:C3:4D:D1:BF:C3:B5:6A:6A:A8:DC:69
Signature algorithm name: MD5withRSA
Subject Public Key Algorithm: 1024-bit RSA key (weak)
Version: 1
**************************************************************************************
Warning:
<xeltrusted> uses a 1024-bit RSA key which is considered a security risk. This key size will be disabled in a future update.
<xell> uses a 1024-bit RSA key which is considered a security risk. This key size will be disabled in a future update.
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore default-keystore.jks -destkeystore default-keystore.jks -deststoretype pkcs12".
```

3. Generate new keys using the keytool command
```
keytool -genkeypair -keystore /tmp/keystore/default-keystore.jks -keyalg RSA -validity 3600 -alias xell -dname "CN=wsidmhost.idm.oracle.com, OU=Identity, O=Oracle, C=US" -keysize 2048 -storepass IAMUpgrade12c## -keypass IAMUpgrade12c##
```

4. Generate Signing Cert
```
keytool -certreq -alias xell -file /tmp/keystore/xell.csr -keypass IAMUpgrade12c## -keystore /tmp/keystore/default-keystore.jks -storepass IAMUpgrade12c## -storetype jks
```  

5. Export cert
```
keytool -export -alias xell -file /tmp/keystore/xlserver.cert -keypass IAMUpgrade12c## -keystore /tmp/keystore/default-keystore.jks -storepass IAMUpgrade12c## -storetype jks
```

6. Trust the Cert
```
keytool -import -trustcacerts -alias xeltrusted -noprompt -file /tmp/keystore/xlserver.cert -keystore /tmp/keystore/default-keystore.jks -storepass IAMUpgrade12c##
```

7. Import Cert
```
keytool -importkeystore -srckeystore /tmp/keystore/default-keystore.jks -destkeystore /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/default-keystore.jks -srcstorepass IAMUpgrade12c## -deststorepass IAMUpgrade12c## -noprompt
```  

8. Move .cert and .csr
```
cp x*.* /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/
```  

9. Confirm keystore
```
updateskeytool -list -v -keystore /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/default-keystore.jks -storepass IAMUpgrade12c##
```

10. Update password for xell in EM to IAMUpgrade12c##
```
- Open EM console
- Navigate to Weblogic Domain > IAMGovernanceDomain
- Right click IAMGovernanceDomain
- Select Security > Credentials
- Highlight xell row
- Click Edit
- Update password
- Click OK
```  

### *Step 1.3:* Upgrade OIM/OAM from 11.1.2.3 to OIG/OAM 12.2.1.3

Use the Upgrade Advisor to upgrade OAM and OIM integrated environment. You will need to login with your Oracle support login credentials. The link to the MOS document is provided below:
- [Upgrade to 12c (12.2.1.3) Advisor For Integrated OAM / OIM Environments](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=318814815527407&id=2342931.2&_adf.ctrl-state=13r3ivrcxc_57)
- Navigate to *Step 4: configure*
- Navigate to *Upgrading Life Cycle Management Tool Setup Environments*
- Perform all the steps listed in the section to upgrade OAM
- Please note that *step 4*, needs to be done once for OIM and once for OAM

![](./images/step2.png " ")

### *Step 1.4:* Apply 12.2.1.3 patches mentioned in the Stack Patch Bundle:

Apply Stack Patch Bundle for Oracle Identity Management Products using the MOS document link provided below:
- [Stack Patch Bundle Page for OIG](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320313382903924&id=2657920.1&_adf.ctrl-state=13r3ivrcxc_110)  
- [Download and Apply SPB for 12.2.1.3](https://support.oracle.com/epmos/faces/PatchSearchResults?_adf.ctrl-state=r390fd14k_135&_afrLoop=321341144687003)

##  **STEP 2**: Upgrade IAM Components from 12.2.1.3 to 12.2.1.4

###  *Step 2.1:* Upgrade OUD from 12.2.1.3 to 12.2.1.4  
Upgrade OUD using the instructions in *section 6.4* of the documentation below  
- [Upgrade OUD 12.2.1.3 to 12.2.1.4](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.4/oudig/updating-oracle-unified-directory-software.html#GUID-506B9DAC-2FDB-47C9-8E00-CC1F99215E81)

### *Step 2.2:* Upgrade OAM 12.2.1.3 to 12.2.1.4:
Upgrade OAM using the Upgrade Advisor for OAM 12cR2 PS4 (OAM 12.2.1.4.0)  
- [Upgrade to Oracle Access Manager 12cR2 PS4](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320632596387945&id=2564763.2&_adf.ctrl-state=13r3ivrcxc_167)
- Navigate to *step 4: Configure* and select *Upgrade*

![](./images/step6.png " ")


### *Step 2.3:* Upgrade OIG 12.2.1.3 to 12.2.1.4  
Upgrade OIG using the Upgrade Advisor for OIG 12cR2 PS4 (OAM 12.2.1.4.0)  
- [Upgrade Advisor for Oracle Identity Governance/Oracle Identity Manager 12cR2 PS4](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320673956019924&id=2667893.2&_adf.ctrl-state=13r3ivrcxc_220)
 - Navigate to *step 4: Configure/Upgrade*

![](./images/step7.png " ")


### *Step 2.4:* Apply 12.2.1.4 patches mentioned in stack patch Bundle:

Apply Stack Patch Bundle for Oracle Identity Management Products using the MOS document link provided below:

- [Apply Stack Patch Bundle for Oracle Identity Management Products](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320313382903924&id=2657920.1&_adf.ctrl-state=13r3ivrcxc_110)
- [Download and Apply 12.2.1.4 SPB](https://support.oracle.com/epmos/faces/ui/patch/PatchDetail.jspx?parent=DOCUMENT&sourceId=2657920.1&patchId=32395452)


##  **STEP 3**: Integrate OIG and OAM using LDAP Connector

Configure OIG and OAM integration using the step by step instructions in *section 2.3* of the below documentation:
- [Configuring Oracle Identity Governance and Oracle Access Manager Integration](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/idmig/integrating-oracle-identity-governance-and-oracle-access-manager-using-ldap-connectors.html#GUID-9FD153DD-1497-4846-8D39-813B20E29B40)


##  **STEP 4**: Transition OHS to 12.2.1.4:

Follow the steps below to install and configure OHS:

- [Prepare and install OHS](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/wtins/preparing-install-and-configure-product.html#GUID-16F78BFD-4095-45EE-9C3B-DB49AD5CBAAD)

Configure OAM WebGate:

- Complete all 6 steps under *Configuring Oracle HTTP Server WebGate* in the following document.
    - [Configure WebGate](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/wgins/configuring-oracle-http-server-webgate-oracle-access-manager.html#GUID-79326DB8-CCB1-47F6-8CC2-80B6402C13FC)
- We will use the same agent profile as used in 11.1.2.3 - Webgate\_IDM\_11g
- Copy all the artifacts under *OAM\_DOMAIN\_HOME/output/OAM\_Webgate\_IDM11g* directory over to *OHSDOMAIN\_HOME/config/fmwconfig/components/OHS/ohs1/webgate/config* directory
- After the copy command, *OHSDOMAIN\_HOME/config/fmwconfig/components/OHS/ohs1/webgate/config* directory should have the following files and directories
```
- aaa_cert.pem

- aaa_key.pem

- cwallet.sso

- ObAccessClient.xml

- oblog_config_wg.xml

- password.xml

- wallet directory with cwallet.sso file

- Simple directory with aaa_cert.pem and aaa_key.pem
```

- If simple directory doesnt exist, Create one and copy the \*.pem files over

- Make the following changes in oamconsole,
```
- Navigate to oamconsole: Configuration/Settings/Access Manager Settings/Webgate Traffic Load Balancer/OAM Server port
- Change the port to OAM server port 14100

- Navigate to Oamconsole: Application Security/Agents/Webgate_IDM_11g
- Replace the existing User Defined Parameter contents with the below list,  

maxSessionTimeUnits=minutes
OAMRestEndPointHostName=wsidmhost.idm.oracle.com
client_request_retry_attempts=1
proxySSLHeaderVar=IS_SSL
inactiveReconfigPeriod=10
OAMRestEndPointPort=14100
URLInUTF8Format=true
OAMServerCommunicationMode=HTTP

```

- Increase Header size in OHS using this MOS documentation
  -- [How to Increase HTTP Header Size to Prevent Server Limit Errors](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=321479834906018&id=819301.1&_adf.ctrl-state=13r3ivrcxc_273)
```
- Add LimitRequestFieldSize 16380 to httpd.conf file after global server directive "KeepAlive"
```

- Start OHS server

##  **STEP 5**: Validate the IAM 12.2.1.4 Integrated environment

Test OAM and OIG using the steps in *section 2.4.7* in the documentation below
- [Functionally Testing the Access Manager and Oracle Identity Governance Integration](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/idmig/integrating-oracle-identity-governance-and-oracle-access-manager-using-ldap-connectors.html#GUID-3803AA41-A882-41C9-B1E8-0BBCBD581CE9)

### Example for OAM validation:

- Access [OAM Admin Server Console](http://wsidmhost.idm.oracle.com:7001/oamconsole) and login as *oamadmin*
    - Validates OAM Admin Server is functioning properly
- Access [OAM Server Console](http://wsidmhost.idm.oracle.com:14100/oam/server/logout)
    - Validates OAM server is running and successfully listening in HTTP port
- Access [OAM Server Console](http://wsidmhost.idm.oracle.com:7777/oam/server/logout)
    - Validates OHS proxy configuration to OAM server is working and also Webgate is functioning
- Run ```Netstat -a -n | grep 5575```
    - It should return LISTEN
    - Validates OAM server is listening on OAP port

### Example OIG validation:  

- Access the Oracle Identity Governance pagees with the following URL:
    - [Oracle Identity Self Service](http://wsidmhost.idm.oracle.com:7778/identity)
    - [Oracle Identity System Administration](http://wsidmhost.idm.oracle.com:7778/sysadmin)
- Verify the links for "Forgot Password", "Register New Account" and "Track User Registration" features appear in the login page and that they work.
- Log in to [Oracle Identity Self Service](http://wsidmhost.idm.oracle.com:7778/identity) as *xelsysadm*
- Create a new user
- Logout as *xelsysadm* and login as the user created in *step 4*.
    - When prompted for login, provide valid credentials for the newly-created user.
- Provide a new password and select three challenge question and answers.
    - The new user should now be logged in.
- Verify the lock/disable feature works by opening a new private browser and logging in as a *xelsysadm*
    - Now lock or disable the user account created in step 4.
- Now back in the broswer where the new user is logged try clicking on any new links, user should be redirected back to the login page.
- Verify the SSO logout feature works by logging out Oracle Identity Self Service page where *xelsysadm* is still logged out.
    - Upon logout from the page, you are redirected to the SSO logout page.


## Acknowledgements
* **Author** - Anbu Anbarasu, Director, Cloud Platform COE  
* **Contributors** -  Eric Pollard - Sustaining Engineering, Ajith Puthan - IAM Support  
* **Last Updated By/Date** - Anbu, COE, February 2021

## Need Help?
For all technical issues related to the IAM upgrade lab, please contact Oracle support through the same Proactive SR that was created to initiate this lab.  

For other issues, please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
