#! /bin/bash

ONYXUSER=jweaver


### for package installs, 
if [ $USER != 'root' ] ; then 
	echo "you must be root."
	exit
fi

### Pull down all the .* folders to get system settings back in place
echo "enter ONYX password, or Ctrl-C to skip..."
scp -r $ONYXUSER@onyx.boisestate.edu:/home/students/$ONYXUSER/.[a-zA-Z0-9]*  /home/$ONYXUSER/

### Set it so that no password is required to perform sudo opperations (commented out by default)
# sudo sh -c "echo \"$USER ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

source ~/.bashrc

### Install Google Chrome
su -c 'echo -e "[google-chrome]
	     \nname=google-chrome - \$basearch
	     \nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
	     \nenabled=1
	     \ngpgcheck=1
	     \ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo'
	     
### Callback to update Yum databases for later installs/updates
sudo dnf update

### Aaddional repositories that may provide for program dependencies
sudo dnf install -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

### Development Tools
sudo dnf groupinstall -y "Development Tools" "C Development Tools and Libraries" "Fedora Eclipse" "Administration Tools"

### Popular and development packages
sudo dnf install -y kate google-chrome-stable gstreamer* gstreamer-ffmpeg faad2 faac libdca wget compat-libstdc++-33 compat-libstdc++-296  xine-lib-extras-freeworld kdeartwork-common.noarch kdeartwork-wallpapers.noarch kde-artwork-active.noarch gvim vim readline readline-devel doxygen rhythmbox libreoffice transmission subversion mono-devel git maven

### OPTIONAL Fix terminal prompt, only uncomment "export" line
### <username> [<working directory>] >$
export PS1="\u [/\W ]>$ "

### To fix the issue where the login screen freezes, use the following if needed.
### I cannot guarantee that it will solve the problem, but I have not had any issues
### since I did this.

# sudo dnf -y install lightdm system-switch-displaymanager
# sudo system-switch-displaymanager lightdm
# sudo reboot
