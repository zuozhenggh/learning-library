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

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.