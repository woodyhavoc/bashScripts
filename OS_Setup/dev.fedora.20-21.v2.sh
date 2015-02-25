#! /bin/bash

USER=""
ONYXPASS=""
DRIVEPATH=""

### Full path to the directory that you want to make i.e. /mnt/Storage
dir=""

### Accept ssh key the first time
ssh $USER@onyx.boisestate.edu < "yes" &

### Pull down all the .* folders to get system settings back in place
scp -r $USER@onyx.boisestate.edu:/home/students/$USER/.* ~/ < $ONYXPASS &

### Set it so that no password is required to perform sudo opperations (commented out by default)
# sudo sh -c "echo \"$USER ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

# Make sure to find the correct drive letter and change DRIVEPATH="/dev/sdXX" to the correct drive and DIR="/home/map/to/path"
sudo mkdir $dir
sudo sh -c "echo \"$DRIVEPATH     $dir     ntfs     defaults     0 0\" >> /etc/fstab"
sudo mount -a

### Insert path to these directories
# rm -rf Documents Downloads Music Videos Pictures
# ln -s $dir/to/Documents ~/
# ln -s $dir/to/Downloads ~/
# ln -s $dir/to/Music ~/
# ln -s $dir/to/Videos ~/
# ln -s $dir/to/Pictures ~/


source ~/.bashrc

### Install Google Chrome
echo -e "[google-chrome]
	     \nname=google-chrome - \$basearch
	     \nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
	     \nenabled=1
	     \ngpgcheck=1
	     \ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo
	     
### Callback to update Yum databases for later installs/updates
sudo yum install -y kate 

### Aaddional repositories that may provide for program dependencies
sudo yum localinstall -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

### Development Tools
sudo yum groupinstall "Development Tools"

### Popular and development packages
sudo yum install -y sl google-chrome-stable gstreamer* gstreamer-ffmpeg gstreamer* faad2 faac libdca wget compat-libstdc++-33 compat-libstdc++-296  xine-lib-extras-freeworld kdeartwork java-1.8.0-openjdk eclipse-fedora* gvim vim readline readline-devel doxygen rhythmbox libreoffice transmission subversion mono-devel git

### OPTIONAL Fix terminal prompt, only uncomment "export" line
### <username> [<working directory>] >$
#export PS1="\u [/\W ]>$ "

### To fix the issue where the login screen freezes, use the following if needed.
### I cannot guarantee that it will solve the problem, but I have not had any issues
### since I did this.

# sudo yum -y install lightdm system-switch-displaymanager
# sudo system-switch-displaymanager lightdm
# sudo reboot
