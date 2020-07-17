# JBoss EAP 7.3 on RHEL 8.0 (stand-alone VM)
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fredhat-mw-cloud-quickstart%2Fmaster%2Fjboss-eap73-standalone-rhel8%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

`Tags: JBoss, Red Hat, EAP 7.3, RHEL 8.0, Azure, Azure VM, JavaEE`

<!-- TOC -->

1. [Solution Overview](#solution-overview)
2. [Template Solution Architecture](#template-solution-architecture)
3. [Subscriptions and Costs](#subscriptions-and-costs)
4. [Prerequisites](#prerequisites)
5. [Deployment Steps](#deployment-steps)
6. [Deployment Time](#deployment-time)
7. [Validation Steps](#validation-steps)
8. [Troubleshooting](#troubleshooting)
9. [Support](#support)

<!-- /TOC -->

## Solution Overview

JBoss Enterprise Application Platform (EAP) is an open source platform for highly transactional, web-scale Java applications. EAP combines the familiar and popular Jakarta EE specifications with the latest technologies, like MicroProfile, to modernize your applications from traditional Java EE into the new world of DevOps, cloud, containers, and microservices. EAP includes everything needed to build, run, deploy, and manage enterprise Java applications in a variety of environments, including on-premises, virtual environments, and in private, public, and hybrid clouds.

Red Hat Subscription Management (RHSM) is a customer-driven, end-to-end solution that provides tools for subscription status and management and integrates with Red Hat's system management tools. To obtain an RHSM account for JBoss EAP, go to: www.redhat.com.

## Template Solution Architecture

This Azure Resource Manager (ARM) template creates all the Azure compute resources to run JBoss EAP 7.3 setup on Red Hat Enterprise Linux (RHEL) 8.0 VM. The following resources are created by this template:

- RHEL 8.0 Virtual Machine
- Public IP 
- Virtual Network 
- Network Security Group 
- JBoss EAP 7.3 setup on the RHEL VM
- Sample Java application named **JBoss-EAP on Azure** deployed on JBoss EAP 7.3

Following is the Architecture:

![alt text](images/rhel-arch.png)

To learn more about the JBoss Enterprise Application Platform, visit: [Documentation for JBoss EAP 7.3](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/)

## Subscriptions and Costs

This ARM template is designed with flexible operating system (OS) options:

- Red Hat Enterprise Linux OS as Pay-As-You-Go (PAYG) or Bring-Your-Own-Subscription (BYOS) via Red Hat Gold Image model.
- Red Hat JBoss EAP is available through BYOS only.

#### Using RHEL OS with PAYG Model

By default this template uses the on-demand Red Hat Enterprise Linux 8.0 PAYG image from the Azure Gallery. When using this on-demand image, there is an additional hourly RHEL subscription charge for using this image on top of the normal compute, network and storage costs. At the same time, the instance will be registered to your Red Hat subscription, therefore consuming one of your entitlements. This will lead to "double billing". To avoid this, you would need to build your own RHEL image, which is defined in this Red Hat KB article for [uploading RHEL image to Azure](https://access.redhat.com/articles/uploading-rhel-image-to-azure) or use RHEL Gold Image from the Azure Private Gallery offering.

Read [Red Hat Enterprise Linux pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/red-hat/) for details on the RHEL VMs pricing with PAYG model. In order to use RHEL in PAYG model, you will need an Azure Subscription with the specified payment method (RHEL 8.0 is an [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/RedHat.RedHatEnterpriseLinux80-ARM?tab=Overview) product and requires a payment method to be specified in the Azure Subscription). 

#### Using RHEL OS with BYOS Model

In order to use BYOS for RHEL OS Licensing, you need to have a valid Red Hat subscription with entitlements to use RHEL OS in Azure. Please complete the following prerequisites in order to use RHEL OS through BYOS model before you deploy this quickstart template.

1. Ensure you have RHEL OS and JBoss EAP entitlements attached to your Red Hat Subscription.
2. Authorize your Azure Subscription ID to use RHEL BYOS images. Please follow [Red Hat Subscription Management (RHSM) documentation](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/con-enable-subs) to complete this process. This includes multiple steps including:

    2.1 Enable Microsoft Azure as provider in your Red Hat Cloud Access Dashboard.

    2.2 Add your Azure Subscription IDs.

    2.3 Enable new products for Cloud Access on Microsoft Azure.
    
    2.4 Activate Red Hat Gold Images for your Azure Subscription. Refer to [Red Hat Subscription Management](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/using_red_hat_gold_images#con-gold-image-azure) for more details.

    2.5 Wait for Red Hat Gold Images to be available in your Azure subscription. These are typically available within 3 hours.
    
3. Accept the Marketplace Terms and Conditions in Azure for the RHEL BYOS Images. You can complete this by running Azure CLI commands, as instructed below. Refer to [RHEL BYOS Gold Images in Azure documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/redhat/byos) for more details.

    3.1 Launch an Azure CLI session and make sure your CLI version is updated to version 2.8 or newer before running these commands. Check the CLI version by running the following command and if required update your [CLI version](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&tabs=azure-cli)

    `az version`
    
    3.2 Once your CLI session is ready, authenticate with your Azure account. Refer to [Signing in with Azure CLI](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest) for assistance.

    3.3 Verify the RHEL BYOS images are available in your subscription by running the following CLI command. If your RHEL BYOS is not listed, please refer to #2 and ensure that your Azure subscription is activated for RHEL BYOS images.

    `az vm image list --offer rhel-byos --all`

    3.4 Run the following command to accept the Marketplace Terms for RHEL 8.0 BYOS.

    `az vm image terms accept --publisher redhat --offer rhel-byos --plan rhel-lvm8`

4. Your subscription is now ready to deploy RHEL 8.0 BYOS virtual machines.

#### Using JBoss EAP with BYOS Model

JBoss EAP is available on Azure through BYOS model only; you need to supply your RHSM credentials along with RHSM Pool ID showing valid EAP entitlements when deploying this template. If you do not have EAP entitlement, you must obtain a [JBoss EAP evaluation subscription](https://access.redhat.com/products/red-hat-jboss-enterprise-application-platform/evaluation) or contact Red Hat for a production subscription before you get started.

## Prerequisites

1. Ensure you have an Azure subscription compliant with licensing requirements specified in 'Subscriptions and Costs' section.

2. To deploy the template, you will need:

   - **Admin Username** and password or SSH key data which is an SSH RSA public key for your VM.

   - **JBoss EAP Username** and password
    
   - **RHSM Username** and password

   - **RHSM Pool ID for JBoss EAP and/or RHEL OS**

## Deployment Steps

Build your environment with JBoss EAP 7.3 on a VM running RHEL 8.0 on Azure by clicking the **Deploy to Azure** button and fill in the following parameter values:

   - **Subscription** - Choose the appropriate subscription for deployment.

   - **Resource Group** - Create a new Resource Group or select an existing one.

   - **Location** - Choose the appropriate location for deployment.

   - **Admin Username** - User account name for logging into the RHEL VM.
   
   - **Authentication Type** - Type of authentication to use on the VM (password or SSH key).

   - **Admin Password or SSH key** - User account password or SSH key data which is an SSH RSA public key for logging into the RHEL VM.

   - **JBoss EAP Username** - Username for JBoss EAP Console.

   - **JBoss EAP Password** - User account password for JBoss EAP Console.

   - **RHEL OS Subscription Type** - Select the type of RHEL OS license from the dropdown options for deploying the VM. You will have either the option of PAYG (by default) or BYOS.
    
   - **RHSM Username** - Username for the Red Hat Subscription Manager account.

   - **RHSM Password** - User account password for your RHSM account.

   - **RHSM Pool ID for JBoss EAP** - RHSM Pool ID (ensure you have EAP entitlement)

   - **RHSM Pool ID for RHEL** - RHSM Pool ID (ensure you have RHEL entitlement). This is **mandatory when selecting BYOS RHEL OS** as Subscription Type.  This should be left blank when selecting RHEL OS PAYG Subscription Type.

   - **VM Size** - Select the appropriate size of the VM from the dropdown options.

   - Leave the rest of the parameter values (Artifacts and Location) as is, accept the Terms and Conditions, and click on Purchase.
    
## Deployment Time

The deployment takes approximately 10 minutes to complete.

## Validation Steps

- Once the deployment is successful, go to the Outputs section of the deployment to obtain the **VM DNS name**, **app URL** and the **Admin Console URL**:

  ![alt text](images/output.png)

- Paste the app URL that you copied from the Output page in a browser to view the JBoss-EAP on Azure web page.

  ![alt text](images/app.png)

- Paste the Admin Console URL that you copied from the Output page in a browser to access the JBoss EAP Admin Console and enter the JBoss EAP username and password to login.

  ![alt text](images/admin.png)

## Troubleshooting

This section includes common errors faced during deployments and details on how you can troubleshoot these errors. 

#### Azure Platform

- If the parameter criteria are not fulfilled (ex - the admin password criteria was not met) or if any mandatory parameters are not provided in the parameters section then the deployment will not start. The *Terms & Conditions* must be accepted before clicking on *Purchase*.

- Once the deployment starts the resources being deployed will be visible on the deployment page. In the case of any deployment failure, after parameter validation process, a more detailed failure message is available.

- If your deployment fails at the **VM Custom Script Extension** resource, a more detailed failure message is available in the VM log file. Please refer to the next section for further troubleshooting.

#### Troubleshooting EAP deployment extension

This quickstart template uses VM Custom Script Extension to deploy and configure JBoss EAP with a sample application. Your deployment can fail at this stage due to several reasons such as:

- Invalid RHSM or EAP entitlement
- Invalid JBoss EAP or RHEL OS entitlement Pool ID

Follow the steps below to troubleshoot this further:

1. Log into the provisioned VM through SSH. You can retrieve the Public IP of the VM using the Azure portal VM *Overview* page.

2. Switch to root user

    `sudo su -`

3. Enter your VM admin password if prompted.

4. Change directory to logging directory

    `cd /var/lib/waagent/custom-script/download/0`

5. Review the logs in jbosseap.install.log log file.

    `more jbosseap.install.log`

This log file will have details that include deployment failure reason and possible solutions. If your deployment failed due to RHSM account or entitlements, please refer to 'Subscriptions and Costs' section to complete the prerequisites and try again. Note that after your Azure subscription receives access to Red Hat Gold Images, you can locate them in the Azure portal. Go to **Create a Resource** > **See all**. At the top of the page, you'll see that **You have private offers available** bar, click on *View private offers* link to view your private offers.

![alt text](images/private-offer.png)

Your Private Offer will be tagged with *Private* as seen below.

![alt text](images/rhel-byos.png)

Please refer to [Using the Azure Custom Script Extension Version 2 with Linux VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-linux) for more details on troubleshooting VM custom script extensions.

## Support

For any support related questions, issues or customization requirements, please contact [Spektra Systems](info@spektrasystems.com) or [Red Hat Support](https://www.redhat.com/en/services/support).
