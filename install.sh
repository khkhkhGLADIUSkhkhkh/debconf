#!/bin/sh
user=web
home=/home/$user
dwm=~/Dwm
dir=~/Workspace
vim=vim72

# INSTALL CORE SOFT
cp ~/Workspace/sources.list /etc/apt
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | apt-key add -
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
gpg --keyserver subkeys.pgp.net --recv A040830F7FAC5991 && gpg --export --armor A040830F7FAC5991 | sudo apt-key add -
wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
aptitude update && aptitude full-upgrade
aptitude install sudo git vim-gtk dpkg-dev dwm suckless-tools xclip mongodb-10gen xserver-xorg-core xorg sakura google-chrome-stable nginx bind9 xfonts-terminus ttf-liberation gthumb gtk2-engines

# INSTALL DWM
mkdir -p $dwm
cd $dwm && apt-get source dwm && cd dwm-* && cp $dir/config.h .
apt-get build-dep dwm
cd $dwm/dwm*
make clean install

# INSTALL NGINX
cp $dir/nginx.conf /etc/nginx
mkdir -p $home/public/use/mysql/public
mkdir -p $home/public/use/pgadmin/public
mkdir -p $home/public/use/mongo/public
mkdir -p $home/public/use/joomla/public
mkdir -p $home/public/use/ocstore/public
mkdir -p $home/public/use/opencart/public
mkdir -p $home/public/use/oscommerce/public
mkdir -p $home/public/use/wordpress/public
mkdir -p $home/public/webcmf/public

# INSTALL BIND
cp $dir/named.conf.local /etc/bind
cp $dir/named.conf.options /etc/bind
cp $dir/db.dev /etc/bind

# INSTALL THEMES
cp -r $dir/elementary /usr/share/icons
cp -r $dir/default /usr/share/icons
cp -r $dir/Xeonyx /usr/share/icons
cp -r $dir/BSMsdm /usr/share/themes
cp $dir/gtkrc /etc/gtk-2.0

# INSTALL CONFIG
cp $dir/dhclient.conf /etc/dhcp
cp $dir/sudoers /etc
cp $dir/xinitrc $home/.xinitrc
cp $dir/sakura.conf $home/.config/sakura
cp $dir/vide /usr/bin && chown root:root /usr/sbin/vide && chmod +x /usr/sbin/vide
cp $dir/vimrc /etc/vim
cp $dir/jellybeans.vim /usr/share/vim/$vim/colors
chown -R $user:$user $home/*
