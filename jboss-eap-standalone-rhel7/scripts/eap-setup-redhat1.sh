#!/bin/sh

# $1 - VM Host User Name

/bin/date +%H:%M:%S >> /home/$1/install.progress.txt
echo "ooooo      RED HAT JBoss EAP7.2 RPM INSTALL      ooooo" >> /home/$1/install.progress.txt

export EAP_HOME="/opt/rh/eap7/root/usr/share/wildfly"
export EAP_ROOT="/opt/rh/eap7/root/usr/share"
export EAP_RPM_CONF_STANDALONE="/etc/opt/rh/eap7/wildfly/eap7-standalone.conf"
EAP_USER=$2
EAP_PASSWORD=$3
RHSM_USER=$4
RHSM_PASSWORD=$5
OFFER=$6
RHSM_POOL=$7
IP_ADDR=$(hostname -I)
Public_IP=$(curl ifconfig.me)

PROFILE=standalone
echo "JBoss EAP admin user"+${EAP_USER} >> /home/$1/install.progress.txt
echo "Public IP Address: " ${Public_IP} >> /home/$1/install.progress.txt
echo "Initial JBoss EAP7.2 setup" >> /home/$1/install.progress.txt
subscription-manager register --username $RHSM_USER --password $RHSM_PASSWORD  >> /home/$1/install.progress.txt 2>&1
subscription-manager attach --pool=${RHSM_POOL} >> /home/$1/install.progress.txt 2>&1
if [ $OFFER == "BYOS" ] 
then 
    echo "Attaching Pool ID for RHEL OS" >> /home/$1/install.progress.txt
    subscription-manager attach --pool=$8 >> /home/$1/install.progress.txt 2>&1
fi 
echo "Subscribing the system to get access to EAP 7.2 repos" >> /home/$1/install.progress.txt

# Install JBoss EAP7.2 
subscription-manager repos --enable=jb-eap-7-for-rhel-7-server-rpms >> /home/$1/install.out.txt 2>&1
yum-config-manager --disable rhel-7-server-htb-rpms

echo "Installing JBoss EAP7.2 repos" >> /home/$1/install.progress.txt
yum groupinstall -y jboss-eap7 >> /home/$1/install.out.txt 2>&1

echo "Update interfaces section update jboss.bind.address.management, jboss.bind.address and jboss.bind.address.private from 127.0.0.1 to 0.0.0.0" >> /home/$1/install.log
sed -i 's/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/g'  $EAP_ROOT/wildfly/standalone/configuration/standalone-full.xml
sed -i 's/jboss.bind.address:127.0.0.1/jboss.bind.address:0.0.0.0/g'  $EAP_ROOT/wildfly/standalone/configuration/standalone-full.xml

/opt/rh/eap7/root/usr/share/wildfly/bin/standalone.sh -c standalone-full.xml -b $Public_IP -bmanagement $Public_IP &

echo "Installing GIT" >> /home/$1/install.progress.txt
yum install -y git >> /home/$1/install.out.txt 2>&1

cd /home/$1
echo "Getting the sample dukes app to install" >> /home/$1/install.progress.txt
git clone https://github.com/MyriamFentanes/dukes.git >> /home/$1/install.out.txt 2>&1
mv /home/$1/dukes/target/dukes.war $EAP_HOME/standalone/deployments/dukes.war
cat > $EAP_HOME/standalone/deployments/dukes.war.dodeploy

echo "Configuring JBoss EAP management user" >> /home/$1/install.progress.txt
$EAP_HOME/bin/add-user.sh -u $EAP_USER -p $EAP_PASSWORD -g 'guest,mgmtgroup'

# Open Red Hat software firewall for port 8080 and 9990:
firewall-cmd --zone=public --add-port=8080/tcp --permanent  >> /home/$1/install.out.txt 2>&1
firewall-cmd --zone=public --add-port=9990/tcp --permanent  >> /home/$1/install.out.txt 2>&1
firewall-cmd --reload  >> /home/$1/install.out.txt 2>&1
    
echo "Done." >> /home/$1/install.progress.txt
/bin/date +%H:%M:%S >> /home/$1/install.progress.txt

# Open Red Hat software firewall for port 22:
firewall-cmd --zone=public --add-port=22/tcp --permanent >> /home/$1/install.out.txt 2>&1
firewall-cmd --reload >> /home/$1/install.out.txt 2>&1

# Seeing a race condition timing error so sleep to delay
sleep 20

echo "ALL DONE!" >> /home/$1/install.progress.txt
/bin/date +%H:%M:%S >> /home/$1/install.progress.txt
