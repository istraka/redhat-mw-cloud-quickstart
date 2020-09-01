---
title: Quickstart - Marketplace offer for JBoss EAP on Azure RHEL VM
description: How to deploy Red Hat JBoss EAP on Azure RHEL VM using the offer in Azure Marketplace
author: theresa-nguyen
ms.author: bicnguy
ms.topic: quickstart
ms.date: 08/26/2020
---

# Deploy Red Hat JBoss EAP on Azure RHEL VM using the offer in Azure Marketplace

Azure Marketplace have offers using which you can deploy Azure [Red Hat Enterprise Linux (RHEL)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) Virtual Machine (VM) with [JBoss Enterprise (EAP)](https://www.redhat.com/en/technologies/jboss-middleware/application-platform) pre-installed. JBoss EAP is an open source application server platform that delivers enterprise-grade security, scalability, and performance. RHEL is an open source operating system (OS) platform, where you can scale existing apps and roll out emerging technologies across all environments. JBoss EAP and RHEL includes everything needed to build, run, deploy, and manage enterprise Java applications in any environment, including on-premises, virtual environments, and in private, public, or hybrid clouds.

## Prerequisites

* An Azure account with an active subscription. If you don't have an Azure subscription, you can activate your [MSDN subscriber benefits](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details) or [create an account for free](https://azure.microsoft.com/pricing/free-trial).

* JBoss EAP - You need to have a Red Hat Account and your Red Hat Subscription Management (RHSM) account must have JBoss EAP entitlement to download Red Hat tested and certified JBoss EAP version.  If you don't have EAP entitlement, obtain a [JBoss EAP evaluation subscription](https://access.redhat.com/products/red-hat-jboss-enterprise-application-platform/evaluation) before you get started. If you would like to create a new Red Hat subscription, go to [Red Hat Customer Portal](https://access.redhat.com/) and set up an account.

* RHEL options - Choose between Pay-As-You-Go (PAYG) or Bring-Your-Own-Subscription (BYOS).

* [Azure Command-Line Interface](https://docs.microsoft.com/cli/azure/overview).

## Support and subscription notes

The Azure Marketplace offers you the following combination of JBoss EAP on RHEL VM plans :

- **EAP 7.2 on RHEL 7.7 VM PAYG**
- **EAP 7.2 on RHEL 7.7 VM BYOS**
- **EAP 7.2 on RHEL 8.0 VM PAYG**
- **EAP 7.2 on RHEL 8.0 VM BYOS**
- **EAP 7.3 on RHEL 8.0 VM PAYG**
- **EAP 7.2 on RHEL 8.0 VM BYOS**

Note that the JBoss EAP is offered as BYOS only.

#### Using RHEL OS with PAYG Model

By default these Quickstart templates use the On-Demand Red Hat Enterprise Linux 7.7 or 8.0 Pay-As-You-Go (PAYG) image from the Azure Gallery. When using this On-Demand image, there is an additional hourly RHEL subscription charge for using this image on top of the normal compute, network and storage costs. At the same time, the instance will be registered to your Red Hat subscription, so you will also be using one of your entitlements. This will lead to "double billing". To avoid this issue, you would need to build your own RHEL image, which is defined in this [Red Hat KB article](https://access.redhat.com/articles/uploading-rhel-image-to-azure) or activate your [Red Hat Cloud Access](https://access.redhat.com/) RHEL Gold Image.

Check out [Red Hat Enterprise Linux pricing](https://azure.microsoft.com/pricing/details/virtual-machines/red-hat/) for details on the PAYG model. In order to use RHEL in PAYG model, you will need an Azure Subscription with the specified payment method ([RHEL 7.7 Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/RedHat.RedHatEnterpriseLinux77-ARM) and [RHEL 8.0 Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/RedHat.RedHatEnterpriseLinux80-ARM) are offers that requires a payment method to be specified in the Azure Subscription).

#### Using RHEL OS with BYOS Model

In order to use BYOS for RHEL OS Licensing, you need to have a valid Red Hat subscription with entitlements to use RHEL OS in Azure. Complete the following prerequisites in order to use RHEL OS through BYOS model before you deploy the EAP on RHEL BYOS Plan from Azure Marketplace. You need to accept the Marketplace Terms and Conditions in Azure for the RHEL BYOS plans. You can complete this by running Azure CLI commands, as given below. Make sure you are running the latest Azure CLI version before moving on.

1. Launch an Azure CLI session and authenticate with your Azure account. Refer to [Signing in with Azure CLI](https://docs.microsoft.com/cli/azure/authenticate-azure-cli?view=azure-cli-latest) for assistance. Make sure you are running the latest Azure CLI version before moving on.

2. Verify the RHEL BYOS plans are available in your subscription by running the following CLI command. Ideally it should be available in all the subscriptions.

    `az vm image list --offer jboss-eap-rhel7 --all` - ***EAP 7.2 on RHEL 7.7 BYOS VM***

    `az vm image list --offer jboss-eap72-rhel8 --all` - ***EAP 7.2 on RHEL 8.0 BYOS VM***

    `az vm image list --offer jboss-eap-rhel8 --all` - ***EAP 7.3 on RHEL 8.0 BYOS VM***

3. Run the following command to accept the Marketplace Terms for RHEL 7.7 BYOS and RHEL 8.0 BYOS, respectively.

    `az vm image terms accept --publisher redhat --offer rhel-byos --plan rhel-lvm77` - ***EAP 7.2 on RHEL 7.7 BYOS VM***

    `az vm image terms accept --publisher redhat --offer rhel-byos --plan rhel-lvm77` - ***EAP 7.2 on RHEL 8.0 BYOS VM***

    `az vm image terms accept --publisher redhat --offer rhel-byos --plan rhel-lvm77` - ***EAP 7.3 on RHEL 8.0 BYOS VM***

4. Your subscription is now ready to deploy EAP on RHEL BYOS VM plans.

 Once you deploy a VM using any of the above mentioned RHEL BYOS plan please run the following commands to register with your RHSM account and attach your BYOS Pool ID.

1. Log into your RHEL BYOS VM.

2. Register your Red Hat subscription Manager. In the command below the RHSM_USER is your RedHat Subscription Manager Username and RHSM_PASSWORD is RedHat Subscription Manager Password.

    `subscription-manager register --username RHSM_USER --password RHSM_PASSWORD`

3. Attach your RHSM pool ID (with RHSM BYOS License) using the command below, where RHEL_POOl is the RHSM pool ID with BYOS license entitlement

    `subscription-manager attach --pool=RHEL_POOL`

#### Using JBoss EAP with BYOS Model

JBoss EAP is available on Azure through BYOS model only. When deploying the plan with RHEL PAYG VM, you need to supply your RHSM credentials along with RHSM Pool ID with valid EAP entitlements. If you don't have EAP entitlement, obtain a [JBoss EAP evaluation subscription](https://access.redhat.com/products/red-hat-jboss-enterprise-application-platform/evaluation) before you get started. When depyoing the plan with RHEL BYOS VM, after following the steps mentioned above also run the following command to attach the Pool ID with EAP entitlement, where EAP_POOL is RHSM pool ID with EAP entitlement.

    `subscription-manager attach --pool=EAP_POOL`

## Troubleshooting

This section includes common errors faced during deployments and details on how you can troubleshoot these errors. 

#### Azure Platform

- If the parameter criteria are not fulfilled (ex - the admin password criteria was not met) or if any mandatory parameters are not provided in the parameters section then the deployment will not start. The *Terms & Conditions* must be accepted before clicking on *Purchase*.

- Once the deployment starts the resources being deployed will be visible on the deployment page. In the case of any deployment failure, after parameter validation process, a more detailed failure message is available.

- If your deployment fails at the **VM Custom Script Extension** resource, a more detailed failure message is available in the VM log file. Please refer to the next section for further troubleshooting.

#### Troubleshooting EAP deployment extension

The offers with PAYG RHEL OS uses VM Custom Script Extension to deploy JBoss EAP and configure JBoss EAP management user. The offers with BYOS RHEL OS uses VM Custom Script Extension to configure JBoss EAP management user only. Your deployment can fail at this stage due to several reasons such as:

- Invalid RHSM or EAP entitlement
- Invalid JBoss EAP or RHEL OS entitlement Pool ID

Follow the steps below to troubleshoot this further:

1. Log into the provisioned virtual machine through SSH. You can retrieve the Public IP of the VM from the Azure portal VM overview page.

2. Switch to root user

    `sudo su -`

3. Enter the VM admin password if prompted.

4. Change directory to logging directory

    `cd /var/lib/waagent/custom-script/download/0`

5. Review the logs in jbosseap.install.log log file.

    `more eap.log`

This log file will have details that include deployment failure reason and possible solutions. If your deployment failed due to RHSM account or entitlements, please refer to 'Support and subscription notes' section to complete the prerequisites and try again.

Please refer to [Using the Azure Custom Script Extension Version 2 with Linux VMs](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-linux) for more details on troubleshooting VM custom script extensions.

## Resource Links:

* Learn more about [JBoss EAP](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/getting_started_with_jboss_eap_for_openshift_online/introduction)
* Learn more about [JBoss EAP on Azure Red Hat OpenShift](https://azure.microsoft.com/services/openshift/)
* Learn more about [JBoss EAP on App Service Linux](https://docs.microsoft.com/azure/app-service/quickstart-java?pivots=platform-linux)
* [Azure for Java developers documentation](https://github.com/JasonFreeberg/jboss-on-app-service)

## Next steps

* [Learn more about JBoss EAP 7.2](https://access.redhat.com/documentation/red_hat_jboss_enterprise_application_platform/7.2/)
* [Learn more about JBoss EAP 7.3](https://access.redhat.com/documentation/red_hat_jboss_enterprise_application_platform/7.3/)
* [Learn more about Red Hat Subscription Management (RHSM)](https://access.redhat.com/products/red-hat-subscription-management)
* [MS Docs for Red Hat on Azure](https://aka.ms/rhel-docs)
* [Deploy RHEL 7.7 VM from Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/RedHat.RedHatEnterpriseLinux77-ARM?tab=Overview)
* [Deploy RHEL 8.0 VM from Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/RedHat.RedHatEnterpriseLinux80-ARM?tab=Overview)
* For dev/test without Red Hat OS or App Server subscription, run WildFly instead of JBoss EAP: <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/wildfly-standalone-centos8" target="_blank"> WildFly on an Azure CentOS VM</a> - Standalone WildFly 18 with a sample web app on an Azure CentOS 8 VM.
