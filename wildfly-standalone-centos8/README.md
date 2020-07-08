# WildFly 18 on CentOS 8 (stand-alone VM)
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fredhat-mw-cloud-quickstart%2Fmaster%2Fwildfly-standalone-centos8%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

`Tags: WildFly 18.0.1.Final, Red Hat, CentOS, Java, Java EE, Jakarta EE, Azure, Azure VM`

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

This template creates a standalone node of WildFly on CentOS VM of Standard_DS2_v2 size (users can select the size of the VM from the dropdown options) in your Resource Group (RG) which includes a Public DNS name, Virtual Network and Network Security Group. It is ideal for development and testing of enterprise Java applications on Azure.

WildFly is an open-source application server runtime that is exceptionally fast, flexible, lightweight and powerful. It is Jakarta EE 8 Full Platform and Web Profile compatible.  The state-of-the-art architecture built on the Modular Service Container enables services on-demand when your application requires them.

The technology behind WildFly is also available in Red Hat JBoss Enterprise Application Platform (EAP), a hardened enterprise subscription including Red Hat world-class support, long multi-year maintenance cycles and exclusive content. JBoss EAP is an open-soure application server that you can download for free for development use. To obtain a Red Hat Subscription Management (RHSM) account for JBoss EAP, go to: www.redhat.com. Red Hat Subscription Management (RHSM) is a customer-driven, end-to-end solution that provides tools for subscription status and management and integrates with Red Hat's system management tools.

To learn more visit the [Wildfly Documentation](https://docs.wildfly.org/18/) site.

## Template Solution Architecture 

This Azure Resource Manager (ARM) template creates all the Azure compute resources to run WildFly 18.0.1.Final on top of CentOS 8.0 VM. The following resources are created by this template:

- CentOS 8 Virtual Machine
- Public IP 
- Virtual Network 
- Network Security Group 
- WildFly 18.0.1.Final
- Sample Java application named JBoss-EAP on Azure deployed on WildFly

Following is the Architecture:

![alt text](images/wildfly-arch.png)

## Subscriptions and Costs 

This ARM template uses an Azure CentOS 8 image which is a Pay-As-You-Go (PAYG) VM image and does not require the user to license. The VM will be licensed automatically after the instance is launched for the first time and the user will be charged hourly in addition to Microsoft's Linux VM rates. [Linux Virtual Machine](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/#linux) provides pricing details. WildFly is free to download and use and does not require a Red Hat Subscription or License.

## Prerequisites 

1. Azure Subscription with specified payment method. CentOS-Based 8.0 is an Azure Marketplace product and requires a payment method to be specified in the Azure Subscription.

2. To create the VM, you will need:

    - **Admin Username** and password or SSH key data which is an SSH RSA public key for your VM.

    - **WildFly Username** and password to enable the WildFly Admin Console and Deployment method.

## Deployment Steps  

Build your environment with WildFly 18.0.1.Final on top of CentOS 8.0 on Azure in a few simple steps:  
1. Launch the template by clicking on the **Deploy to Azure** button.  
2. Complete the following parameter values, accept the Terms and Conditions and click on the **Purchase** button.

    - **Subscription** - Choose the appropriate subscription for deployment.

    - **Resource Group** - Create a new Resource Group or select an existing one.

    - **Location** - Choose the appropriate location for deployment.

    - **Admin Username** - User account name for logging into the CentOS VM.

    - **Authentication Type** - Type of authentication to use on the VM (password or SSH key).

    - **Admin Password or SSH key** - User account password or SSH key data which is an SSH RSA public key for logging into the CentOS VM.

    - **WildFly Username** - Username for WildFly Console Manager.

    - **WildFly Password** - User account password for WildFly Console Manager.

    - **VM Size** - Select the appropriate size of the VM from the dropdown options.

    - Leave the rest of the parameter values (Artifacts and Location) as is, accept the Terms & Conditions and proceed to purchase.

## Deployment Time 

The deployment takes less than 10 minutes to complete.

## Validation Steps

- Once the deployment is successful, go to the Outputs section of the deployment to obtain the **VM DNS name**, **app URL** and the **Admin Console URL**:

  ![alt text](images/output.png)

- Paste the app URL that you copied from the Output page in a browser to view the JBoss-EAP on Azure web page.

  ![alt text](images/app.png)

- Paste the Admin Console URL that you copied from the Output page in a browser to access the WildFly Admin Console and enter the Wildfly Username and password to login.

  ![alt text](images/wildfly-console.png)

## Troubleshooting

This section includes common errors faced during deployments and details on how you can troubleshoot these errors. 

#### Azure Platform

- If the parameter criteria are not fulfilled (ex - the admin password criteria was not met) or if any mandatory parameters are not provided in the parameters section then the deployment will not start. The *Terms & Conditions* must be accepted before clicking on *Purchase*.

- Once the deployment starts the resources being deployed will be visible on the deployment page. In the case of any deployment failure, after parameter validation process, a more detailed failure message is available.

- If your deployment fails at the **VM Custom Script Extension** resource, a more detailed failure message is available in the VM log file. Please refer to the next section for further troubleshooting.

#### Troubleshooting EAP deployment extension

Follow the steps below to troubleshoot VM Custom Script Extension failures further:

1. Log into the provisioned VM through SSH. You can retrieve the Public IP of the VM using the Azure portal VM *Overview* page.

2. Switch to root user

    `sudo su -`

3. Enter your VM admin password if prompted.

4. Change directory to logging directory

    `cd /var/lib/waagent/custom-script/download/0`

5. Review the logs in wildfly.install.log log file.

    `more wildfly.install.log`

This log file will have details that include deployment failure reason and possible solutions.

Please refer to [Using the Azure Custom Script Extension Version 2 with Linux VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-linux) for more details on troubleshooting VM custom script extensions.

## Support 

For any support related questions, issues or customization requirements, please contact [Spektra Systems](info@spektrasystems.com) or [Red Hat Support](https://www.redhat.com/en/services/support).
