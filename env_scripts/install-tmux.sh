#!/bin/sh

TARGET_DIR=~/opt/src/

if [ -n "$1" ];then
    TARGET_DIR=$1
fi

cd $TARGET_DIR

# install deps
sudo yum install gcc kernel-devel make ncurses-devel -y

function install_libevent_2_x {
    # DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
    wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
    tar -xvzf libevent-2.0.21-stable.tar.gz
    cd libevent-2.0.21-stable
    ./configure --prefix=/usr/local
    make
    sudo make install
}

function install_tmux_2_6 {
# DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL
#wget https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
tar -xvzf tmux-2.6.tar.gz
cd tmux-2.6
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install
}

function install_tmux_tpm {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
}

install_libevent_2_x 
install_tmux_2_6
install_tmux_tpm