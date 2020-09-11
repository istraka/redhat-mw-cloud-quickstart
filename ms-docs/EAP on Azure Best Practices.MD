---
title: Quickstart - Red Hat JBoss EAP on Azure Best Practices
description: This guide provides information on the best practices for using Red Hat JBoss Enterprise Application Platform in Microsoft Azure.
author: theresa-nguyen
ms.author: bicnguy
ms.topic: quickstart
ms.date: 09/10/2020
---

# Red Hat JBoss EAP on Azure Best Practices

This quickstart is a Best Practices guide for using Red Hat JBoss Enterprise Application Platform in Microsoft Azure. JBoss EAP 7 can be used with the Microsoft Azure platform, as long as you use it within the specific supported configurations for running JBoss EAP in Azure. If you are configuring a clustered JBoss EAP environment, you must apply the specific configurations necessary to use JBoss EAP clustering features in Azure. This quickstart details the supported configurations of using JBoss EAP in Microsoft Azure.

Red Hat JBoss Enterprise Application Platform (JBoss EAP) 7.3 is a Jakarta EE 8 compatible implementation for both Web Profile and Full Platform specifications and is also a certified implementation of the Java Enterprise Edition (Java EE) 8 specification. Major versions of JBoss EAP are forked from the WildFly community project at certain points when the community project has reached the desired feature completeness level. After that point, an extended period of testing and productization takes place in which JBoss EAP is stabilized, certified, and enhanced for production use. During the lifetime of a JBoss EAP major version, selected features may be cherry-picked and back-ported from the community project into a series of feature enhancing minor releases within the same major version family.

## Features of JBoss EAP

JBoss EAP provides preconfigured options for features such as high-availability clustering, messaging, and distributed caching. It also enables users to write, deploy, and run applications using the various APIs and services that JBoss EAP provides.

* Jakarta EE compatible - Jakarta EE 8 compatible implementation for both Web Profile and Full Platform specifications.

* Java EE compliant - Java Enterprise Edition 8 full platform and Web Profile certified

* Management console and management CLI - Standalone server management interfaces. The management CLI also includes a batch mode that can script and automate management tasks. Directly editing the JBoss EAP XML configuration files is not recommended.

* Simplified directory layout - The modules directory contains all application server modules. The standalone directories contain the artifacts and configuration files for standalone deployments.

* Modular class-loading mechanism - Modules are loaded and unloaded on demand. This improves performance, has security benefits, and reduces start-up and restart times.

* Streamlined datasource management - Database drivers are deployed like other services. In addition, datasources are created and managed using the management console and management CLI.

* Unified security framework - Elytron provides a single unified framework that can manage and configure access for standalone servers. It can also be used to configure security access for applications deployed to JBoss EAP servers.

## Supported and Unsupported Configurations

The only virtual machine operating systems supported for using JBoss EAP in Microsoft Azure are:

* Red Hat Enterprise Linux 7 or above
* Microsoft Windows Server 2012 R2
* Microsoft Windows Server 2016

The Red Hat Cloud Access program allows you to use a JBoss EAP subscription to install JBoss EAP on your own Azure virtual machine or one of the above On-Demand operating systems from the Microsoft Azure Marketplace. Note that virtual machine operating system subscriptions are separate from a JBoss EAP subscription. Red Hat Cloud Access is a Red Hat subscription feature that provides support for JBoss EAP on Red Hat certified cloud infrastructure providers, such as Amazon EC2 and Microsoft Azure. Red Hat Cloud Access allows you to move your subscriptions between traditional servers and public cloud-based resources in a simple and cost-effective manner.

