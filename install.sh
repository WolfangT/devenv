#!/bin/ah
# Custom bash script for setting up Wolfang's Debian developer eviroment

NANO=nano-4.9.3

_install_devenv() {
    # Get the code and install
    cd
    wget -O /tmp/devenv.zip https://github.com/WolfangT/devenv/archive/master.zip
    unzip -o "/tmp/devenv.zip"
    cd devenv-master
    cp -R .config .bashrc .gitconfig .isort.cfg ~
    echo "" > ~/.nanorc
    curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh -s
    cat .nanorc >> ~/.nanorc
    cd
    rm -rf devenv-master
}

_install_nano() {
    # install latest nano
    curl "https://www.nano-editor.org/dist/v4/$NANO.tar.gz" | sudo tar -zxC "/opt"
    cd "/opt/$NANO" && \
        sudo ./configure --enable-all --enable-utf8 && \
        sudo make && sudo make install
    cd ~
}

_update_system_debian() {
    # general update
    sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y \
        curl gcc git mc unzip \
        python3 python3-dev python3-pip python3-venv python3-wheel \
        black isort flake8
        nano
}

if apt-get -v &> /dev/null ; then
    _update_system_debian
else
    echo "For the moment the install script is only for apt systems"
fi
_install_devenv
mc
