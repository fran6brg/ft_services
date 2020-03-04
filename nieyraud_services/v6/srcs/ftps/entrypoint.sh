#! bin/sh

#nohup touch /run/openrc/softlevel && rc-service vsftpd restart &
touch /run/openrc/softlevel && rc-service vsftpd restart && tail -f /dev/null
