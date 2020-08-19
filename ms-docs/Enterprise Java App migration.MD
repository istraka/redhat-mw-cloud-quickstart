---
title: Quickstart - JBoss EAP to Azure VM and VMSS
description: This guide provides information on how to migrate your enterprise Java applications to JBoss EAP and from on-premises to Azure Linux VM and VMSS.
author: theresa-nguyen
ms.author: bicnguy
ms.topic: quickstart
ms.date: 08/14/2020
---

# Migrate Java apps to JBoss EAP on Azure VM and VMSS

This guide provides information on how to migrate your enterprise Java applications to [JBoss Enterprise Application Platform (EAP)](https://www.redhat.com/en/technologies/jboss-middleware/application-platform) and from on-premises to Azure Linux Virtual Machines (VM) and Virtual Machine Scale Set (VMSS) if your cloud strategy is "Lift and Shift" of applications as-is.  However, if you want to "Lift and Optimize" then alternatively you can migrate your containerized applications to [Azure Red Hat OpenShift (ARO)](https://azure.microsoft.com/services/openshift/) with JBoss EAP images from the Red Hat Gallery, or to Azure App Service on Linux.

# Best practice starting with Azure Marketplace offers

Red Hat and Microsoft have partnered to bring a set of Azure solution templates to the Azure Marketplace to provide a solid starting point for migrating to Azure. Consult the documentation for the list of offers and choose the one that most closely matches your existing deployment.

We have 6 Marketplace offers for JBoss EAP on Azure RHEL VM as follows :

* JBoss EAP 7.2 on RHEL 7.7 VM(BYOS)
* JBoss EAP 7.2 on RHEL 7.7 VM(PAYG)
* JBoss EAP 7.2 on RHEL 8.0 VM(BYOS)
* JBoss EAP 7.2 on RHEL 8.0 VM(PAYG)
* JBoss EAP 7.3 on RHEL 8.0 VM(BYOS)
* JBoss EAP 7.3 on RHEL 8.0 VM(PAYG)

We have the following solution templates in Azure QuickStart templates GitHub Repository. These contain JBoss EAP on Standalone RHEL VM, clustered RHEL VMs and clustered RHEL VMSS.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap72-standalone-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2 running on RHEL 7.7 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap72-standalone-rhel8" target="_blank"> JBoss EAP 7.2 on RHEL 8.0 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2 running on RHEL 8.0 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap73-standalone-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.3 running on RHEL 8.0 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-multivm-rhel7" target="_blank">JBoss EAP 7.2 on RHEL 7.7 (clustered VMs)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on 'n' number RHEL 7.7 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-multivm-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (clustered VMs)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on 'n' number of RHEL 8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap73-clustered-multivm-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (clustered VMs)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.3 cluster running on 'n' number of RHEL 8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-vmss-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (clustered VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on RHEL 7.7 VMSS instances.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-vmss-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (clustered VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on RHEL 8.0 VMSS instances.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap73-clustered-vmss-rhel8" target="_blank">JBoss EAP 7.3 on RHEL 8.0 (clustered VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.3 cluster running on RHEL 8.0 VMSS instances.

## Prerequisites, app server and OS versions 

**Prerequisites**

* An Azure account with an active subscription. If you don't have an Azure subscription, you can activate your [MSDN subscriber benefits](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details) or [create an account for free](https://azure.microsoft.com/pricing/free-trial).

* Red Hat Subscription with JBoss EAP entitlement - You need to have a Red Hat Account and your Red Hat Subscription Management (RHSM) account must have JBoss EAP entitlement to download Red Hat tested and certified JBoss EAP version.  If you don't have EAP entitlement, obtain a [JBoss EAP evaluation subscription](https://access.redhat.com/products/red-hat-jboss-enterprise-application-platform/evaluation) before you get started. If you would like to create a new Red Hat subscription, go to [Red Hat Customer Portal](https://access.redhat.com/) and set up an account.

* Java source code and JDK

* [Java application based on JBoss EAP 7.2](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/development_guide/index#become_familiar_with_java_enterprise_edition_8) or [Java application based on JBoss EAP 7.3](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/development_guide/index#get_started_developing_applications)

* RHEL options - Choose between Pay-As-You-Go (PAYG) or Bring-Your-Own-Subscription (BYOS). For BYOS, you will need to activate your [Red Hat Cloud Access](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html-single/red_hat_cloud_access_reference_guide/index) RHEL Gold Image.


**Product version**

* [JBoss EAP 7.2](https://access.redhat.com/documentation/red_hat_jboss_enterprise_application_platform/7.2/)
* [JBoss EAP 7.3](https://access.redhat.com/documentation/red_hat_jboss_enterprise_application_platform/7.3/)
* [RHEL 7.7 VM](https://azuremarketplace.microsoft.com/marketplace/apps/RedHat.RedHatEnterpriseLinux77-ARM?tab=Overview)
* [RHEL 8.0 VM](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/RedHat.RedHatEnterpriseLinux80-ARM?tab=Overview)

## Migration Flow and Architecture

### Other Application Server to Red Hat JBoss EAP
Before you start migrating your applications from previous versions of Red Hat JBoss EAP, you need to be very well informed about the new features available in this release, the deprecated and unsupported features, and any application and server configuration updates that might be required to prevent changes in application behavior. Once the application is successfully deployed and running, plans can be made to upgrade individual components to use the new functions and features of JBoss EAP 7.

- [**JBoss EAP migration tool**](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/migration_guide/index#migration_tool_server_migration_tool) - The JBoss Server Migration Tool is the preferred method to update your server configuration to include the new features and settings in JBoss EAP 7 while keeping your existing configuration. The JBoss Server Migration Tool reads your existing JBoss EAP server configuration files and adds configurations for any new subsystems, updates the existing subsystem configurations with new features, and removes any obsolete subsystem configurations.

### Phases of on-premises to Azure migrations
Azure Marketplace offer of JBoss EAP on RHEL will install and provision on Azure VM very easily your Azure subscription. The Azure marketplace offers you plans with JBoss EAP (7.2/7.3) on RHEL VM (7.7/8.0) as mentioned in the [Best practice starting with Azure Marketplace offers](#best-practice-starting-with-azure-marketplace-offers) earlier.

You can also refer and use the templates in Azure QuickStart templates GitHub Repository mentioned in the [Best practice starting with Azure Marketplace offers](#best-practice-starting-with-azure-marketplace-offers) to build your infrastructure environment. Here you can deploy clustered environment as well which will have a Load Balancer (LB), Private IP for LB and VMs/VMSS, Virtual Network (VNET) with a single subnet, and a sample Java app.

If you need to access your on-premises services, you'll need to provision one of Azure's connectivity services. For more information, see [Choose a solution for connecting an on-premises network to Azure](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/).

Following are the phases of on-premises to Azure Migration process

- **Discovery**
- **Cloud assessment**
- **Proof of concept**
- **Application migration**
- **Data migration**
- **Cloud operation**

### Source stack

### Target stack

- [**Azure Virtual Machine**](https://azure.microsoft.com/overview/what-is-a-virtual-machine/)
- [**Azure Virtual Machine Scale Set**](https://docs.microsoft.com/azure/virtual-machine-scale-sets/overview)
- [**Azure Storage**](https://docs.microsoft.com/azure/storage/common/storage-introduction)
- [**Azure SQL**](https://docs.microsoft.com/azure/azure-sql/) **or** [**PostgreSQL service**](https://docs.microsoft.com/azure/postgresql/)

### Target architecture


## Tools

- **Para**
- **Workload Builder**
- **Azure Migration Service and Programs**
- **Red Hat Migration Service and Programs**
- **Guideline**

## Epic (optional)

- **Plan the migration**
- **Configure the infrastructure**
- **Migrate data**
- **Migrate application**
- **Cut over**
- **Close the project**

## Resource Links

* Learn more about [JBoss EAP](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/getting_started_with_jboss_eap_for_openshift_online/introduction)
* Learn more about [Red Hat Subscription Manager (Cloud Access)](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html-single/red_hat_cloud_access_reference_guide/index)
* Learn more about [Azure Virtual Machines](https://azure.microsoft.com/overview/what-is-a-virtual-machine/)
* Learn more about [Azure Virtual Machine Scale Set](https://docs.microsoft.com/azure/virtual-machine-scale-sets/overview)
* Learn more about [Azure Red Hat OpenShift](https://azure.microsoft.com/services/openshift/)
* Learn more about [Azure App Service on Linux](https://docs.microsoft.com/azure/app-service/overview#app-service-on-linux)
* Learn more about [Azure Storage](https://docs.microsoft.com/azure/storage/common/storage-introduction)
* Learn more about [Azure Networking](https://docs.microsoft.com/azure/networking/networking-overview)

## Support

For any support related questions, issues or customization requirements, please contact [Red Hat Support](https://access.redhat.com/support).
