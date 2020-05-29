#!/bin/sh

adddate() {
    while IFS= read -r line; do
        printf '%s %s\n' "$(date "+%Y-%m-%d %H:%M:%S")" "$line";
    done
}

export EAP_HOME="/opt/rh/eap7/root/usr/share/wildfly"

JBOSS_EAP_USER=$1
JBOSS_EAP_PASSWORD=$2

/bin/date +%H:%M:%S >> adduser.log
echo "Configuring JBoss EAP management user" | adddate >> adduser.log
echo "$EAP_HOME/bin/add-user.sh -u JBOSS_EAP_USER -p JBOSS_EAP_PASSWORD -g 'guest,mgmtgroup'" | adddate >> adduser.log
$EAP_HOME/bin/add-user.sh -u $JBOSS_EAP_USER -p $JBOSS_EAP_PASSWORD -g 'guest,mgmtgroup' >> adduser.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! JBoss EAP management user configuration Failed" | adddate >> adduser.log; exit $flag;  fi

echo "Start JBoss-EAP service" | adddate >> adduser.log
echo "$EAP_HOME/bin/standalone.sh -c standalone-full.xml -b $IP_ADDR -bmanagement $IP_ADDR &" | adddate >> adduser.log
$EAP_HOME/bin/standalone.sh -c standalone-full.xml -b $IP_ADDR -bmanagement $IP_ADDR & >> adduser.log 2>&1
flag=$?; if [ $flag != 0 ] ; then echo  "ERROR! Starting JBoss EAP service Failed" | adddate >> adduser.log; exit $flag;  fi 

# Seeing a race condition timing error so sleep to deplay
sleep 20

echo "ALL DONE!" | adddate >> adduser.log
/bin/date +%H:%M:%S >> adduser.log
