1.2 Kickstart JBoss EAP on Azure experience

Red Hat and Microsoft have partnered to bring a set of Azure solution templates to the Azure Marketplace to provide a solid starting point for migrating to Azure. Consult the documentation for the list of offers and choose a suitable environment. They have published offers of JBoss EAP on RHEL that will install and provision on Azure VM instance in less than 20 minutes. You can access these offers from [Azure Marketplace](https://azuremarketplace.microsoft.com/)

This Marketplace offer includes various combinations of EAP and RHEL versions to support your requirements on either standalone RHEL VM or clustered RHEL VMSS. JBoss EAP licensing is always BYOS(Bring-Your-Own-Subscription) whereas for RHEL OS you can choose from BYOS or PAYG (Pay-As-You-Go). Following are the 12 plans we provide for EAP on RHEL offer.

* JBoss EAP 7.2 on RHEL 7.7 VM(BYOS)
* JBoss EAP 7.2 on RHEL 7.7 VM(PAYG)
* JBoss EAP 7.2 on RHEL 8.0 VM(BYOS)
* JBoss EAP 7.2 on RHEL 8.0 VM(PAYG)
* JBoss EAP 7.3 on RHEL 8.0 VM(BYOS)
* JBoss EAP 7.3 on RHEL 8.0 VM(PAYG)
* JBoss EAP 7.2 on RHEL 7.7 VMSS(BYOS)
* JBoss EAP 7.2 on RHEL 7.7 VMSS(PAYG)
* JBoss EAP 7.2 on RHEL 8.0 VMSS(BYOS)
* JBoss EAP 7.2 on RHEL 8.0 VMSS(PAYG)
* JBoss EAP 7.3 on RHEL 8.0 VMSS(BYOS)
* JBoss EAP 7.3 on RHEL 8.0 VMSS(PAYG)

Along with Azure Marketplace offers, there are Quickstart templates made available for you to get started on your JBoss EAP on Azure journey. These Quickstarts include pre-built Azure Resource Manager(ARM) templates and script to deploy JBoss EAP on [Red Hat Enterprise Linux (RHEL)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) in various configurations and version combinations. The template includes deployment of the following resources:

* Load Balancer (LB)
* Private IP for load balancing and VMs
* Virtual Network (VNET) with a single subnet
* VM configuration (cluster or stand-alone)
* A sample Java application

Note that the users also have the option to choose between the Red Hat Enterprise Linux versions 7.7 and 8.0 and JBoss EAP versions 7.2 and 7.3. Users can select one of the following combinations for deployment of Quickstart template.

- JBoss EAP 7.2 on RHEL 7.7
- JBoss EAP 7.2 on RHEL 8.0
- JBoss EAP 7.3 on RHEL 8.0

You can choose to start with one of the quickstart templates with required JBoss EAP on RHEL version combination which meets your desired deployment goal. Following is the list of available quickstart templates.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-standalone-rhel" target="_blank"> JBoss EAP on RHEL (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2/EAP 7.3 running on RHEL 7.7/8.0 VM.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-clustered-multivm-rhel" target="_blank"> JBoss EAP on RHEL (clustered, multi-VM)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2/EAP 7.3 cluster running on 'n' number RHEL 7.7/8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-clustered-vmss-rhel" target="_blank"> JBoss EAP on RHEL (clustered, VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2/EAP 7.3 cluster running on RHEL 7.7/8.0 VMSS instances.