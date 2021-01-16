#!/bin/bash

sudo passwd -l amira
sudo pkill -KILL -u amira
sudo tar cfjv backup_amira.tar.bz /home/amira
sudo crontab -r -u amira
sudo deluser --remove-home amira
