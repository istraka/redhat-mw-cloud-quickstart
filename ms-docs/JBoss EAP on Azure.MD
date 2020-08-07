---
title: Quickstart - JBoss EAP on Azure for enterprise Java applications
description: Deploy enterprise Java apps using JBoss EAP with Red Hat Enterprise Linux (RHEL) VM on Azure
author: SpektraSystems
ms.author: Theresa Nguyen
ms.topic: quickstart
ms.date: 07/30/2020
---

# Deploy enterprise Java applications to Azure with JBoss EAP on Red Hat Enterprise Linux

This quickstart shows you how to deploy [JBoss Enterprise (EAP)](https://www.redhat.com/en/technologies/jboss-middleware/application-platform) on [Red Hat Enterprise Linux (RHEL)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) to Azure Virtual Machines (VM) and Virtual Machine Scale Sets (VMSS). JBoss EAP is an open source application server platform that delivers enterprise-grade security, scalability, and performance. RHEL is an open source operating system (OS) platform, where you can scale existing apps and roll out emerging technologies across all environments. JBoss EAP and RHEL includes everything needed to build, run, deploy, and manage enterprise Java applications in any environment, including on-premises, virtual environments, and in private, public, or hybrid clouds.

## Prerequisites

* Azure Subscription - If you do not already have an account, you can activate your [MSDN subscriber benefits](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details/) or sign up for a [free account] (https://azure.microsoft.com/free/).

* To install JBoss EAP, you need to have a Red Hat Account and your Red Hat Subscription Management (RHSM) account needs EAP entitlement to use the Enterprise Application Platform. Set up an account on the [Red Hat Customer Portal](https://access.redhat.com/). If you don't have EAP entitlement, obtain a [JBoss EAP evaluation subscription](https://access.redhat.com/products/red-hat-jboss-enterprise-application-platform/evaluation) before you get started.

## Use case

Red Hat JBoss Enterprise Application Platform (JBoss EAP) 7.2 is a certified implementation of the Java Enterprise Edition (Java EE) 8 specification. JBoss EAP provides preconfigured options for features such as high-availability clustering, messaging, and distributed caching. It also enables users to write, deploy, and run applications using the various APIs and services that JBoss EAP provides.  For additional information on JBoss EAP visit [Introduction to JBoss EAP 7.2](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/introduction_to_jboss_eap/index#about_eap).

You can develop the following applications with JBoss EAP 7.2:

* Web Services Applications - Web services provide a standard means of interoperating among different software applications. Each application can run on a variety of platforms and frameworks. Web services facilitate internal, heterogeneous subsystem communication. To learn more about web service development visit [Developing Web Services](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/developing_web_services_applications/index).

* EJB Applications - Enterprise JavaBeans (EJB) 3.2 is an API for developing distributed, transactional, secure and portable Java EE applications through the use of server-side components called Enterprise Beans. Enterprise Beans implement the business logic of an application in a decoupled manner that encourages reuse. Learn more by visiting [Developing EJB Applications](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/developing_ejb_applications/index).

* Hibernate Applications - Developers and administrators can develop and deploy JPA/Hibernate applications with Red Hat JBoss Enterprise Application Platform. Hibernate Core is an object-relational mapping framework for the Java language. It provides a framework for mapping an object-oriented domain model to a relational database, allowing applications to avoid direct interaction with the database. Hibernate EntityManager implements the programming interfaces and lifecycle rules as defined by the [Java Persistence 2.1 specification](https://www.jcp.org/en/jsr/detail?id=338). Together with Hibernate Annotations, this wrapper implements a complete (and standalone) JPA persistence solution on top of the mature Hibernate Core. Additional information on [Developing Hiberate Applications](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/developing_web_services_applications/index) is available from Red Hat. 

## Configuration choice

For deployment of Red Hat Enterprise Linux (RHEL) VM you can either choose between Pay-As-You-Go (PAYG) or Bring-Your-Own-Subscription (BYOS). If you choose the VM image from the [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us) this defaults to a PAYG image.  If you have a RHEL OS that you want to use, then you can deploy a RHEL VM of BYOS license type and use your license to register for RHEL OS.

In addition to providing functionality and APIs to its applications, JBoss EAP has powerful management capabilities. These management capabilities differ depending on which operating mode is used to start JBoss EAP. JBoss EAP is supported on RHEL, Windows Server, and Oracle Solaris. JBoss EAP offers a standalone server operating mode for managing discrete instances and a managed domain operating mode for managing groups of instances from a single control point. Note that JBoss EAP managed domains are not supported in Microsoft Azure. The environment variable named *EAP_HOME* is used to denote the path to the JBoss EAP installation. 

- **Start JBoss EAP as a Standalone Server** - Following is the command to start EAP service in Standalone Mode.

    `$EAP_HOME/bin/standalone.sh`
    
    This startup script uses the EAP_HOME/bin/standalone.conf file, to set some default preferences, such as JVM options. Settings can be customized in this file. JBoss EAP uses the standalone.xml configuration file to start on Standalone mode by default, but can be started using a different mode. For details on the available standalone configuration files and how to use them, see the [Standalone Server Configuration Files](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/configuration_guide/jboss_eap_management#standalone_server_configuration_files) section. To start JBoss EAP with a different configuration, use the --server-config argument. For example:
    
    `$EAP_HOME/bin/standalone.sh --server-config=standalone-full.xml`
    
    For a complete listing of all available startup script arguments and their purposes, use the --help argument or see the [Server Runtime Arguments](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/configuration_guide/reference_material#reference_of_switches_and_arguments_to_pass_at_server_runtime) section.
    
JBoss EAP can also work in Cluster, please check [JBoss EAP Clustering](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/configuring_messaging/clusters_overview) to learn more. JBoss EAP messaging clusters allow groups of JBoss EAP messaging servers to be grouped together in order to share message processing load. Each active node in the cluster is an active JBoss EAP messaging server which manages its own messages and handles its own connections.

## Support and subscription notes

This quickstart is designed to give multiple choice in terms of RHEL OS licensing. 

- Red Hat Enterprise Linux OS as PAYG (Pay-As-You-Go) or BYOS (Bring-Your-Own-Subscription).
- Red Hat JBoss Enterprise Application Platform (EAP) is available through BYOS (Bring-Your-Own-Subscription) only.

#### Using RHEL OS with PAYG Model

By default the quickstart template uses the On-Demand Red Hat Enterprise Linux 7.7 Pay-As-You-Go (PAYG) image from the Azure Gallery. When using this On-Demand image, there is an additional hourly RHEL subscription charge for using this image on top of the normal compute, network and storage costs. At the same time, the instance will be registered to your Red Hat subscription, so you will also be using one of your entitlements. This will lead to "double billing". To avoid this, you would need to build your own RHEL image, which is defined in this [Red Hat KB article](https://access.redhat.com/articles/uploading-rhel-image-to-azure).

Check [Red Hat Enterprise Linux pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/red-hat/) for details on the RHEL VMs pricing for PAYG model. In order to use RHEL in PAYG model, you will need an Azure Subscription with the specified payment method (RHEL 7.7 is an [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/RedHat.RedHatEnterpriseLinux77-ARM?tab=Overview) product and requires a payment method to be specified in the Azure Subscription). 

#### Using RHEL OS with BYOS Model

In order to use BYOS for RHEL OS Licensing, you need to have a valid Red Hat subscription with entitlements to use RHEL OS in Azure. Please complete the following prerequisites in order to use RHEL OS through BYOS model before you deploy this quickstart template.

1. Ensure you have RHEL OS and JBoss EAP entitlements attached to your Red Hat Subscription.
2. Authorize your Azure Subscription ID to use RHEL BYOS images. Please follow [Red Hat Subscription Management documentation](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/con-enable-subs) to complete this process. This includes multiple steps including:

    2.1 Enable Microsoft Azure as provider in your Red Hat Cloud Access Dashboard.

    2.2 Add your Azure Subscription IDs.

    2.3 Enable new products for Cloud Access on Microsoft Azure.
    
    2.4 Activate Red Hat Gold Images for your Azure Subscription. Refer to [Red Hat Subscription Management](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/using_red_hat_gold_images#con-gold-image-azure) for more details.

    2.5 Wait for Red Hat Gold Images to be available in your Azure subscription. These are typically available within 3 hours.
    
3. Accept the Marketplace Terms and Conditions in Azure for the RHEL BYOS Images. You can complete this by running Azure CLI commands, as given below. Refer to [Red Hat Enterprise Linux BYOS Gold Images in Azure documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/redhat/byos) for more details on this.

    3.1 Launch an Azure CLI session and authenticate with your Azure account. Refer to [Signing in with Azure CLI](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest) for assistance.

    3.2 Verify the RHEL BYOS images are available in your subscription by running the following CLI command. If you don't get any results here, please refer to #2 and ensure that your Azure subscription is activated for RHEL BYOS images.

    `az vm image list --offer rhel-byos --all`

    3.3 Run the following command to accept the Marketplace Terms for RHEL 7.7 BYOS.

    `az vm image terms accept --publisher redhat --offer rhel-byos --plan rhel-lvm77`

4. Your subscription is now ready to deploy RHEL 7.7 BYOS virtual machines.

#### Using JBoss EAP with BYOS Model

JBoss EAP is available on Azure through BYOS model only; you need to supply your RHSM credentials along with RHSM pool id having valid EAP entitlements when deploying this template. If you don't have EAP entitlement, obtain a [JBoss EAP evaluation subscription](https://access.redhat.com/products/red-hat-jboss-enterprise-application-platform/evaluation) before you get started.
No additional steps are required for this.

## How to consume

You can deploy the template in three following ways :

- Using Powershell : You can use powershell to deploy the template by running the following commands. Please check Azure Powershell](https://docs.microsoft.com/en-us/powershell/azure/?view=azps-2.8.0) for information on installing and configuring Azure Powershell.  

    `New-AzResourceGroup -Name <resource-group-name> -Location <resource-group-location> #use this command when you need to create a new resource group for your deployment`

    `New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateUri <raw link to the template which can be obtained from github>`
    
- Using Azure CLI : You can use Azure CLI to deploy the template by running the following commands. Visit [Installing and Configuring Azure Cross Platform Command-Line](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) for additional information.

    `az group create --name <resource-group-name> --location <resource-group-location> #use this command when you need to create a new resource group for your deployment`

    `az group deployment create --resource-group <my-resource-group> --template-uri <raw link to the template which can be obtained from github>`

- Using Azure Portal : You can use Azure portal to deploy the template by going to the GitHub links mentioned below in *ARM Template* section and clicking on **Deploy to Azure** button.

## ARM template

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-standalone-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2 running on RHEL 7.7 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-standalone-rhel8" target="_blank"> JBoss EAP 7.2 on RHEL 8.0 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2 running on RHEL 8.0 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss73-eap-standalone-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.3 running on RHEL 8.0 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-multinode-singlevm-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (multi-node, single VM)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 running on multinode of RHEL 7.7 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-multinode-singlevm-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (multi-node, single VM)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 running on multinode of RHEL 8.0 VM.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-multivm-rhel7" target="_blank">JBoss EAP 7.2 on RHEL 7.7 (clustered, multi-VM)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on 'n' number RHEL 7.7 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-multivm-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (clustered, multi-VM)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on 'n' number of RHEL 8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap73-clustered-multivm-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (clustered, multi-VM)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.3 cluster running on 'n' number of RHEL 8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-vmss-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (clustered, VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on RHEL 7.7 VMSS instances.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-clustered-vmss-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (clustered, VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on RHEL 8.0 VMSS instances.

* <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap73-clustered-vmss-rhel8" target="_blank">JBoss EAP 7.3 on RHEL 8.0 (clustered, VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.3 cluster running on RHEL 8.0 VMSS instances.

## Resource Links:

Learn more about [JBoss EAP](https://developers.redhat.com/products/eap/download?sc_cid=701f2000000Rm3wAAC&gclid=CjwKCAjwqpP2BRBTEiwAfpiD--4IvtzM8fywpF7LklGMbg2VKhQOvMoihdl22EVPj8RRLDlt8z8QcRoCwOYQAvD_BwE&gclsrc=aw.ds)

## Next steps

To learn more about JBoss EAP 7.2, visit: https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/

To learn more about JBoss EAP 7.3, visit: https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/

To learn more about Red Hat Subscription Management (RHSM), visit: https://access.redhat.com/products/red-hat-subscription-management

To learn more about Red Hat on Azure, visit: https://azure.microsoft.com/en-us/overview/linux-on-azure/red-hat/

You can deploy Red Hat Enterprise Linux (RHEL) 7.7 on Azure from [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/RedHat.RedHatEnterpriseLinux77-ARM?tab=Overview)

You can deploy Red Hat Enterprise Linux (RHEL) 8.0 on Azure from [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/RedHat.RedHatEnterpriseLinux80-ARM?tab=Overview)

If you don't have a Red Hat subscription to install a JBoss EAP, you can go through WildFly instead of JBoss EAP:

*  <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/wildfly-standalone-centos8" target="_blank"> WildFly 18 on CentOS 8 (stand-alone VM)</a> - Standalone WildFly 18 with a sample web app on a CentOS 8 Azure VM.
