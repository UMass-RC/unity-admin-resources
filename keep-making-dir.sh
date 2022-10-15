#!/bin/bash
while true; do
	if [ ! -d /run/sshd ]; then
		mkdir /run/sshd
		chmod 755 /run/sshd
		echo misssing dir! $(date)
	fi
	sleep 1
done
