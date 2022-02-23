# Introduction

## About this Workshop

This workshop will help you understand what is Event Mesh using two message brokers and the technical capabilities inside the Converged Oracle Database to support a scalable event-driven microservices architecture.

You will create four event-driven microservice and two messaging brokers to allow the communication between them. In the first Lab you will create an Apache Kafka Broker, as the event broker for two microservices to communicate, written in Spring Boot. The second Lab will create an Oracle Transactional Event Queues (TEQ) and show the Kafka APIs working in the Kafka compatibility mode. Also, this module has the same Spring Boot producer and consumer microservices but with Kafka Java client for TEQ, using the okafka library. And finally, the third one will experience the concept of Event Mesh building a bridge between the both brokers with messages being produced on the Kafka side and consumed on the TEQ side.

Estimated Workshop Time: 50 minutes

### About Product/Technology

* [Oracle Transactional Event Queues](https://docs.oracle.com/en/database/oracle/oracle-database/21/adque/index.html) is a powerful messaging backbone offered by Converged Oracle Database, that allow you to build a enterprise class data-centric microservices architecture.

* [Kafka](https://kafka.apache.org)  is an open-source distributed event streaming platform used for high-performance data pipelines, streaming analytics, data integration, and mission-critical applications.

* [okafka](https://docs.oracle.com/en/database/oracle/oracle-database/21/adque/Kafka_cient_interface_TEQ.html#GUID-94589C97-F323-4607-8C3A-10A0EDF9DA0D) library, contains Oracle specific implementation of Kafka Client Java APIs. This implementation is built on AQ-JMS APIs.

* The applications will be deployed on [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/) [Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm) using pre-installed Docker Engine.

### Objectives

* The first lab reviews the Kafka and Spring Boot Microservice built to produce and consume messages.

* The second lab will use Oracle Transactional Event Queues (TEQ) and okafka library, and demonstrate the Kafka compatibility of TEQ. Also, this module has the same Spring Boot producer and consumer microservices but using okafka in place of Kafka libraries, and TEQ in the database in place of Kafka broker.

* The third lab will create the bridge between Kafka broker and Oracle Transactional Event Queues (TEQ), using Kafka connector and Oracle Database Messaging libraries, to demonstrate the flux of event produced on the Kafka side, moving to TEQ and being consumed at the TEQ side. This is the beginning experience of the Event Mesh approach.

### Prerequisites

* This workshop assumes you have an Oracle cloud account and have signed into the account.

## Event Mesh Architecture Overview

![Kafka and Oracle TEQ Event Mesh](images/kafka-oracle-teq-event-mesh.png " ")

As shown in the diagram above, we have:

* A Kafka Broker and a set of services consuming and producing for it.

* An Oracle TEQ Broker with another set of services around it.

* And connector between Kafka and Oracle TEQ enabling a communication path between them.

You may now **proceed to the next lab.**

## Want to Learn More?

* [Multitenant Database–Oracle 19c](https://www.oracle.com/database/technologies/multitenant.html)
* [Oracle Transactional Event Queues](https://docs.oracle.com/en/database/oracle/oracle-database/21/adque/index.html)
* [Microservices Architecture with the Oracle Database](https://www.oracle.com/technetwork/database/availability/trn5515-microserviceswithoracle-5187372.pdf)
* [https://developer.oracle.com/](https://developer.oracle.com/)

## Acknowledgements

* **Authors** - Paulo Simoes, Developer Evangelist; Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Contributors** - Mayank Tayal, Developer Evangelist; Sanjay Goil, VP Microservices and Oracle Database
* **Last Updated By/Date** - Paulo Simoes, December 2021
