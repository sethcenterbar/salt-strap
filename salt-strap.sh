#! /bin/bash

# Setting up some output colors
ESC='\033';
GREEN="${ESC}[0;32m";
RED="${ESC}[0;31m";
YELLOW="${ESC}[0;33m";
RESET="${ESC}[0m";

display_help_text () {
    echo -e "
salt-strap is a quick bootstrap script used to set up a salt minion.

    ${YELLOW}To install the salt minion, run the following:${RESET}

        ./salt-strap.sh -i

    ${YELLOW}It is expected that you provide the ip address of your salt master as follows:${RESET}

        ./salt-strap.sh -m 10.0.70.19

    ${YELLOW}If you are using salt's key identity feature, you can also provide it as follows:${RESET}

        ./salt-strap.sh -m 10.0.70.19 -f ab:cd:ef:gh:ij:kl:mn:op:12:34:45:56:67:78:89

    ${GREEN}Ideally, you should run all steps at once:${RESET}

        ./salt-strap.sh -i -m 10.0.70.19 -f ab:cd:ef:gh:ij:kl:mn:op:12:34:45:56:67:78:89

${YELLOW}Hint: To find the value of -f, run \`sudo salt-key -F | grep master.pub | cut -d ' ' -f 3\` on the salt master${RESET}

${RED}Disclaimer: This script was written and tested for CentOS 7 servers${RESET}
    "
    exit
}

default_to_helptext () {
# If no arguments are passed to the script, it should default to showing the help text
    if [ $OPTIND -eq 1 ]; then
        display_help_text
    fi
}

install-salt-minion () {
    echo -e "${GREEN}Updating packages..${RESET}"
    yum update -y &&
    echo -e "${GREEN}Installing dependencies..${RESET}"
    yum install -y systemd-python &&
    echo -e "${GREEN}Installing saltstack repository..${RESET}"
    yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm -y &&
    echo -e "${GREEN}Installing salt minion..${RESET}"
    yum install salt-minion -y
}

# Recieve command line arguments using getopts
while getopts "hf:m:i" opt; do
    case ${opt} in
        h ) display_help_text 
            ;;
        f ) FINGER=$OPTARG
            ;;
        m ) MASTER=$OPTARG
            ;;
        i ) INSTALL=true
            ;;
        \? ) echo "Usage: cmd [-h] [-i] -m -f "
            ;;
    esac
done

main () {
    default_to_helptext
    if [ "$INSTALL" = true ]; then
        install-salt-minion
    fi
}

main
