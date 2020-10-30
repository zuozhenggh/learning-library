# Workshop Introduction and Overview                                    

This lab describes how to install and configure the Oracle GoldenGate Veridata.
For proof-of-concept, you can install the following on one host: Oracle WebLogic Server, Fusion Middleware Infrastructure, and Oracle GoldenGate Veridata.

## What do you Need?
+ **Linux**
+ **Oracle Database 19c (19.3.0.0) (for the repository)**
+ **Java 1.8 or higher**
+ **[Oracle GoldenGate Software](https://www.oracle.com/middleware/technologies/goldengate-downloads.html)**

## **Step 1:** Install and Configuring the Back End Servers and Infrastructure
In a nutshell, the installation process includes the following four major tasks. After completing these steps, you can configure the Oracle GoldenGate Veridata Agents.
1. WebLogic Server and Infrastructure file needed for Oracle GoldenGate Veridata. Install the WebLogic Server infrastructure (formerly known as JRF) files on top of an existing 12.2.1.4.0 WebLogic Server install. Invoke this by using the command: `java -jar fmw_12.2.1.4.0_infrastructure_generic.jar`.
2. Oracle GoldenGate Veridata Server + Oracle GoldenGate Veridata Agent. It is a jar file, and works on all supported platforms except NonStop. Select a required combination. For this lab, the choice was **complete** to get everything installed in one pass. Invoke this by using the command: `java -jar fmw_12.2.1.4.0_ogg.jar`.
3. Run the Repository Creation Utility (RCU). It gets installed as a part of the WLS+JRF install in Step 1. You can run it once for all the products (WebLogic Server and Oracle GoldenGate Veridata.) The RCU location in this demo (and the sample VM) is: `/u01/app/oracle/product/wls/oracle_common/bin/rcu`.
4. Configure the Oracle WebLogic Server and Oracle GoldenGate Veridata domains. You can run this once for all products. To configure the WebLogic Server, use the command: `/u01/app/oracle/product/wls/oracle_common/common/bin/config.sh`.

## **Step 2:** Install the Fusion Middleware Infrastructure
1. Open a terminal session. Run the following command: `java -jar fmw_12.2.1.4.0_infrastructure_generic.jar`
    ![](./images/1FMW_Welcome_screen1.png " ")
2. Click **Next** to continue to the **Auto Updates** section. Leave the default option **Skip Auto Updates** selected and click **Next**.
    ![](./images/2FMWScreen2_AutoUpdatesPNG.png " ")
3. Enter a location for Oracle Home to store the binary files.
    ![](./images/3FMWScreen3_InstallationLocation.png " ")
4. Click **Next** to continue.
5. Select either installation type (Fusion Middleware infrastructure With Examples or Fusion Middleware Infrastructure). Towards the end of this step, the Oracle WebLogic Server gets installed.
    ![](./images/4FMWScreen4_InstallationType.png " ")
6. Wait for the progress bar to reach 100%. The Java version required is 1.7 or higher. Click **Next** to continue to the **Prerequisistes Checks** screen.
    ![](./images/5FMWScreen5_PrerequisitesChecks.png " ")
7. Click **Next** to continue to the **Installation Summary** screen.
    ![](./images/6FMWScreen6_InstallationSummary.png " ")
8. On the **Installation Summary** screen, click **Next** to display the **Installation Progress** panel.
    ![](./images/7FMWScreen7_InstallationProgress.png " ")
9. Click **Install** to continue and wait for the progress bar to reach 100%. You can optionally view the logs.
10. Click **Next** to display the **Installation Complete** section.
    ![](./images/8FMWScreen8_InstallationComplete.png " ")
11. Click **Finish**.

## **Step 4**: Install Oracle GoldenGate Veridata
To install and configure Oracle GoldenGate Veridata:
1. Open the terminal session and run the installer with the following command: `java -jar fmw_12.2.1.4.0_ogg.jar` to display the splash screen.
    ![](./images/9VeridataInstall_Welcome1.png " ")
    The splash screen disappears when the progress bar reaches 100% to display the **Welcome** screen.
2. After you have read the instructions on the **Welcome** screen, click **Next** to continue to the **Auto Updates** screen.
    ![](./images/10VeridataInstall_Welcome2.png " ")
3. Click **Next** to continue to the **Auto Updates** section. Leave the default option **Skip Auto Updates** selected and click **Next**.
    ![](./images/11VeridataInstall_AutoUpdates_Screen3.png " ")
4. Enter the same Oracle Home directory that you entered in **Step 1 > 3**.
    ![](./images/12VeridataInstall_InstallLocation_Screen4.png " ")
5. Click **Next** to continue and display the **Installation Type** screen.
    ![](./images/13VeridataInstall_InstallType_Screen5.png " ")
6. Select the Oracle GoldenGate Veridata options that you want to install, or select **Complete Install** to get them all.
7. Click **Next** to continue to the **Prerequisites Check** screen.
    ![](./images/14VeridataInstall_PrereqChecks_Screen6.png " ")

8. After the progress bar has reached 100%, click **Next** to display the **Installation Summary** screen.
    ![](./images/15VeridataInstall_InstallationSummary_Screen7.png " ")
9. Click **Install** to continue and display the **Installation Progress** screen and wait for the progress bar to reach 100%. You can also view the logs.
    ![](./images/16VeridataInstall_InstallProgress_Screen8.png " ")
10. Click **Next** to continue to the **Installation Complete** screen. Note that the **Next Steps** that are required to run the Repository Creation Utility (RCU) and then run the Configuration Wizard, are mentioned in the **Installation Complete** screen.
    ![](./images/17VeridataInstall_InstallComplete_Screen9.png " ")
## **Step 5**: Configure RCU  

## Want to Learn More About Oracle GoldenGate Veridata?


* [Oracle GoldenGate Veridata (12.2.1.4.0) Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Oracle GoldenGate Documentation](https://docs.oracle.com/en/middleware/goldengate/index.html)
* [Overview of Oracle Fusion Middleware](https://docs.oracle.com/en/middleware/fusion-middleware/index.html)
* [Oracle WebLogic Server](https://docs.oracle.com/en/middleware/fusion-middleware/weblogic-server/12.2.1.4/index.html)


## Acknowledgements

* **Authors:**
    + Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate Documentation
* **Reviewed by:**
      + Apeksha Polnaya, Senior Manager, Software Development, GoldenGate Development
      + Sukin Varghese, Senior Member of Technical staff, Database Testing
* **Last Updated By/Date:** Anuradha Chepuri, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
