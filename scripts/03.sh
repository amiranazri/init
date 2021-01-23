#!/bin/bash
commands=("-createUser" "-updatePassword" "-checkUptime" "-loginAngryEmployee" "-generateSSHKeyOnUser" "-init")

LRED='\033[1;31m'
LBLUE='\033[1;34m'
LGREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m'
YELLOW='\033[1;33m'

function checkCommands() {
    isValidCommand=false
    for command in "${commands[@]}"; do
        if [ "$command" = "$1" ]; then
            actualCommand="$command"
            isValidCommand=true
        fi
    done
}

function createUser() {
    addUser $2
}

function updatePassword() {
    passwd $2
}

function checkUptime() {
    w
}
function loginAngryEmployee() {
    su $2
}

function generateSSHKeyOnUser() {
    sudo service ssh restart
    userName=$2
    if [ ! -d /root/.ssh ]; then
        ssh-keygen -N '' -f /root/.ssh/id_rsa <<<y
    fi
    sudo -H -u $userName bash -c "(umask 077 && test -d /home/${userName}/.ssh || mkdir /home/${userName}/.ssh);(umask 077 && touch /home/${userName}/.ssh/authorized_keys)"
    cat /root/.ssh/id_rsa.pub >>/home/$userName/.ssh/authorized_keys
    ssh $userName@127.0.0.1
}

