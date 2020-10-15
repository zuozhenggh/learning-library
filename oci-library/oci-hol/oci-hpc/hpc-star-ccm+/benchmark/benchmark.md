## **Benchmark Example**

<img src="images/lemans.png" alt="marketplace" width="700" style="vertical-align:middle;margin:0px 50px"/>

Performances of STAR-CCM+ are often measured using the LeMans benchmark with 17 and 105 Millions cells. The next graphs are showing how using more nodes impact the runtime, with a scaling really close to 100%. RDMA network, which has not been discussed in this runbook, only start to differentiate versus regular TCP runs if the Cells / Core ratio starts to go down.

**17 Million Cells**

<img src="images/RunTime_17M.png" alt="marketplace" width="700" style="vertical-align:middle;margin:0px 50px"/>

**105 Million Cells**

<img src="images/Scaling_105M.png" alt="marketplace" width="700" style="vertical-align:middle;margin:0px 50px"/>

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.