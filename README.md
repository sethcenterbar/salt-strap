# salt-strap
A salt-minion bootstrapper with colored output, a useful help menu, and option & argument parsing.

I created this because I don't have any other public examples of bash scripts I've worked on other than my zsh configs. 

_My goal here is to show a working comprehension of the following:_
* Bash control flow (understanding the _test_ command (if))
* Bash functions
* Option/Argument Passing with getopts
* help menu for options and examples
* sed
* systemd
* ANSI escape sequences (coloring the hard way)
* git 

This is basically a safer, flexible wrapper around the following quick script I wrote at work last week to quickly set up a few salt-minions. 
```bash
#!/bin/bash
sudo yum install -y systemd-python &&
sudo yum update -y &&
sudo yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm -y &&
sudo yum install salt-minion -y &&
echo "192.168.0.254     salt" | sudo tee --append /etc/hosts > /dev/null &&
sudo systemctl enable salt-minion --now
```

## Disclaimer
This script is made for the yum package manager, and has been tested only on Centos 7

# Examples
![carbon.now.sh](https://i.imgur.com/5D9FD1U.png)
