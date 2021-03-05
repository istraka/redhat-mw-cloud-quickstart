---
title: Quickstart - Marketplace offer for JBoss Enterprise Application (EAP) on Azure Red Hat Enterprise Linux (RHEL) VM and Virtual Machine Scale Set
description: How to deploy Red Hat JBoss EAP on Azure RHEL VM and Virtual Machine Scale Set using Azure Marketplace offers.
author: theresa-nguyen
ms.author: bicnguy
ms.topic: quickstart
ms.date: 11/30/2020
---

# Deploy Red Hat JBoss EAP on Azure RHEL VM and VMSS using the offer in Azure Marketplace

Azure Marketplace has offers using which you can deploy Azure [Red Hat Enterprise Linux (RHEL)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) Virtual Machine (VM) or Virtual Machine Scale Set (VMSS) with [JBoss Enterprise (EAP)](https://www.redhat.com/en/technologies/jboss-middleware/application-platform) pre-installed. JBoss EAP is an open-source application server platform that delivers enterprise-grade security, scalability, and performance. RHEL is an open-source operating system (OS) platform. You can scale existing apps and roll out emerging technologies across all environments. JBoss EAP and RHEL include everything you need to build, run, deploy, and manage enterprise Java applications in any environment. This includes on-premises, virtual environments, and in private, public, or hybrid clouds.

## Prerequisites

* An Azure account with an active subscription. If you don't have an Azure subscription, you can activate your [MSDN subscriber benefits](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details) or [create an account for free](https://azure.microsoft.com/pricing/free-trial).

* JBoss EAP installation - You need to have a Red Hat Account with Red Hat Subscription Management (RHSM) entitlement for JBoss EAP. This entitlement will let you download the Red Hat tested and certified JBoss EAP version.  If you don't have EAP entitlement, you can sign up for a free developer subscription through the [Red Hat Developer Subscription for Individuals](https://developers.redhat.com/register). Once registered, you can find the necessary credentials (Pool IDs) at the [Red Hat Customer Portal](https://access.redhat.com/management/).

* RHEL options - Choose between Pay-As-You-Go (PAYG) or Bring-Your-Own-Subscription (BYOS). With BYOS, you need to activate your [Red Hat Cloud Access](https://access.redhat.com/) RHEL Gold Image before deploying the Quickstart template. Follow [these instructions](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/enabling-and-maintaining-subs_cloud-access) to enable RHEL images for use on Microsoft Azure.

* [Azure Command-Line Interface](https://docs.microsoft.com/cli/azure/overview).

## Support and subscription notes

The Azure Marketplace offer of JBoss EAP on RHEL will install and provision on Azure VMs in less than 20 minutes. You can access these offers from [Azure Marketplace](https://azuremarketplace.microsoft.com/)

This Marketplace offer includes various combinations of EAP and RHEL versions to support your requirements. JBoss EAP is always Bring-Your-Own-Subscription (BYOS) but for RHEL OS you can choose between BYOS or Pay-As-You-Go (PAYG). The Azure Marketplace offer includes plan options for JBoss EAP on RHEL as stand-alone or clustered VMs. This Azure Marketplace offer for Red Hat JBoss EAP on RHEL have 6 plans:

- **JBoss EAP 7.3 on RHEL 8.3 VM (PAYG)**
- **JBoss EAP 7.3 on RHEL 8.3 VM (BYOS)**
- **JBoss EAP 7.3 on RHEL 8.3 Clustered VM (PAYG)**
- **JBoss EAP 7.3 on RHEL 8.3 Clustered VM (BYOS)**
- **JBoss EAP 7.3 on RHEL 8.3 VMSS (PAYG)**
- **JBoss EAP 7.3 on RHEL 8.3 VMSS (BYOS)**

#### Using RHEL OS with PAYG Model

This Azure Marketplace offer allows you to deploy Red Hat Enterprise Linux OS with PAYG Model. PAYG plans will have additional hourly RHEL subscription charge on top of the normal compute, network, and storage costs.

Check out [Red Hat Enterprise Linux pricing](https://azure.microsoft.com/pricing/details/virtual-machines/red-hat/) for details on the PAYG model. To use RHEL in PAYG model, you will need an Azure Subscription with the specified payment method. ([RHEL on Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/redhat.rhel-20190605) require a payment method to be specified in the Azure Subscription).

#### Using RHEL OS with BYOS Model

To use BYOS for RHEL OS, you're required to have a valid Red Hat subscription with entitlements to use RHEL OS in Azure. These JBoss EAP on RHEL BYOS plans are private offers, so you need to complete the following prerequisites in order to use RHEL OS through BYOS model before you deploy the EAP on RHEL BYOS Plan from Azure Marketplace. You will be required to accept the Marketplace Terms and Conditions (T&C) in Azure for the RHEL BYOS plans. You can complete this by running Azure CLI commands, as given below. Make sure you're running the latest Azure CLI version before moving on.

1. Ensure you have RHEL OS and JBoss EAP entitlements attached to your Red Hat subscription.

2. Authorize your Azure subscription ID to use RHEL BYOS images. Follow the [Red Hat Subscription Management (RHSM) documentation](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/enabling-and-maintaining-subs_cloud-access) to complete the process, which includes these steps:

    2.1 Enable Microsoft Azure as a provider in your Red Hat Cloud Access Dashboard.

    2.2 Add your Azure subscription IDs.

    2.3 Enable new products for Cloud Access on Microsoft Azure.

    2.4 Activate Red Hat Gold Images for your Azure Subscription. For more information, read the chapter on [Enabling and maintaining subscriptions for Cloud Access](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/red_hat_cloud_access_reference_guide/cloud-access-gold-images_cloud-access#using-gold-images-on-azure_cloud-access) for more details.

    2.5 Wait for Red Hat Gold Images to be available in your Azure subscription. These Gold Images are typically available within 3 hours of submission.

3. Accept the Azure Marketplace Terms and Conditions for RHEL BYOS Images. You can complete this process by running Azure Command-Line Interface (CLI) commands, as given below. For more information, see the [RHEL BYOS Gold Images in Azure](https://docs.microsoft.com/azure/virtual-machines/workloads/redhat/byos) documentation for more details. It's important that you're running the latest Azure CLI version.

    3.1 Launch an Azure CLI session and authenticate with your Azure account. Refer to [Signing in with Azure CLI](https://docs.microsoft.com/cli/azure/authenticate-azure-cli) for assistance. Make sure you are running the latest Azure CLI version before moving on.

    3.2 Verify the RHEL BYOS plans are available in your subscription by running the following CLI command. If you don't get any results here, refer to #2 and ensure that your Azure subscription is activated for JBoss EAP on RHEL BYOS plans.

    ```
    az vm image list --offer rhel-byos --all #use this command to verify the availability of RHEL BYOS images
    ```

    3.3 Run the following command to accept the Marketplace Terms of required JBoss EAP on RHEL BYOS plan.

    ```
    az vm image terms accept --publisher redhat --offer jboss-eap-rhel --plan $PLANID
    ```

    Where `$PLANID` is one of the following (repeat for each Plan you wish to use):

      * jboss-eap-73-byos-rhel-80-byos
      * jboss-eap-73-byos-rhel-8-byos-clusteredvm
      * jboss-eap-73-byos-rhel-80-byos-vmss
      * jboss-eap-73-byos-rhel-80-payg
      * jboss-eap-73-byos-rhel-8-payg-clusteredvm
      * jboss-eap-73-byos-rhel-80-payg-vmss

4. Your subscription is now ready to deploy EAP on RHEL BYOS plans. During deployment, your subscription(s) will be automatically attached using `subscription-manager` using the credentials supplied during deployment.

#### Using JBoss EAP with BYOS Model

JBoss EAP is available on Azure through BYOS model only. When deploying your JBoss EAP on RHEL plan, you need to supply your RHSM credentials along with RHSM Pool ID with valid EAP entitlements. If you don't have EAP entitlement, obtain a [Red Hat Developer Subscription for Individuals](https://developers.redhat.com/register). Once registered, you can find the necessary credentials (Pool IDs) at the [Red Hat Customer Portal](https://access.redhat.com/management/). During deployment, your subscription(s) will be automatically attached using `subscription-manager` using the credentials supplied during deployment.

#### After a successful deployment

These offers create all the Azure compute resources to run JBoss EAP setup on Red Hat Enterprise Linux (RHEL) VM as per the user choice. The following resources are created by this template:

- RHEL Virtual Machine
- Virtual Network
- JBoss EAP setup on a RHEL VM
- Storage Account (optional)

By default, the VM is only exposed to the private network created during deployment. In order to access the VM directly, you have several options:

1. Create a Jump VM in a different Virtual Network and access the RHEL VM using Virtual Network Peering. (recommended method)
2. Create a Public IP to access the RHEL VM and JBoss EAP Admin Console.
3. Create a Jump VM in a different subnet (new subnet) in the same Virtual Network and access the RHEL VM via a Jump VM.
4. Using an Application Gateway.
5. Using an External Load Balancer (ELB).

**Option 1. Create a Jump VM in a different Virtual Network and access the RHEL VM using Virtual Network Peering. (recommended method)**

   - [Create a Windows Virtual Machine](https://docs.microsoft.com/azure/virtual-machines/windows/quick-create-portal#create-virtual-machine) - in a new Azure Resource Group, create a Windows VM. This should be in the same location as RHEL VM. Provide the required details and leave other configurations as default. This will create the Jump VM in a new Virtual Network.

   - [Peer the Virtual Networks](https://docs.microsoft.com/azure/virtual-network/tutorial-connect-virtual-networks-portal#peer-virtual-networks) - this is how you associate the RHEL VM with the Jump VM. Once the Virtual Network peering is successful, both the VMs can communicate with each other.

   - Go to the Jump VM details page and copy the Public IP. Log into the Jump VM using this Public IP.

   - Copy the Private IP of RHEL VM from the output page and use it to log into the RHEL VM from the Jump VM.

   - Paste the app URL that you copied from the output page in a browser inside the Jump VM to view the JBoss EAP on Azure web page.

   - Access the JBoss EAP Admin Console - paste the Admin Console URL copied from the output page in a browser inside the Jump VM, enter the JBoss EAP username and password to log in.

**Option 2. Create a Public IP to access the RHEL VM and JBoss EAP Admin Console.**

   - The RHEL VM you created does not have a Public IP associated with it. You can [create a Public IP](https://docs.microsoft.com/azure/virtual-network/virtual-network-public-ip-address#create-a-public-ip-address) for accessing the VM and [associate the Public IP to the VM](https://docs.microsoft.com/azure/virtual-network/associate-public-ip-address-vm). All this can be done using Azure Portal or Powershell commands or CLI commands.

   - Obtain the Public IP of a VM - go to the VM details page and copy the Public IP. You can use this Public IP to access the VM and JBoss EAP Admin Console.

   - View the JBoss EAP on Azure web page - open a web browser and go to *http://<PUBLIC_HOSTNAME>:8080/* and you should see the default EAP welcome page.

   - Log into the JBoss EAP Admin Console - open a web browser and go to *http://<PUBLIC_HOSTNAME>:9990*. Enter the JBoss EAP username and password to log in.

**Option 3. Create a Jump VM in a different subnet (new subnet) in the same Virtual Network and access the RHEL VM via a Jump VM.**

   - [Add a new subnet](https://docs.microsoft.com/azure/virtual-network/virtual-network-manage-subnet#add-a-subnet) in the existing Virtual Network which contains the RHEL VM.

   - [Create a Windows Virtual Machine](https://docs.microsoft.com/azure/virtual-machines/windows/quick-create-portal#create-virtual-machine) in Azure in the same Resource Group as the RHEL VM. Provide the required details and leave other configurations as default except for the Virtual Network and subnet. Make sure you select the existing Virtual Network in the Resource Group and select the subnet you just created in the step above. This will be your Jump VM.

   - Access Jump VM Public IP - once successfully deployed, go to the VM details page and copy the Public IP. Log into the Jump VM using this Public IP.

   - Log into RHEL VM - copy the Private IP of RHEL VM from the output page and use it to log into the RHEL VM from the Jump VM.

   - Access the JBoss EAP welcome page - in your Jump VM, open a browser and paste the app URL that you copied from the output page of the deployment.

   - Access the JBoss EAP Admin Console - paste the Admin Console URL that you copied from the output page in a browser inside the Jump VM to access the JBoss EAP Admin Console and enter the JBoss EAP username and password to log in.

**Option 4. Using an Application Gateway.**

   - [Create an Application Gateway](https://docs.microsoft.com/azure/application-gateway/quick-create-portal#create-an-application-gateway) - to access the ports of the RHEL VM, create an Application Gateway in a different subnet. This subnet must only contain the Application Gateway.

   - Set *Frontends* parameters - make sure you select Public IP or both and provide the required details. Under *Backends* section, select **Add a backend pool** option and add the RHEL VM to the backend pool of the Application Gateway.

   - Set access ports - under *Configuration* section add routing rules to access the ports 8080 and 9990 of the RHEL VM.

   - Copy Public IP of Application Gateway - once the Application Gateway is created with the required configurations, go to the  overview page and copy the Public IP of the Application Gateway.

   - To view the JBoss EAP on Azure web page - open a web browser and go to *http://<PUBLIC_IP_AppGateway>:8080* and you should see the default EAP welcome page.

   - To log into the JBoss EAP Admin Console - open a web browser and go to *http://<PUBLIC_IP_AppGateway>:9990*. Enter the JBoss EAP username and password to log in.

**Option 5. Using an External Load Balancer (ELB).**

   - [Create a Load Balancer](https://docs.microsoft.com/azure/load-balancer/tutorial-load-balancer-standard-manage-portal#create-a-standard-load-balancer) to access the ports of the RHEL VM. Provide the required details to deploy the external Load Balancer and leave other configurations as default. Leave the SKU as Basic for this configuration.

   - Add Load Balancer rules - once the Load balancer has been created successfully, [create Load Balancer resources](https://docs.microsoft.com/azure/load-balancer/tutorial-load-balancer-standard-manage-portal#create-load-balancer-resources), add Load Balancer rules to access the ports 8080 and 9990 of the RHEL VM.

   - Add the RHEL VM to the backend pool of the Load Balancer - click on *Backend pools* under settings section and then select the backend pool you created in the step above. Select the Virtual Machine corresponding to the option *Associated to* and then add the RHEL VM.

   - To obtain the Public IP of the Load Balancer - go to the Load Balancer overview page and copy the Public IP of the Load Balancer.

   - To view the JBoss EAP on Azure web page - open a web browser and go to *http://<PUBLIC_IP_LoadBalancer>:8080/* and you should see the default EAP welcome page.

   - To log into the JBoss EAP Admin Console - open a web browser and go to *http://<PUBLIC_IP_LoadBalancer>:9990*. Enter the JBoss EAP username and password to log in.

     ![alt text](images/admin.png)

## Troubleshooting

This section includes common errors faced during deployments and details on how you can troubleshoot these errors.

#### Azure Platform

- Your deployment will not start if the parameter criteria are not fulfilled (ex - the admin password criteria were not met) or if any mandatory parameters aren't provided in the parameters section. You can review the details of parameters before clicking on *Create*.

- Once the deployment starts the resources being deployed will be visible on the deployment page. If there is a deployment failure after the parameter validation process, a more detailed failure message is available.

- If your deployment fails at the **VM Custom Script Extension** resource, a more detailed failure message is available in the VM log file. Please refer to the next section for further troubleshooting.

#### Troubleshooting EAP deployment extension

These offers use VM Custom Script Extensions to deploy JBoss EAP and configure the JBoss EAP management user. Your deployment can fail at this stage due to several reasons such as:

- Invalid RHSM or EAP entitlement
- Invalid JBoss EAP or RHEL OS entitlement Pool ID

Follow the steps below to troubleshoot this further:

1. Log in to the provisioned virtual machine through SSH. You can retrieve the Public IP of the VM from the Azure portal VM overview page.

2. Switch to root user

    ```
    sudo su -
    ```

3. Enter the VM admin password if prompted.

4. Change directory to logging directory

    ```
    cd /var/lib/waagent/custom-script/download/0 #for EAP on RHEL stand-alone VM
    ```

    ```
    cd /var/lib/waagent/custom-script/download/1 #for EAP on RHEL clustered VM
    ```

5. Review the logs in eap.log log file.

    ```
    more eap.log
    ```

This log file will have details that include deployment failure reason and possible solutions. If your deployment failed due to RHSM account or entitlements, please refer to 'Support and subscription notes' section to complete the prerequisites and try again. If you are deploying EAP on RHEL clustered plan, you should also make sure that the deployment doesn't hit the quota limit, hence check your regional vCPU quotas and VM series vCPU quotas before you provide the instance count for deployment. If your subscription or region doesn't have enough quota limit [request for quota](https://docs.microsoft.com/azure/azure-portal/supportability/regional-quota-requests) from your Azure portal.

Please refer to [Using the Azure Custom Script Extension Version 2 with Linux VMs](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-linux) for more details on troubleshooting VM custom script extensions.

## Resource Links:

* Learn more about [JBoss EAP](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform)
* [JBoss EAP on Azure Red Hat OpenShift](https://azure.microsoft.com/services/openshift/)
* [JBoss EAP on Azure App Service Linux](https://docs.microsoft.com/azure/app-service/quickstart-java) Quickstart
* [How to deploy JBoss EAP onto Azure App Service](https://github.com/JasonFreeberg/jboss-on-app-service) tutorial
* [Azure Hybrid Benefits](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing)
* [Configuring a Java app for Azure App Service](https://docs.microsoft.com/azure/app-service/configure-language-java)


## Next steps

* Learn more about [JBoss EAP 7.3](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform)
* Learn more about [Red Hat Subscription Management](https://access.redhat.com/products/red-hat-subscription-management)
* Microsoft docs for [Red Hat on Azure](https://aka.ms/rhel-docs)
* Deploy [JBoss EAP on RHEL VM/Virtual Machine Scale Set from Azure Marketplace](https://aka.ms/AMP-JBoss-EAP)
* Deploy [JBoss EAP on RHEL VM/Virtual Machine Scale Set from Azure Quickstart](https://aka.ms/Quickstart-JBoss-EAP)
