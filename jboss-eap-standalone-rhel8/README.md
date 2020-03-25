# VM-Redhat - JBoss EAP 7 standalone mode
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fredhat-mw-cloud-quickstart%2Fmaster%2Fjboss-eap-standalone-rhel8%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fredhat-mw-cloud-quickstart%2Fmaster%2Fjboss-eap-standalone-rhel8%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

`Tags: JBoss, EAP, Red Hat,EAP7`

<!-- TOC -->

1. [Solution Overview ](#solution-overview)
2. [Template Solution Architecture ](#template-solution-architecture)
3. [Licenses and Costs ](#licenses-and-costs)
4. [Prerequisites](#prerequisites)
5. [Deployment Steps](#deployment-steps)
6. [Deployment Time](#deployment-time)
7. [Post Deployment Steps](#post-deployment-steps)

<!-- /TOC -->

## Solution Overview

JBoss EAP is an open source platform for highly transactional, web-scale Java applications. EAP combines the familiar and popular Jakarta EE specifications with the latest technologies, like Microprofile, to modernize your applications from traditional Java EE into the new world of DevOps, cloud, containers, and microservices. EAP includes everything needed to build, run, deploy, and manage enterprise Java applications in a variety of environments, including on-premise, virtual environments, and in private, public, and hybrid clouds.

Red Hat Subscription Management (RHSM) is a customer-driven, end-to-end solution that provides tools for subscription status and management and integrates with Red Hat's system management tools. To obtain a rhsm account go to: www.redhat.com and sign in.

This template deploys a web applicaton deployed on JBoss EAP 7.2 running on RHEL 8. 

## Template Solution Architecture
This template creates all of the compute resources to run JBoss EAP 7 on top of RHEL 8.0, deploying the following components:

- RHEL 8.0 VM 
- Public DNS 
- Private Virtual Network 
- Security Configuration 
- JBoss EAP 7
- Sample application deployed to JBoss EAP 7

Following is the Architecture :
<img src="images/RHEL8-Arch.PNG" width="800">

To learn more about JBoss Enterprise Application Platform, check out:
https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/

## Licenses and Costs

This uses RHEL 8.0 image which is a PAY AS YOU GO image and doesn't require the user to license it; it will be licensed automatically after the instance is launched the first time and the user will be charged hourly in addition to Microsoft's Linux VM rates.  Click [here](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/#red-hat) for pricing details. You also need to have a RedHat account to register to Red Hat Subscription Manager (RHSM). Click [here](https://access.redhat.com/products/red-hat-subscription-management) to know more about RHSM and pricing.

## Prerequisites

1. Azure Subscription with specified payment method (RHEL 8 is a [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/RedHat.RedHatEnterpriseLinux80-ARM?tab=Overview) product and requires the payment method to be specified in Azure Subscription)

2. To deploy the template, you will need to:

   - Choose an admin username and password/ssh key for your VM.
    
   - Choose a name for your VM.

   - Choose a EAP user name and password to enable the EAP manager UI and deployment method.
    
   - Provide your RHSM Username and Password

## Deployment Steps

Build your environment with EAP 7.2 on top of RHEL 8.0 on Azure by clicking the Deploy to Azure button and fill in the following parameter values:

   - **Subscription** - Choose the right subscription where you would like to deploy.

   - **Resource Group** - Create a new Resource group or you can select an existing one.

   - **Location** - Choose the right location for your deployment.

   - **Admin Username** - User account name for logging into your RHEL VM.
   
   - **Authentication Type** - Type of authentication to use on the Virtual Machine.

   - **Admin Password or Key** - User account password/ssh key for logging into your RHEL VM.

   - **EAP Username** - User name for EAP Console.

   - **EAP Password** - User account password for EAP Console.
    
   - **RHSM Username** - User name for RedHat account.

   - **RHSM Password** - User account password for RedHat account.

   - Leave the rest of the Parameter Value as it is and accept the terms and conditions before clicking on Purchase
    
## Deployment Time 

The deployment takes less than 10 minutes to complete.

## Post Deployment Steps

- Once the deployment is successful, go the VM and copy the Public IP of the VM.
- Open a web browser and go to http://<PUBLIC_HOSTNAME>:8080/dukes/ and you should see the application running
If you want to access the administration console go to http://<PUBLIC_HOSTNAME>:8080 and click on the link Administration Console and enter EAP username and password to see the console.