function sectionOne() {
    sectionOneLowerLimit=1
    sectionOneUpperLimit=15
    printf "${YELLOW}\tWelcome to section $number \n${NC}"
    while true; do
        read -p "$(echo -e $YELLOW"\tPlease pick a question number(1-15) or 'b' to go back:
         $LBLUE   1. Get the list of the network interfaces of the machine without displaying any detail
            for these interfaces. Only the list of names.
            2. Identify and display the Ethernet interface characteristics:
                (a) Identify broadcast address
                (b) Identify all IP adresses which are part of the same subnet
            3. Identify the MAC address of the Wi-Fi card 
            4. Identifiy the default gateway in the routing table
            5. Identify the IP address of the DNS that responds to the following url: slash16.org $NC
           $LRED 6. Get the complete path of the file that contains the IP address of the DNS server you’re using(red)$NC
           $LBLUE 7. Query an external DNS server on the slash16.org domain name (ie. : google 8.8.8.8) $NC
           $LRED 8. Find the provider of slash16.org (red) $NC
           $LGREEN 9. Find the external IP of 42.fr$NC
           $LBLUE 10. Identify the network devices between your computer and the slash16.org domain$NC
           $LRED 11. Use the output of the previous command to find the name and IP address of the
            device that makes the link between you (local network) and the outside world (red)$NC
           $LBLUE 12. Figure out the exact size of each folder of /var in a humanly understandable way
            followed by the path of it.$NC
           $LGREEN 13. Thanks to the previous question and the reverse DNS find the name of your host (green)$NC
           $LRED 14. What file contains the local DNS entries?(red)
            15. Make the intra.42.fr address reroute to 46.19.122.85 (red)$NC
        "$NC)" sectionOneNumber
        if [ ! "$sectionOneNumber" = "b" ] && [ $sectionOneNumber -ge $sectionOneLowerLimit ] && [ $sectionOneNumber -le $sectionOneUpperLimit ]; then
            if [ $sectionOneNumber -eq 1 ]; then
                printf "${LBLUE}
            1. Get the list of the network interfaces of the machine without displaying any detail
            for these interfaces. Only the list of names.\n
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            lo0 gif0 stf0 en0 en1 bridge0 p2p0 awdl0 llw0 utun0 utun1
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 2 ]; then
                printf "${LBLUE}
            2. Identify and display the Ethernet interface characteristics:
                (a) Identify broadcast address
                (b) Identify all IP adresses which are part of the same subnet
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ifconfig

            ether 48:d7:05:bc:29:07
            broadcast 192.168.101.255
            netmask 0xffffff00

            /*This command displays all the devices conencted to our subnet*/
            arp -a

            ? (192.168.101.1) at 48:8f:5a:4a:8c:5d on en0 ifscope [ethernet]
            ? (192.168.101.202) at b8:c6:aa:ff:35:ab on en0 ifscope [ethernet]
            ? (192.168.101.217) at 98:5a:eb:e1:7a:da on en0 ifscope [ethernet]
            ? (224.0.0.251) at 1:0:5e:0:0:fb on en0 ifscope permanent [ethernet]
            ? (239.255.255.250) at 1:0:5e:7f:ff:fa on en0 ifscope permanent [ethernet]
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 3 ]; then
                printf "${LBLUE}
            3. Identify the MAC address of the Wi-Fi card  
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ifconfig -a
            ether 82:0d:78:61:00:00
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 4 ]; then
                printf "${LBLUE}
            4. Identifiy the default gateway in the routing table
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            route -n get default
            
            gateway: 192.168.101.1
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 5 ]; then
                printf "${LBLUE}
            5. Identify the IP address of the DNS that responds to the following url: slash16.org
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            nslookup slash16.org

            Server:		192.168.101.1
            Address:	192.168.101.1#53

            Non-authoritative answer:
            Name:	slash16.org
            Address: 13.225.84.69
            Name:	slash16.org
            Address: 13.225.84.89
            Name:	slash16.org
            Address: 13.225.84.84
            Name:	slash16.org
            Address: 13.225.84.228
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 6 ]; then
                printf "${LRED}
            6. Get the complete path of the file that contains the IP address of the DNS server you’re using(red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            cat /etc/resolv.conf

            scutil --dns | grep 'nameserver\[[0-9]*\]'

            nameserver[0] : 192.168.101.1
            nameserver[0] : 192.168.101.1
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 7 ]; then
                printf "${LBLUE}
            7. Query an external DNS server on the slash16.org domain name (ie. : google 8.8.8.8)
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            nslookup slash16.org

            Most DNS servers reference external servers (i.e. google 8.8.8.8 and 4.4.4.4 etc) in their record configurations.

            /etc/resolv.conf --> changed server name to 8.8.8.8
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 8 ]; then
                printf "${LRED}
            8. Find the provider of slash16.org (red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            is hosted by: Amazon.com

            #  /*Third-party sites like hostingchecker.com provide whoami information*/
            #  /*whoami slash16.org*/
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 9 ]; then
                printf "${LGREEN}
            9. Find the external IP of 42.fr
            ${NC}"
                printf "${LGREEN}
            ANSWER:\n\t
            nslookup 42.fr

            Server:		8.8.8.8
            Address:	8.8.8.8#53

            Non-authoritative answer:
            Name:	42.fr
            Address: 163.172.250.13
            Name:	42.fr
            Address: 163.172.250.12
            ${NC}"

            fi
            if [ $sectionOneNumber -eq 10 ]; then
                printf "${LBLUE}
            10. Identify the network devices between your computer and the slash16.org domain
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            traceroute slash16.org
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 11 ]; then
                printf "${LRED}
            11. Use the output of the previous command to find the name and IP address of the
            device that makes the link between you (local network) and the outside world (red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            /*First IP address that doesn't fall within my subnet mask*/

            dsl-197-245-187-1.voxdsl.co.za (  197.245.187.1)
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 12 ]; then
                printf "${LBLUE}
            12. Figure out the exact size of each folder of /var in a humanly understandable way
            followed by the path of it.
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ipconfig getpacket en0

            /*server_identifier (dhcp) and domain_name_server are the same thing*/

            server_identifier (ip): 192.168.101.1
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 13 ]; then
                printf "${LGREEN}
            13. Thanks to the previous question and the reverse DNS find the name of your host (green)
            ${NC}"
                printf "${LGREEN}
            ANSWER:\n\t
            /*Due to the fact that this project was made to be completed on campus using the wtc campus network, the hostname in this case is my IP address, found using nslookup */

            Hostname: 192.168.101.1
            ${NC}"
            fi
            if [ $sectionOneNumber -eq 14 ]; then
                printf "${LRED}
            14. What file contains the local DNS entries?(red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            The Hosts file
            The Domain Name System and its associated cache is your Mac's standard way of knowing how to get to where it's going on the Internet, but there's another file that can be very useful. It's called the Hosts file, and it can be used to override the default DNS information. This can be found in /etc/hosts

            ${NC}"
            fi
            if [ $sectionOneNumber -eq 15 ]; then
                printf "${LRED}
            15. Make the intra.42.fr address reroute to 46.19.122.85 (red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            check host file for new DNS entry for rerouting!
            ${NC}"
            fi
        elif [ "$sectionOneNumber" = "b" ]; then
            break
        fi
        read -n 1 -s -r -p "$(echo -e $YELLOW"Press any key to continue\n"$NC)" INPUT_VARIABLE
    done
}

function sectionTwo() {
    sectionTwoUpperLimit=24
    sectionTwoLowerLimit=1
    printf "${YELLOW}Welcome to section $number \n${NC}"
    while true; do
        read -p "$(echo -e $YELLOW"\tPlease pick a question number($sectionTwoLowerLimit-$sectionTwoUpperLimit) and 'b' to go back:$NC
        $LRED  1. In what file can you find the installed version of your Debian?$NC
        $LBLUE  2. What command can you use to rename your system?
        $LRED  3. What file has to be modified to make it permanent?$NC
        $LBLUE  4. What command gives you the time since your system was last booted?
          5. Identify the IP address of the DNS that responds to the following url: slash16.org
          6. Name the command that reboots the SSH service.
          7. Figure out the PID of the SSHD service.$NC
      $LRED    8. What file contains the RSA keys of systems that are authorized to connect via SSH?$NC
     $LBLUE     9. What command lets you know who is connected to the System?
     $LBLUE     10. Name the command that lists the partition tables of drives?
     $LBLUE     11. Name the command that displays the available space left and used on the system
            in an humanly understandable way
     $LBLUE     12. Figure out the exact size of each folder of /var in a humanly understandable way
            followed by the path of it.
     $LBLUE     13. Name the command that find, in real time, currently running processes.
     $LBLUE     14. Run the ‘tail -f /var/log/syslog‘ command in background.
     $LBLUE     15. Find the command that kills the background command’s process.
      $LRED    16. Find the service which makes it possible to run specific tasks following a regular 
            schedule.$NC
     $LBLUE     17. Find the command that allows you to connect via ssh on the VM.(In parallel with
            the graphic session)
          18. Find the command that kills ssh service.
          19. List all services which are started at boot time and name this kind of services.
          20. List all existing users on the VM.
          21. List all real users on the VM.
          22. Find the command that add a new local user$NC
      $LRED    23. Explain how connect yourself as new user. (With graphic session and ssh session)$NC
     $LBLUE     24. Find the command that list all packages.$NC
        "$NC)" sectionTwoNumber
        if [ ! "$sectionTwoNumber" = "b" ] && [ $sectionTwoNumber -ge $sectionTwoLowerLimit ] && [ $sectionTwoNumber -le $sectionTwoUpperLimit ]; then
            if [ $sectionTwoNumber -eq 1 ]; then
                printf "${LRED}
            1. In what file can you find the installed version of your Debian?(red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            /etc/issue
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 2 ]; then
                printf "${LBLUE}
            2. What command can you use to rename your system?
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            sudo hostname <newhostname>
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 3 ]; then
                printf "${LRED}
            3. What file has to be modified to make it permanent?(red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            edit with sudo vi ##
            /etc/hosts
            #change on line 2 what follows 127.0.0.1 to reflect chosen hostname
            /etc/hostname
            #there should just be the hostname there. change that to reflect chosen hostnmae
            #restart systemctl hosname
            sudo systemctl restart hostname
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 4 ]; then
                printf "${LBLUE}
            4. What command gives you the time since your system was last booted?
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            last reboot
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 5 ]; then
                printf "${LBLUE}
            5. Identify the IP address of the DNS that responds to the following url: slash16.org
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            sudo systemctl status ssh
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 6 ]; then
                printf "${LBLUE}
            6. Name the command that reboots the SSH service.
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            sudo systemctl restart ssh
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 7 ]; then
                printf "${LBLUE}
            7. Figure out the PID of the SSHD service.
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ##first list the process id.
            USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
            root         1  0.0  0.1 225740  9396 ?        Ss   12:59   0:04 /sbin/init splash
            ##then find the ones that mention sshd
            ps -aux | grep "sshd"
            ##of thos one should be the grep command itself and the other run by the user root will be  path to a binary for sshd.
            root     12539  0.0  0.0  72296  5704 ?        Ss   21:37   0:00 /usr/sbin/sshd -D
            stieky   12812  0.0  0.0  14424   996 pts/2    S+   21:47   0:00 grep --color=auto sshd
            ## the process id is 12539
            ## to double check
            kill 12539
            ## then check systemctl if its not running
            sudo systemctl status sshd
            #$ or you could just do that to begin withbecause ti list the process id there
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 8 ]; then
                printf "${LRED}
            8. What file contains the RSA keys of systems that are authorized to connect via SSH?(red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            /root/.ssh/authorized_keys
            ##but I dont have permission for that so instead
            ~/.ssh/authorized_keys
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 9 ]; then
                printf "${LBLUE}
            9. What command lets you know who is connected to the System?
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            w
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 10 ]; then
                printf "${LBLUE}
            10. Name the command that lists the partition tables of drives?
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            sudo fdisk -l
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 11 ]; then
                printf "${LBLUE}
            11. Name the command that displays the available space left and used on the system
            in an humanly understandable way
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            df -h
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 12 ]; then
                printf "${LBLUE}
            12. Figure out the exact size of each folder of /var in a humanly understandable way
            followed by the path of it.
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            df -h /var/*
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 13 ]; then
                printf "${LBLUE}
            13. Name the command that find, in real time, currently running processes
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            top
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 14 ]; then
                printf "${LBLUE}
            14. Run the ‘tail -f /var/log/syslog‘ command in background
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            tail -f /var/log/syslog &
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 15 ]; then
                printf "${LBLUE}
            15. Find the command that kills the background command’s process
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 16 ]; then
                printf "${LRED}
            16. Find the service which makes it possible to run specific tasks following a regular (red)
            schedule
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            cron.service
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 17 ]; then
                printf "${LBLUE}
            17. Find the command that allows you to connect via ssh on the VM.(In parallel with
            the graphic session)
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ssh user@hostname
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 18 ]; then
                printf "${LBLUE}
            18. Find the command that kills ssh service
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            sudo systemctl stop ssh
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 19 ]; then
                printf "${LBLUE}
            19. List all services which are started at boot time and name this kind of services
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            cat /etc/init.d/*
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 20 ]; then
                printf "${LBLUE}
            20. List all existing users on the VM
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            cat /etc/passwd
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 21 ]; then
                printf "${LBLUE}
            21. List all real users on the VM
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            Human users have UIDs starting at 1000##
            cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1
            ##or##
            ls /home
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 22 ]; then
                printf "${LBLUE}
            22. Find the command that add a new local user
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            sudo adduser <newuser>
            ${NC}"

            fi
            if [ $sectionTwoNumber -eq 23 ]; then
                printf "${LRED}
            23. Explain how connect yourself as new user. (With graphic session and ssh session)(red)
            ${NC}"
                printf "${LRED}
            ANSWER:\n\t
            ${NC}"
            fi
            if [ $sectionTwoNumber -eq 24 ]; then
                printf "${LBLUE}
            24. Find the command that list all packages
            ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            apt list
            ${NC}"
            fi
        elif [ "$sectionTwoNumber" = "b" ]; then
            break
        fi
        read -n 1 -s -r -p "$(echo -e $YELLOW"Press any key to continue\n"$NC)" INPUT_VARIABLE
    done
}

function sectionThree() {
    sectionThreeLowerLimit=1
    sectionThreeUpperLimit=3
    printf "${YELLOW}Welcome to section $number \n${NC}"
    while true; do
        read -p "$(echo -e $YELLOW"Please pick a question to run the script($sectionThreeLowerLimit-$sectionThreeUpperLimit)
           $LCYAN 1. Write a script which displays only the login, UID and Path of each entry of the
            2. Write a script which delete an ACTIVE user on the VM.
            3. Three’s a Charm. Write a script of you choice.
    "$NC):" sectionThreeNumber
        if [ ! "$sectionThreeNumber" = "b" ] && [ $sectionThreeNumber -ge $sectionThreeLowerLimit ] && [ $sectionThreeNumber -le $sectionThreeUpperLimit ]; then
            if [ $sectionThreeNumber -eq 1 ]; then
                printf "${LBLUE}
            1. Write a script which displays only the login, UID and Path of each entry of the
            /etc/passwd file.
        ${NC}"
                printf "${LBLUE}
            ANSWER:\n\t
            ${NC}"
                bash 01.sh

            fi
            if [ $sectionThreeNumber -eq 2 ]; then
                printf "${LBLUE}
            2. Write a script which delete an ACTIVE user on the VM.
        ${NC}"
                bash 02.sh
            fi
            if [ $sectionThreeNumber -eq 3 ]; then
                printf "${LBLUE}
            3. Three’s a Charm. Write a script of you choice.
        ${NC}"
                printf "${LBLUE}
            ANSWER:
            This Script is question 3
            ${NC}"
                bash question3.sh -init
                sleep 2
            fi
        elif [ "$sectionThreeNumber" = "b" ]; then
            break
        fi
        read -n 1 -s -r -p "$(echo -e $YELLOW"Press any key to continue\n"$NC)" INPUT_VARIABLE
    done

}

function init() {
    lowerLimit=1
    upperLimit=3
    clear
    printf "${LCYAN}\n\tWELCOME TO INIT!!!\n\n${NC}"
    read -n 1 -s -r -p "$(echo -e $YELLOW"\tPress any key to continue\n"$NC)" INPUT_VARIABLE
    while true; do
        read -p "$(echo -e $YELLOW"\tPick a section to evaluate or 'exit' to quit this script:
        1.) Network
        2.) System
        3.) Scripting
        "$NC)" number
        if [ "$number" = "exit" ]; then
            break
        fi
        if [ $number -ge $lowerLimit ] && [ $number -le $upperLimit ]; then
            if [ $number -eq 1 ]; then
                sectionOne
            fi
            if [ $number -eq 2 ]; then
                sectionTwo
            fi
            if [ $number -eq 3 ]; then
                sectionThree
            fi
        fi
        sleep 1
    done
}

checkCommands "$@"

if [ -n "$1" ] && [ $isValidCommand ]; then
    if [ "$actualCommand" = "${commands[0]}" ]; then
        createUser "$@"
    fi
    if [ "$actualCommand" = "${commands[1]}" ]; then
        updatePassword "$@"
    fi
    if [ "$actualCommand" = "${commands[2]}" ]; then
        checkUptime "$@"
    fi
    if [ "$actualCommand" = "${commands[3]}" ]; then
        loginAngryEmployee "$@"
    fi
    if [ "$actualCommand" = "${commands[4]}" ]; then
        generateSSHKeyOnUser "$@"
    fi
    if [ "$actualCommand" = "${commands[5]}" ]; then
        init "$@"
    fi
else
    printf "Invalid command!! Valid commands:
       ${LCYAN}-createUser
       -init
       -updatePassword
       -checkUpTime
       -checkUpTime${NC}
    "
fi
