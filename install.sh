# Make executable with "chmod +x install.sh"
CurrentDir=$PWD

#-- INSTALL --#

# apt
cat apt-install.txt | xargs sudo apt-get -y install

# ly 


# dmenu-wl 
mkdir build
meson build
ninja -C build
sudo ninja -C build install



#-- SWAY --#

# Replace sway config
sudo cp -r sway/ ~/.config/sway/

# Run sway on login (replace .profile)
sudo cp init/.profile ~/.profile



#-- LY --#

# Replace ly config 
sudo cp ly/config.ini /etc/ly/config.ini

# Enabele ly service
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service
