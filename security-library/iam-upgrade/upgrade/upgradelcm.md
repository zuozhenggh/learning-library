# IAM 11.1.2.3 to 12.2.1.4 In-Place Upgrade

This section guides you through the steps to upgrade 11.1.2.3 LCM based OIM-OAM integrated environment with OUD as backend Directory Server &amp; OHS as webserver to 12.2.1.4

An Oracle Identity and Access Management deployment consists of a number of different components:
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

## About the In-Place Upgrade Strategy

There are different upgrade strategies that you can employ for an upgrade of Oracle Internet Directory, Oracle Unified Directory, and Oracle Identity and Access Management. The strategy you choose will depend mainly on your business needs. This lab uses a Multi-hop in-place upgrade outlined in the Upgrade strategies document :
[IAM Upgrade Strategies](https://docs.oracle.com/en/middleware/fusion-middleware/iamus/place-upgrade-strategies.html#GUID-9F906AE2-5BDF-426D-A97C-AC546ABFBD28)  


The in-place upgrade allows you to take your existing deployment and upgrade it in site.

- When performing an upgrade, you should make as few changes as possible in each stage to ensure that the upgrade is successful.
- For example, it is not recommended to perform multiple upgrade activities such as upgrading Oracle Identity and Access Management, changing the directory, updating the operating system, and so on, all at the same time.
- If you want to perform such an upgrade, you must do it in stages. You must validate each stage before moving on to the next. The benefit of this approach is that it helps you to identify precisely where the issue occurred, and correct it or undo it before you continue the exercise.  


Steps involved in the upgrade process are :

1. Upgrade IAM Components from 11.1.2.3 to 12.2.1.3
  - Upgrade OUD from 11.1.2.3 - 12.2.1.3
  - Upgrade OAM 11.1.2.3 - 12.2.1.3
  - Upgrade OIM 11.1.2.3 - 12.2.1.3
  - Apply OAM and OIM latest Stack patch Bundle for 12.2.1.3
2. Upgrade IAM Components from 12.2.1.3 to 12.2.1.4
  - Upgrade OUD from 12.2.1.3 - 12.2.1.4
  - Upgrade OAM 12.2.1.3 - 12.2.1.4
  - Upgrade OIM 12.2.1.3 - 12.2.1.4
  - Apply OAM and OIM latest Stack patch Bundle for 12.2.1.4
3. Integrate OIM and OAM using LDAP Connector
4. Transition OHS from 11.1.1.9 to 12.2.1.4
5. Validation of Integrated environment at 12.2.1.4


Documentation required (In the sequence of upgrade)

##  **STEP 1**: Upgrade IAM Components from 11.1.2.3 to 12.2.1.3

### 1.a: OUD upgrade from 11.1.2.3 to 12.2.1.3

[6.6 Upgrading an Existing Oracle Unified Directory Server Instance](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.3/oudig/updating-oracle-unified-directory-software.html#GUID-506B9DAC-2FDB-47C9-8E00-CC1F99215E81)

### 1.b:  Update the keystore encryption strength:

Specific Steps to update Keystore Encryption and change password for 12c upgrade

1. List current keystore contents
```
keytool -list -v -keystore /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/default-keystore.jks -storepass IAMUpgrade12c##
```
Enter keystore password:
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

2. Generate new keys
```
keytool -genkeypair -keystore /tmp/keystore/default-keystore.jks -keyalg RSA -validity 3600 -alias xell -dname "CN=wsidmhost.idm.oracle.com, OU=Identity, O=Oracle, C=US" -keysize 2048 -storepass IAMUpgrade12c## -keypass IAMUpgrade12c##
```

3. Generate Signing Cert
keytool -certreq -alias xell -file /tmp/keystore/xell.csr -keypass IAMUpgrade12c## -keystore /tmp/keystore/default-keystore.jks -storepass IAMUpgrade12c## -storetype jks

4. Export cert
keytool -export -alias xell -file /tmp/keystore/xlserver.cert -keypass IAMUpgrade12c## -keystore /tmp/keystore/default-keystore.jks -storepass IAMUpgrade12c## -storetype jks

5. Trust the Cert
keytool -import -trustcacerts -alias xeltrusted -noprompt -file /tmp/keystore/xlserver.cert -keystore /tmp/keystore/default-keystore.jks -storepass IAMUpgrade12c##

6. Import Cert
keytool -importkeystore -srckeystore /tmp/keystore/default-keystore.jks -destkeystore /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/default-keystore.jks -srcstorepass IAMUpgrade12c## -deststorepass IAMUpgrade12c## -noprompt

7. Move .cert and .csr
cp x*.* /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/

8. Confirm keystore updateskeytool -list -v -keystore /u01/app/oracle/config/domains/IAMGovernanceDomain/config/fmwconfig/default-keystore.jks -storepass IAMUpgrade12c##

9. Update password for xell in EM to IAMUpgrade12c##
EM console
Navigate to Weblogic Domain > IAMGovernanceDomain
Right click IAMGovernanceDomain
Select Security > Credentials
Highlight xell row
Click Edit
Update password
Click OK

### 1.c: Upgrade OIM and OAM from 11.1.2.3 upgrade to 12.2.1.3

Navigate to [Upgrade to 12c (12.2.1.3) Advisor For Integrated OAM / OIM Environments](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=318814815527407&id=2342931.2&_adf.ctrl-state=13r3ivrcxc_57)
- Navigate to Step 4: configure
- Navigate to "Upgrading Life Cycle Management Tool Setup Environments"
- Perform all steps listed to upgrade OAM
- Please note that Step 4, needs to be done one time for OIM and one time OAM

![](./images/step2.png " ")

### 1.d: Apply 12.2.1.3 patches mentioned in stack patch Bundle:

[Apply Stack Patch Bundle for Oracle Identity Management Products](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320313382903924&id=2657920.1&_adf.ctrl-state=13r3ivrcxc_110)
[Download and Apply 12.2.1.3 SPB](https://support.oracle.com/epmos/faces/PatchSearchResults?_adf.ctrl-state=r390fd14k_135&_afrLoop=321341144687003)

##  **STEP 2**: Upgrade IAM Components from 12.2.1.3 to 12.2.1.4

###  2.a: OUD upgrade from 12.2.1.3 to 12.2.1.4
[Upgrade OUD 12.2.1.3 to 12.2.1.4](https://docs.oracle.com/en/middleware/idm/unified-directory/12.2.1.4/oudig/updating-oracle-unified-directory-software.html#GUID-506B9DAC-2FDB-47C9-8E00-CC1F99215E81)

### 2.b: OAM 12.2.1.3 Upgrade to 12.2.1.4:

[Upgrade Advisor for Oracle Access Manager 12cR2 PS4 (OAM 12.2.1.4.0)](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320632596387945&id=2564763.2&_adf.ctrl-state=13r3ivrcxc_167)
- Navigate to Step 4: Configure/Upgrade

![](./images/step6.png " ")


### 2.c: OIM 12.2.1.3 to 12.2.1.4

 [Upgrade Advisor for Oracle Identity Governance/Oracle Identity Manager 12cR2PS4 (OIM 12.2.1.4.0)](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320673956019924&id=2667893.2&_adf.ctrl-state=13r3ivrcxc_220)
 - Navigate to Step 4: Configure/Upgrade

![](./images/step7.png " ")


### 2.d: Apply 12.2.1.4 patches mentioned in stack patch Bundle:

[Apply Stack Patch Bundle for Oracle Identity Management Products](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=320313382903924&id=2657920.1&_adf.ctrl-state=13r3ivrcxc_110)
[Download and Apply 12.2.1.4 SPB](https://support.oracle.com/epmos/faces/ui/patch/PatchDetail.jspx?parent=DOCUMENT&sourceId=2657920.1&patchId=32395452)


##  **STEP 3**: For OIM 12.2.1.4 Integration steps

[2.3 Configuring Oracle Identity Governance and Oracle Access Manager Integration](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/idmig/integrating-oracle-identity-governance-and-oracle-access-manager-using-ldap-connectors.html#GUID-9FD153DD-1497-4846-8D39-813B20E29B40)


##  **STEP 4**: Transition OHS to 12.2.1.4:

OHS fresh Install and configuration:

[https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/wtins/preparing-install-and-configure-product.html#GUID-16F78BFD-4095-45EE-9C3B-DB49AD5CBAAD](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/wtins/preparing-install-and-configure-product.html#GUID-16F78BFD-4095-45EE-9C3B-DB49AD5CBAAD)

OAM WebGate:

- Complete all 6 steps under &quot;Configuring Oracle HTTP Server WebGate&quot; in the above document.
  - WebGate Install Document: [https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/wgins/configuring-oracle-http-server-webgate-oracle-access-manager.html#GUID-79326DB8-CCB1-47F6-8CC2-80B6402C13FC](https://docs.oracle.com/en/middleware/fusion-middleware/12.2.1.4/wgins/configuring-oracle-http-server-webgate-oracle-access-manager.html#GUID-79326DB8-CCB1-47F6-8CC2-80B6402C13FC)
- We will use the same agent profile as used in 11.1.2.3 - Webgate\_IDM\_11g
  - Copy all the artifacts under OAM\_DOMAIN\_HOME/output/OAM\_Webgate\_IDM11g directory over to OHSDOMAIN\_HOME/config/fmwconfig/components/OHS/ohs1/webgate/config directory
  - After the copy command, OHSDOMAIN\_HOME/config/fmwconfig/components/OHS/ohs1/webgate/config directory should have the following files and directories
```
- aaa\_cert.pem

- aaa\_key.pem

- cwallet.sso

- ObAccessClient.xml

- oblog\_config\_wg.xml

- password.xml

- wallet directory with cwallet.sso file

- Simple directory with aaa\_cert.pem and aaa\_key.pem
```

- If simple directory doesn&#39;t exist, Create one and copy the \*.pem files over

- Make the following changes in oamconsole,
```
oamconsole \&gt; Configuration \&gt; Settings \&gt; Access Manager Settings \&gt; Webgate Traffic Load Balancer \&gt; OAM Server port \&gt; Change this to OAM server port 14100

Oamconsole \&gt; Application Security \&gt; SSO Agents \&gt; Webgate\_IDM\_11g
```
- Replace the existing User Defined Parameter contents with the below list,
```
maxSessionTimeUnits=minutes

OAMRestEndPointHostName=wsidmhost.idm.oracle.com

client\_request\_retry\_attempts=1

proxySSLHeaderVar=IS\_SSL

inactiveReconfigPeriod=10

OAMRestEndPointPort=14100

URLInUTF8Format=true

OAMServerCommunicationMode=HTTP
```

- Increase Header size in OHS
  -- [Refer to KBA: How to Increase HTTP Header Size to Prevent Server Limit Errors](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=321479834906018&id=819301.1&_adf.ctrl-state=13r3ivrcxc_273)
```
Add

LimitRequestFieldSize 16380

To httpd.conf file after global server directive &quot;KeepAlive&quot;
```

- Start OHS server

##  **STEP 5**: Validation

- [Follow steps in 2.4.7 chapter](https://docs.oracle.com/en/middleware/idm/suite/12.2.1.4/idmig/integrating-oracle-identity-governance-and-oracle-access-manager-using-ldap-connectors.html#GUID-3803AA41-A882-41C9-B1E8-0BBCBD581CE9)

Example for OAM validation:

1. Access [http://wsidmhost.idm.oracle.com:7001/oamconsole](http://wsidmhost.idm.oracle.com:7001/oamconsole) login as oamadmin

Validates OAM Admin Server is functioning properly

2. Access [http://wsidmhost.idm.oracle.com:14100/oam/server/logout](http://wsidmhost.idm.oracle.com:14100/oam/server/logout)

Validates OAM server is running and successfully listening in HTTP port

3. Access [http://wsidmhost.idm.oracle.com:7777/oam/server/logout](http://wsidmhost.idm.oracle.com:7777/oam/server/logout)

Validates OHS proxy configuration to OAM server is working and also Webgate is functioning

4. Netstat -a -n | grep 5575

5. It should return LISTEN

Validates OAM server is listening in OAP port

## Acknowledgements
* **Author** - Anbu Anbarasu, Director, Cloud Platform COE  
* **Contributors** -  Eric Pollard - Sustaining Engineering, Ajith Puthan - IAM Support  
* **Last Updated By/Date** - Anbu, COE, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/goldengate-on-premises). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
