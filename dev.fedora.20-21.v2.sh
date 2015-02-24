#! /bin/bash

USER=""
ONYXPASS=""
DRIVEPATH=""

# Pull down all the .* folders to get system settings back in place
scp -r https://onyx.boisestate.edu:/home/students/$USER/.* /home/\u/ < $ONYXPASS &

# Make sure to find the correct drive letter and change /dev/sda1 to the correct drive before running
sudo sh -ec "echo \"\u ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

sudo mkdir /mnt/$d
sudo sh -c "echo \"$DRIVEPATH     /mnt/Storage     ntfs     defaults     0 0\" >> /etc/fstab"
sudo mount -a

source ~/.bashrc

# Install Google Chrome
echo -e "[google-chrome] \
	  \nname=google-chrome - \$basearch \
	 \nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch \
	  \nenabled=1 \
	  \ngpgcheck=1 \
	  \ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo

sudo yum install -y kate #callback to update databases for later installs/updates

#addiional repositories that may provide for program dependencies
sudo yum localinstall -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

#development
sudo yum groupinstall "Development Tools"

#popular and development packages
sudo yum install -y sl oogle-chrome-stable gstreamer* gstreamer-ffmpeg gstreamer* faad2 faac libdca wget compat-libstdc++-33 compat-libstdc++-296  xine-lib-extras-freeworld kdeartwork eclipse-fedora* gvim vim readline readline-devel doxygen rhythmbox libreoffice transmission subversion mono-devel git


#OPTIONAL Fix terminal prompt, only uncomment "export" line

#<username> [<working directory>] >$
#export PS1="\u [/\W ]>$ " 
