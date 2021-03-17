# 19c Active Data Guard Fundamentals

## Introduction

Oracle Data Guard provides a comprehensive set of services that create, maintain, manage, and monitor one or more standby databases to enable production Oracle databases to survive disasters and data corruptions. Oracle Data Guard maintains these standby databases as copies of the production database. Then, if the production database becomes unavailable because of a planned or an unplanned outage, Oracle Data Guard can switch any standby database to the production role, minimizing the downtime associated with the outage. Oracle Data Guard can be used with traditional backup, restoration, and cluster techniques to provide a high level of data protection and data availability. Oracle Data Guard transport services are also used by other Oracle features such as Oracle Streams and Oracle GoldenGate for efficient and reliable transmission of redo from a source database to one or more remote destinations.

Oracle (Active) Data Guard capabilities in Oracle Database 19c further enhance its strategic objective
of preventing data loss, providing high availability, eliminating risk, and increasing return on investment
by enabling highly functional active disaster recovery systems that are simple to deploy and manage.
It accomplishes this by providing the management, monitoring, and automation software infrastructure
to create and maintain one or more synchronized standby databases that protect Oracle data from
failures, data corruption, human error, and disasters.

Insert screenshot

### Prerequisites
* Oracle Cloud Account - Free Tier, Paid or LiveLabs

### About this Workshop
In this LiveLab you will perform the following actions to setup Active Data Guard in the Oracle Cloud.
- Create primary and standby database
- add rest of workshops here

## Disclaimer 
The following is intended to outline our general product direction. It is intended for information purposes only, and may not be incorporated into any contract. It is not a commitment to deliver any material, code, or functionality, and should not be relied upon in making purchasing decisions. The development, release, and timing of any features or functionality described for Oracle’s products remains at the sole discretion of Oracle.


## Acknowledgements

**Author** - Pieter Van Puymbroeck, Product Manager Data Guard, Active Data Guard and Flashback Technologies
**Contributors** - Robert Pastijn, Database Product Management
**Last Update By** - Kamryn Vinson, March 2021