#! /bin/bash

display_help_text () {
	echo "
    salt-strap is a quick bootstrap script used to set up a salt minion.

	To install the salt minion, run the following
		
		./salt-strap.sh -i

	It is expected that you provide the ip address of your salt master as follows.

		./salt-strap.sh -m 10.0.70.19

	If you are using salt's key identity feature, you can also provide it as follows
	
		./salt-strap.sh -m 10.0.70.19 -f ab:cd:ef:gh:ij:kl:mn:op:12:34:45:56:67:78:89

	Ideally, you should run all steps at once
	
		./salt-strap.sh -i -m 10.0.70.19 -f ab:cd:ef:gh:ij:kl:mn:op:12:34:45:56:67:78:89

	
	Disclaimer: This script was written and tested for CentOS 7 servers
	    "
	exit
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

test_params () {
	echo "finger = ${FINGER}"
	echo "master = ${MASTER}"
	echo "install = ${INSTALL}"
}

main () {
	test_params
}

main
