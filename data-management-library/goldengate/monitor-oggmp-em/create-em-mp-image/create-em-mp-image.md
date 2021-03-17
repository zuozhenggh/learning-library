# Monitor the Oracle GoldenGate Marketplace Instance using the Enterprise Marketplace Instance

## Introduction



### What Do You Need?

+ **You have gone through the Introduction Lab and Prerequisites**


**STEP 1**: Open all the Oracle GoldenGate Services Port from the OCI Console

**STEP 2:** Open all the Proxy port on Oracle GoldenGate Microservices Marketplace Instance

**STEP 3:** Discover Oracle GoldenGate Microservices Instances in Oracle Enterprise Manager on Marketplace
After you have created an Enterprise Manager instance on Marketplace, you can discover the Oracle GoldenGate Instances on the OCI UI:
  To discover Oracle GoldenGate Microservices instances:
  1. Click **Set up**, select **Add Target**, and click **Configure Auto Discovery**.
      ![](./images/1.png " ")
  2. On the **Targets on Host** tab, select the Enterprise Manager instance, and click **Discovery Modules** to display the **Discovery Modules** page.
      ![](./images/2SelectEMinstance.png " ")
  3. Click Oracle GoldenGate Microservices and then click **Edit Parameters** to display the **Edit Parameters** dialog box.
      ![](./images/3.png " ")
  4. Enter the following details and click **OK**:

      * **Service Manager Hostname**
      * **Service Manager Username**
      * **Service Manager Password**
      * **Service Manager Port**
        [](./images/4.png " ")
  5. Click **OK** again to display the **Setup Discovery** page and click **Discover Now**.
        ![](./images/5SelectEMAgent.png " ")

      The targets are discovered and the control is now back on the **Targets on Host** page. Notice  the change in the number of targets discovered under the **Discovered Targets** column.

        ![](./images/6DiscoveredTargets.png " ")
  6. Click the number under **Discovered Targets**  

## Want to Learn More?
* [Oracle GoldenGate Enterprise Manager Plug-in Documentation](https://docs.oracle.com/en/middleware/goldengate/emplugin/13.4.2/index.html)
* [Discovering Oracle GoldenGate Targets](https://docs.oracle.com/en/middleware/goldengate/core/19.1/oggmp/oracle-goldengate-classic-oracle.html#GUID-8D2728DA-9A05-439F-B2D4-4CFF8D70236D)
* [A Simple Guide to Oracle GoldenGate Enterprise Manager Plug-in -Blog](https://blogs.oracle.com/dataintegration/a-simple-guide-to-oracle-goldengate-enterprise-manager-plug-in)
* [New Route to Discovery in Oracle GoldenGate Enterprise Manager Plug-in 13.4.2](https://blogs.oracle.com/dataintegration/new-route-to-discovery-in-oracle-goldengate-enterprise-manager-plug-in)
## Acknowledgements

* **Author:**
    + Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Reviewed by:**
    + Nisharahmed Soneji, Senior Principal Product Manager, GoldenGate Development
    + Sarvanan Vetrivel, Senior Member of Technical staff, Database Test Dev/Tools/Platform Testing

* **Last Updated By/Date:** Anuradha Chepuri, March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*. Please include your workshop name and lab name.  You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
