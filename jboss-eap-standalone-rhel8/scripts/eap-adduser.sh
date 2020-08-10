#!/bin/sh

adddate() {
    while IFS= read -r line; do
        printf '%s %s\n' "$(date "+%Y-%m-%d %H:%M:%S")" "$line";
    done
}

export EAP_HOME="/opt/rh/eap7/root/usr/share/wildfly"
export EAP_RPM_CONF_STANDALONE="/etc/opt/rh/eap7/wildfly/eap7-standalone.conf"

JBOSS_EAP_USER=$1
JBOSS_EAP_PASSWORD=$2
RHSM_USER=$3
RHSM_PASSWORD=$4
RHSM_POOL=$5
PLAN=${6}

echo "JBoss plan : " ${PLAN} | adddate >> eap.log
if [ ${PLAN} == "JBoss EAP7.2 on RHEL7.7 PAYG" ] 
then
echo "Initial JBoss EAP 7.2 setup" | adddate >> eap.log
echo "subscription-manager register --username RHSM_USER --password RHSM_PASSWORD" | adddate >> eap.log
subscription-manager register --username $RHSM_USER --password $RHSM_PASSWORD >> eap.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! Red Hat Subscription Manager Registration Failed" | adddate >> eap.log; exit $flag;  fi
echo "subscription-manager attach --pool=EAP_POOL" | adddate  >> eap.log
subscription-manager attach --pool=${RHSM_POOL} >> eap.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! Pool Attach for JBoss EAP Failed" | adddate  >> eap.log; exit $flag;  fi
echo "Subscribing the system to get access to JBoss EAP 7.2 repos" | adddate >> eap.log

# Install JBoss EAP 7.2
echo "subscription-manager repos --enable=jb-eap-7-for-rhel-7-server-rpms" | adddate >> eap.log
subscription-manager repos --enable=jb-eap-7-for-rhel-7-server-rpms >> eap.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! Enabling repos for JBoss EAP Failed" | adddate >> eap.log; exit $flag;  fi
echo "yum-config-manager --disable rhel-7-server-htb-rpms" | adddate >> eap.log
yum-config-manager --disable rhel-7-server-htb-rpms | adddate >> eap.log

echo "Installing JBoss EAP 7.2 repos" | adddate >> eap.log
echo "yum groupinstall -y jboss-eap7" | adddate >> eap.log
yum groupinstall -y jboss-eap7 >> eap.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! JBoss EAP installation Failed" | adddate >> eap.log; exit $flag;  fi

echo "Start JBoss-EAP service" | adddate >> eap.log
echo "systemctl enable eap7-standalone.service" | adddate >> eap.log
systemctl enable eap7-standalone.service | adddate >> eap.log 2>&1
echo "echo "WILDFLY_OPTS=-Djboss.bind.address.management=0.0.0.0" >> ${EAP_RPM_CONF_STANDALONE}" | adddate >> eap.log
echo 'WILDFLY_OPTS="-Djboss.bind.address.management=0.0.0.0"' >> ${EAP_RPM_CONF_STANDALONE} | adddate >> eap.log 2>&1

echo "systemctl restart eap7-standalone.service" | adddate >> eap.log
systemctl restart eap7-standalone.service | adddate >> eap.log 2>&1
echo "systemctl status eap7-standalone.service" | adddate >> eap.log
systemctl status eap7-standalone.service | adddate >> eap.log 2>&1

# Open Red Hat software firewall for port 8080 and 9990:
echo "firewall-cmd --zone=public --add-port=8080/tcp --permanent" | adddate >> eap.log
firewall-cmd --zone=public --add-port=8080/tcp --permanent | adddate >> eap.log 2>&1
echo "firewall-cmd --zone=public --add-port=9990/tcp --permanent" | adddate >> eap.log
firewall-cmd --zone=public --add-port=9990/tcp --permanent | adddate  >> eap.log 2>&1
echo "firewall-cmd --reload" | adddate >> eap.log
firewall-cmd --reload | adddate >> eap.log 2>&1

# Open Red Hat software firewall for port 22:
echo "firewall-cmd --zone=public --add-port=22/tcp --permanent" | adddate >> eap.log
firewall-cmd --zone=public --add-port=22/tcp --permanent | adddate >> eap.log 2>&1
echo "firewall-cmd --reload" | adddate >> eap.log
firewall-cmd --reload | adddate >> eap.log 2>&1
fi

/bin/date +%H:%M:%S >> eap.log
echo "Configuring JBoss EAP management user" | adddate >> eap.log
echo "$EAP_HOME/bin/add-user.sh -u JBOSS_EAP_USER -p JBOSS_EAP_PASSWORD -g 'guest,mgmtgroup'" | adddate >> eap.log
$EAP_HOME/bin/add-user.sh -u $JBOSS_EAP_USER -p $JBOSS_EAP_PASSWORD -g 'guest,mgmtgroup' >> eap.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! JBoss EAP management user configuration Failed" | adddate >> eap.log; exit $flag;  fi 

# Seeing a race condition timing error so sleep to delay
sleep 20

echo "ALL DONE!" | adddate >> eap.log
/bin/date +%H:%M:%S >> eap.log
