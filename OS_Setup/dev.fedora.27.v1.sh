#! /bin/bash

### Set it so that no password is required to perform sudo opperations (commented out by default)
# sudo sh -c "echo \"$USER ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"


### Install Google Chrome
# su -c 'echo -e "[google-chrome]
#	     \nname=google-chrome - \$basearch
#	     \nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
#	     \nenabled=1
#	     \ngpgcheck=1
#	     \ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo'

if [ $USER == "root" ]; then
	echo -e "\nDo not run this script as root.\n"
	exit
fi
	     
### Callback to update Yum databases for later installs/updates
sudo dnf update -y

### Aaddional repositories that may provide for program dependencies
# sudo dnf install -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

### Development Tools
sudo dnf groupinstall -y "Development Tools" "C Development Tools and Libraries" "Administration Tools"

### Popular and development packages
sudo dnf install -y kate \
wget \
compat-libstdc++-33 \
compat-libstdc++-296  \
gvim \
vim \
readline \
readline-devel \
doxygen \
transmission \
subversion \
mono-devel \
git \
maven \
curl \
npm \
;


### Install SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version | grep -q sdkman
if [ $? -ne 0 ]; then
	echo -e "your shit is fucked"
fi

sdk install gradle
sdk install springboot

# https://www.if-not-true-then-false.com/2012/install-postgresql-on-fedora-centos-red-hat-rhel/

### Install PostgreSQL

sudo sed -i '0,/^$/s/^$/exclude=postgresql\*\n/' /etc/yum.repos.d/fedora.repo
sudo sed -i '0,/^$/s/^$/exclude=postgresql\*\n/' /etc/yum.repos.d/fedora-updates.repo

sudo dnf install -y https://download.postgresql.org/pub/repos/yum/10/fedora/fedora-27-x86_64/pgdg-fedora10-10-3.noarch.rpm
sudo dnf install -y postgresql10 postgresql10-server

sudo /usr/pgsql-10/bin/postgresql-10-setup initdb

sudo systemctl start postgresql-10.service
sudo systemctl enable postgresql-10.service

### Do this stuff manually
# sudo sed -i '0,/^# listen_addresses .*/s/^# listen_addresses .*/listen_addresses = \"localhost\"\*\n/' /var/lib/pgsql/10/data/postgresql.conf
# sudo sed -i '0,/^# port .*/s/^# port .*/port = 5432\*\n/' /var/lib/pgsql/10/data/postgresql.conf
# sudo -i
# su postgres
# cd
# createuser --interactive
# Enter name of role to add: jweaver
# Shall the new role be a superuser? (y/n) y
# createdb jweaver

### OPTIONAL Fix terminal prompt, only uncomment "export" line
### <username> [<working directory>] >$
export PS1="\u [/\W ]>$ "

### To fix the issue where the login screen freezes, use the following if needed.
### I cannot guarantee that it will solve the problem, but I have not had any issues
### since I did this.

# sudo dnf -y install lightdm system-switch-displaymanager
# sudo system-switch-displaymanager lightdm
# sudo reboot
