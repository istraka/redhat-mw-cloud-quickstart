---
title: Quickstart - WildFly on CentOS
description: Deploy WildFly on a CentOS VM
author: SpektraSystems
ms.author: karler
ms.topic: quickstart
ms.date: 05/11/2020
---

# Quickstart: WildFly on CentOS

This Quickstart shows you how to deploy the standalone node of WildFly on top of CentOS 8 VM. This is ideal for development and testing of enterprise Java applications on Azure.

## Prerequisites

* An Azure subscription; if you don't already have an Azure subscription, you can activate your [MSDN subscriber benefits](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details) or sign up for a [free Azure account](https://azure.microsoft.com/pricing/free-trial).

## Use case

WildFly is ideal for development and testing of enterprise Java applications on Azure. List of technologies available in WildFly 18 server configuration profiles are available in the [WildFly Getting Started Guide](https://docs.wildfly.org/18/Getting_Started_Guide.html#getting-started-with-wildfly).

You can  use WildFly in either Standalone mode or Cluster mode per your use case. You can ensure high availability of critical Jakarta EE applications by WildFly on a cluster of nodes, making a small number of application configuration changes, and then deploying the application in the cluster. To learn more on this please check the [WildFly High Availability Guide](https://docs.wildfly.org/18/High_Availability_Guide.html).

## Configuration choice

WildFly can be booted in **Standalone Server** mode - A standalone server instance is an independent process, much like an JBoss Application Server 3, 4, 5, or 6 instance is. Standalone instances can be launched via the standalone.sh or standalone.bat launch scripts. If more than one standalone instance is launched and multi-server management is desired, it is the user’s responsibility to coordinate management across the servers.

You can also start WildFly instance with alternate configuration by using configuration files available in configuration folder.

Following are the Standalone Server Configuration files

- standalone.xml (default)
   
   - This is the default file used for starting the WildFly instance. It contains Jakarta web profile certified configuration with the required technologies.
   
- standalone-ha.xml

   - Jakarta web profile certified configuration with high availability.
   
- standalone-full.xml

   - Jakarta Full Platform certified configuration including all the required technologies

- standalone-full-ha.xml

   - Jakarta Full Platform certified configuration with high availability

If you choose to start your WildFly Standalone server with one of the other provided configurations, they can be accessed by passing the --server-config argument with the server-config file to be used. 

For example, to use the Full Platform with clustering capabilities use the following command:

`./standalone.sh --server-config=standalone-full-ha.xml`

To learn more on the configurations check the [WildFly Getting Started Guide](https://docs.wildfly.org/18/Getting_Started_Guide.html#wildfly-10-configurations).

## Support and subscription notes

Azure CentOS 8 image is a Pay-as-you-go (PAYG) VM image and does not require the user to license. The VM will be licensed automatically after the instance is launched for the first time and the user will be charged hourly in addition to Microsoft's Linux VM rates. Click [Linux VM Pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/#linux) for details. WildFly is free to download and use and does not require a Red Hat Subscription or any License.

## How to consume

You can deploy the template in three following ways :

- Using Powershell : You can use powershell to deploy the template by running the following commands. Please visit [Azure Powershell](https://docs.microsoft.com/en-us/powershell/azure/?view=azps-2.8.0) for information on installing and configuring Azure PowerShell.

    `New-AzResourceGroup -Name <resource-group-name> -Location <resource-group-location> #use this command when you need to create a new resource group for your deployment`

    `New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateUri https://raw.githubusercontent.com/SpektraSystems/redhat-mw-cloud-quickstart/master/wildfly-standalone-centos8/azuredeploy.json`
    
- Using Azure CLI : You can use Azure CLI to deploy the template by running the following commands. Please check [Azure Cross-Platform Command Line](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) for details on installing and configuring the Azure Cross-Platform Command-Line Interface.

    `az group create --name <resource-group-name> --location <resource-group-location> #use this command when you need to create a new resource group for your deployment`

    `az group deployment create --resource-group <my-resource-group> --template-uri https://raw.githubusercontent.com/SpektraSystems/redhat-mw-cloud-quickstart/master/wildfly-standalone-centos8/azuredeploy.json`

- Using Azure Portal : You can use Azure portal to deploy the template by clicking <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fredhat-mw-cloud-quickstart%2Fmaster%2Fwildfly-standalone-centos8%2Fazuredeploy.json" target="_blank">here</a> and logging into your Azure portal.

## ARM template

<a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/wildfly-standalone-centos8" target="_blank"> WildFly 18 on CentOS 8 (stand-alone VM)</a> - This is a Quickstart template that creates a standalone node of WildFly 18.0.1.Final on CentOS 8 VM in your Resource Group (RG) which includes a Public DNS name, Virtual Network and Network Security Group. It also deploys Java Sample Application named JBoss-EAP on Azure on WildFly.

## Resource Links:

Learn more about [WildFly](https://wildfly.org/)

## Next steps

Visit [WildFly18](https://docs.wildfly.org/18/) to learn more about WildFly 18.

If you're interested in Red Hat JBoss EAP Azure Quickstart templates, you can find it here:

*  <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-standalone-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (stand-alone VM)</a> - Standalone JBoss EAP 7.2 with a sample web app on a RHEL 7.7 Azure VM.

*  <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss-eap-standalone-rhel8" target="_blank"> JBoss EAP 7.2 on RHEL 8.0 (stand-alone VM)</a> - Standalone JBoss EAP 7.2 with a sample web app on a RHEL 8.0 Azure VM.

*  <a href="https://github.com/SpektraSystems/redhat-mw-cloud-quickstart/tree/master/jboss7.3-eap-standalone-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (stand-alone VM)</a> - Standalone JBoss EAP 7.3 with a sample web app on a RHEL 8.0 Azure VM.