You can find more information about [Red Hat Cloud Access on the Customer Portal](https://www.redhat.com/en/technologies/cloud-computing/cloud-access).

Every Red Hat JBoss EAP release is tested and supported on a variety of market-leading operating systems, Java Virtual Machines (JVMs), and database combinations. Red Hat provides both production and development support for supported configurations and tested integrations according to your subscription agreement in both physical and virtual environments. Other than the above operating system restrictions, check [supported configurations for JBoss EAP](https://access.redhat.com/articles/2026253), such as supported Java Development Kit (JDK) vendors and versions. It gives you information on supported configurations of various JBoss EAP versions like 7.0, 7.1, 7.2 and 7.3.

There are some unsupported features when using JBoss EAP in a Microsoft Azure environment.

* Managed Domains - The managed domain operating mode allows for the management of multiple JBoss EAP instances from a single control point. Unfortunately JBoss EAP managed domains are not supported in Microsoft Azure. Only standalone JBoss EAP server instances are supported. Note that configuring JBoss EAP clusters using standalone JBoss EAP servers is supported in Azure.

* ActiveMQ Artemis High Availability Using a Shared Store - JBoss EAP messaging high availability using Artemis shared stores is not supported in Microsoft Azure.

* mod_custer Advertising - You cannot use JBoss EAP as an Undertow mod_cluster proxy load balancer, the mod_cluster advertisement functionally is unsupported because of Azure UDP multicast limitations.

## Creating Your Microsoft Azure Environment

You must create the virtual machines that will host your JBoss EAP instances in your Microsoft Azure environment. The virtual machines must use an Azure size of Standard_A2 or higher. You can use either the Azure On-Demand premium images to create your virtual machines or create your own virtual machines manually. For example you can deploy Red Hat Enterprise Linux virtual machines as follows :

* Using the On-Demand Marketplace Red Hat Enterprise Linux 7 image in Azure - There are several offers in Azure Marketplace from where you can select the RHEL VM that you want to setup the JBoss EAP. Visit [deploy RHEL 7 VM from Azure Marketplace](https://access.redhat.com/articles/2421451).

* [Manually creating and provisioning a Red Hat Enterprise Linux 7 image for Azure](https://access.redhat.com/articles/uploading-rhel-image-to-azure)

For Microsoft Windows Server virtual machines, see the [Microsoft Azure documentation](https://docs.microsoft.com/azure/virtual-machines/windows/overview) for instructions on creating a Windows Server virtual machine in Microsoft Azure.

## JBoss EAP Installation

Once your virtual machine is setup, you can install the JBoss EAP. For installing JBoss EAP you need access to [Red Hat Customer Portal](https://access.redhat.com), which is the centralized platform for Red Hat knowledge and subscription resources. You can use the Red Hat Customer Portal to do the following:

- Manage and maintain Red Hat entitlements and support contracts.
- Download officially-supported software.
- Access product documentation and the Red Hat Knowledgebase.
- Contact Global Support Services.
- File bugs against Red Hat products.

We have used the variable *EAP_HOME* to denote the path to the JBoss EAP installation. Replace this variable with the actual path to your JBoss EAP installation.

- If you installed JBoss EAP using the ZIP install method, the install directory is the *jboss-eap-7.3* directory where you extracted the ZIP archive.
- If you installed JBoss EAP using the RPM install method, the install directory is */opt/rh/eap7/root/usr/share/wildfly/*.
- If you used the installer to install JBoss EAP, the default path for EAP_HOME is *${user.home}/EAP-7.3.0* :
    * For Red Hat Enterprise Linux : */home/USER_NAME/EAP-7.3.0/* 
    * For Microsoft Windows : *C:\Users\USER_NAME\EAP-7.3.0*
- If you used the Red Hat CodeReady Studio installer to install and configure the JBoss EAP server, the default path for EAP_HOME is *${user.home}/devstudio/runtimes/jboss-eap* :
    * For Red Hat Enterprise Linux : */home/USER_NAME/devstudio/runtimes/jboss-eap/*
    * For Microsoft Windows: *C:\Users\USER_NAME\devstudio\runtimes\jboss-eap* or *C:\Documents* and *Settings\USER_NAME\devstudio\runtimes\jboss-eap*

### Preparing for Installation

There are several different ways to install JBoss EAP. Each method is best used in certain situations. If you are using a Red Hat Enterprise Linux On-Demand virtual machine from the Microsoft Azure Marketplace, you must install JBoss EAP using the ZIP or installer methods. You must not register a Red Hat Enterprise Linux On-Demand virtual machine to Red Hat Subscription Management, as you will be billed twice for that virtual machine.

* ZIP Installation - The ZIP archive is suitable for installation on all supported operating systems. This method should be used if you wish to extract the instance manually. The ZIP installation provides a default installation of JBoss EAP, and all configuration must be done following installation. Please check [Zip Installation method](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/installation_guide/index#zip_installation) for more details.

* JAR Installer - The JAR installer can either be run in a console or as a graphical wizard. Both options provide step-by-step instructions for installing and configuring the server instance. This is the preferred method to install JBoss EAP on all supported platforms. For more information about check [JAR Installer](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/installation_guide/index#installer_installation).

* RPM Installation - JBoss EAP can be installed using RPM packages on supported installations of Red Hat Enterprise Linux 6, Red Hat Enterprise Linux 7, and Red Hat Enterprise Linux 8. For more information about check [RPM Installation](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/installation_guide/index#rpm_installation).


## Other offers by Azure and Red Hat

Red Hat and Microsoft have partnered to bring a set of Azure solution templates to the Azure Marketplace to provide a solid starting point for migrating to Azure. Consult the documentation for the list of offers and choose a suitable environment.

**Azure Marketplace Offers**

Red Hat in partnership with Microsoft has published the following offerings in Azure Marketplace. You can access these offers from [Azure Marketplace](https://azuremarketplace.microsoft.com/)

It includes various combinations of EAP and RHEL versions to support your requirements. JBoss EAP licensing is always BYOS(Bring-Your-Own-Subscription) whereas for RHEL OS you can choose from BYOS(Bring-Your-Own-Subscription) or PAYG(Pay-As-You-Go).

* JBoss EAP 7.2 on RHEL 7.7 VM(BYOS)
* JBoss EAP 7.2 on RHEL 7.7 VM(PAYG)
* JBoss EAP 7.2 on RHEL 8.0 VM(BYOS)
* JBoss EAP 7.2 on RHEL 8.0 VM(PAYG)
* JBoss EAP 7.3 on RHEL 8.0 VM(BYOS)
* JBoss EAP 7.3 on RHEL 8.0 VM(PAYG)

**Azure QuickStart Templates**

Along with Azure Marketplace offers, there are quickstart templates made available for you to give a quick start to EAP on Azure environment. These quickstarts include pre-built ARM templates and script to deploy JBoss EAP on Azure in various configurations and version combinations. Solution architecture includes:

* JBoss EAP on standalone RHEL VM
* JBoss EAP clustered across Multiple RHEL VMs
* JBoss EAP clustered using VMSS (Azure Virtual Machine Scale Set)

You can choose to start with one of the quickstart templates which meets your desired deployment goal. Following is the list of available quickstart templates.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap72-standalone-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2 running on RHEL 7.7 VM.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap72-standalone-rhel8" target="_blank"> JBoss EAP 7.2 on RHEL 8.0 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.2 running on RHEL 8.0 VM.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap73-standalone-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (stand-alone VM)</a> - This Azure template deploys a web application named JBoss-EAP on Azure on JBoss EAP 7.3 running on RHEL 8.0 VM.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-clustered-multivm-rhel7" target="_blank">JBoss EAP 7.2 on RHEL 7.7 (clustered VMs)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on 'n' number RHEL 7.7 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-clustered-multivm-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (clustered VMs)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on 'n' number of RHEL 8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap73-clustered-multivm-rhel8" target="_blank"> JBoss EAP 7.3 on RHEL 8.0 (clustered VMs)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.3 cluster running on 'n' number of RHEL 8.0 VMs where n is decided by the user and all the VMs are added to the backend pool of a Load Balancer.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-clustered-vmss-rhel7" target="_blank"> JBoss EAP 7.2 on RHEL 7.7 (clustered VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on RHEL 7.7 VMSS instances.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap-clustered-vmss-rhel8" target="_blank">JBoss EAP 7.2 on RHEL 8.0 (clustered VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.2 cluster running on RHEL 8.0 VMSS instances.

* <a href="https://github.com/Azure/azure-quickstart-templates/tree/master/jboss-eap73-clustered-vmss-rhel8" target="_blank">JBoss EAP 7.3 on RHEL 8.0 (clustered VMSS)</a> - This Azure template deploys a web application called eap-session-replication on JBoss EAP 7.3 cluster running on RHEL 8.0 VMSS instances.

## Configuring JBoss EAP to Work on Cloud Platforms

Once you install the JBoss EAP in your virtual machine, you can configure JBoss EAP to run as a service. Configuring JBoss EAP to run as a service depends on the JBoss EAP installation method and type of virtual machine OS. For more information check [Configuring JBoss EAP to run as a service](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/installation_guide/index#configuring_jboss_eap_to_run_as_a_service).

### Starting and Stopping JBoss EAP

#### Starting JBoss EAP

JBoss EAP is supported on Red Hat Enterprise Linux, and Windows Server, and runs only in a standalone server operating mode. The specific command to start JBoss EAP depends on the underlying platform. Servers are initially started in a suspended state and will not accept any requests until all required services have started, at which time the servers are placed into a normal running state and can start accepting requests. Following is the command to start the JBoss EAP as a Standalone server :

- Command to start the JBoss EAP as a Standalone server in RHEL VM :

    `$EAP_HOME/bin/standalone.sh`

- For Windows Server use the `EAP_HOME\bin\standalone.bat` script to start the JBoss EAP as a Standalone server. 

This startup script uses the `EAP_HOME/bin/standalone.conf` file, or `standalone.conf.bat` for Windows Server, to set some default preferences, such as JVM options. You can customize the settings in this file. JBoss EAP uses the *standalone.xml* configuration file by default, but can be started using a different one. For details on the available standalone configuration files and how to use them, check the [Standalone Server Configuration Files](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#standalone_server_configuration_files).

To start JBoss EAP with a different configuration, use the --server-config argument. For a complete listing of all available startup script arguments and their purposes, use the --help argument or check the [Server Runtime Arguments](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#reference_of_switches_and_arguments_to_pass_at_server_runtime)

#### Stopping JBoss EAP

The way that you stop JBoss EAP depends on how it was started. Press `Ctrl+C` in the terminal where JBoss EAP was started to stop an Interactive Instance of JBoss EAP. To stop the background instance of JBoss EAP use the management CLI to connect to the running instance and shut down the server. For more details check [Stopping JBoss EAP](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#stopping_jboss_eap).

#### Running JBoss EAP in Admin-only Mode

JBoss EAP has the ability to be started in admin-only mode. This enables JBoss EAP to run and accept management requests but not start other runtime services or accept end user requests. For more information and related commands check [running JBoss EAP in Admin-only Mode](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#running_eap_in_admin_only_mode).

#### Starting JBoss EAP (RPM Installation)

Starting JBoss EAP is different for an RPM installation compared to a ZIP or installer installation. The command for starting an RPM installation of JBoss EAP depends on which operating mode you want to start, standalone mode (only mode supported in Azure) and which Red Hat Enterprise Linux version you are running.

- For example, for Red Hat Enterprise Linux 7 and later, you must use the following command :

    `systemctl start eap7-standalone.service`

For more information on this, check [Starting JBoss EAP (RPM Installation)](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#starting_jboss_eap_rpm_installation).

#### Stopping JBoss EAP (RPM Installation)

Stopping JBoss EAP is different for an RPM installation compared to a ZIP or installer installation. The command for stopping an RPM installation of JBoss EAP depends on which operating mode you want to start, standalone mode (only mode supported in Azure) and which Red Hat Enterprise Linux version you are running.

- For example, for Red Hat Enterprise Linux 7 and later, you must use the following command :

    `systemctl stop eap7-standalone.service`

### Management Users

The default JBoss EAP configuration provides local authentication so that a user can access the management CLI on the local host without requiring authentication. However, you must add a management user if you want to access the management CLI remotely or use the management console. If you attempt to access the management console before adding a management user, you will receive an error message. For more information on managing and adding users, check [Management Users](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#management_users).

### Configuring JBoss EAP Subsystems to Work on Cloud Platforms

Many of the APIs and capabilities that are exposed to applications deployed to JBoss EAP are organized into subsystems. These subsystems can be configured by administrators to provide different behavior, depending on the goal of the application. For more details on the subsystems, check [JBoss EAP Subsystems](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#jboss_eap_subsystems).


Some JBoss EAP subsystems must be configured to work properly on cloud platforms. This is required because a JBoss EAP server is usually bound to a cloud virtual machine’s private IP address, which is only visible from within the cloud platform. For certain subsystems, this address must also be mapped to a server’s public IP address, which is visible from outside the cloud.

#### Web Services

Web Services configure published endpoint addresses and endpoint handler chains, as well as the ports, and WSDL address for the web services provider. Web services provide a standard means of interoperating among different software applications. Web services facilitate internal, heterogeneous subsystem communication. The interoperability increases service reuse because functions do not need to be rewritten for various environments. More information for the *webservices* subsystem can be found in [Developing Web Services Applications](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/developing_web_services_applications/index) for JBoss EAP.

When a client makes a web service request using `Service.create(wsdlURL, serviceName);`, the user connects to the server public IP address, but is subsequently redirected to an address defined in the server configuration files in the webservices subsystem. By default, this address is `${jboss.bind.address:127.0.0.1}`, which means that on a cloud platform, the caller will be redirected to the server’s private IP address and will be unable to resolve the request. The server’s public IP address has to be configured in the wsdl-host element, using the following command :

`/subsystem=webservices:write-attribute(name=wsdl-host,value=PUBLIC_IP_ADDRESS)`

#### Messaging

Messaging-activemq subsystem configure JMS destinations, connection factories, and other settings for Artemis, the integrated messaging provider. Messaging systems allow you to loosely couple heterogeneous systems together with added reliability. More information for the *messaging-activemq* subsystem can be found in [Configuring Messaging](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuring_messaging/index) for JBoss EAP.

When using messaging on a cloud platform, the connection factory that the client uses must have a connector pointing to the server’s public IP address. For this reason a new connector and socket binding must be created for JBoss EAP servers running a full profile.

1. The referenced *http-public* socket binding must be created within the *socket-binding-group*:

    `/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=http-public:add(host=PUBLIC_IP_ADDRESS,port=${jboss.http.port:8080})`

2. Create the new *http-connector* element in the *messaging* subsystem:

    `/subsystem=messaging-activemq/server=default/http-connector=http-public-connector:add(endpoint=http-acceptor, socket-binding=http-public)`

3. Set the *connectors* in the *connection-factory*, which will be used by clients. For example, configuration of *RemoteConnectionFactory* as the default connection will be:

    `/subsystem=messaging-activemq/server=default/connection-factory=RemoteConnectionFactory:write-attribute(name=connectors, value=["http-public-connector"]`

#### Remoting subsystem Configuration for High Availability

The remoting subsystem allows you to configure inbound and outbound connections for local and remote services as well as the settings for those connections. JBoss Remoting includes the following configurable elements: the endpoint, connectors, and a series of local and remote connection URIs. More information for the *remoting* subsystem can be found in [Configuring Remoting](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/configuration_guide/index#configuring_remoting).

If you are using JBoss EAP High Availability features with clustered EJBs on a cloud platform, some extra configuration for the remoting subsystem is required to ensure EJB clients can receive cluster view updates.

This is done by configuring *client-mappings* for the *remoting* subsystem socket binding:

`/socket-binding-group=standard-sockets/socket-binding=http:write-attribute(name=client-mappings,value=[{ "destination-address" => "PUBLIC_IP_ADDRESS", "destination-port" => "8080" }])`


## Using JBoss EAP High Availability in Microsoft Azure

Microsoft Azure does not support JGroups discovery protocols that are based on UDP multicast. JGroups uses the UDP stack by default, make sure you change that to TCP since Azure does not support UDP. Although you can use other JGroups discovery protocols like TCPPING, JDBC_PING etc, we would recommend the shared file discovery protocol specifically developed for Azure which is the *Azure_PING*.

*AZURE_PING* uses a common blob container in a Microsoft Azure storage account. If you do not already have a blob container that AZURE_PING can use, create one that your virtual machines can access. For more information, check [Configuring JBoss EAP High Availability in Microsoft Azure](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/using_jboss_eap_in_microsoft_azure/index#using_jboss_eap_high_availability_in_microsoft_azure).

You can also configure JBoss EAP with load balancing environment by ensuring that all balancers and workers are bound to IP addresses that are accessible on your internal Microsoft Azure virtual network. Additionally, because of the unavailability of mod_cluster advertising in Azure, if you are using JBoss EAP as an Undertow mod_cluster proxy load balancer, you must configure each worker node to use a proxy list containing each balancer’s IP address and port, as shown below:

`/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=proxy-one:add(host="BALANCER_IP_ADDRESS", port="BALANCER_PORT")`

`/subsystem=modcluster/mod-cluster-config=configuration:list-add(name=proxies,value=proxy-one)`


## Optimizing the JBoss EAP Server Configuration

Once you have installed the JBoss EAP server, and you have created a management user, you can optimize your server configuration. Make sure you review information in the [Performance Tuning Guide](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html-single/performance_tuning_guide/index) for information about how to optimize the server configuration to avoid common problems when deploying applications in a production environment

## Resource Links

* Learn more about [JBoss EAP](https://access.redhat.com/documentation/en/red_hat_jboss_enterprise_application_platform/7.3/html/getting_started_with_jboss_eap_for_openshift_online/introduction)
* Learn more about [Red Hat Subscription Manager (Cloud Access)](https://access.redhat.com/documentation/en/red_hat_subscription_management/1/html-single/red_hat_cloud_access_reference_guide/index)
* Learn more about [Azure Red Hat OpenShift](https://azure.microsoft.com/services/openshift/)
* [MS Docs for Red Hat on Azure](https://aka.ms/rhel-docs)

## Support

For any support related questions, issues or customization requirements, please contact [Red Hat Support](https://access.redhat.com/support).















