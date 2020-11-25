#!/bin/sh
# Custom bash script for setting up Wolfang's Debian developer eviroment

NANO=nano-4.9.3

help="Install Wolfang's development enviroment

  OPTIONS
    -h | --help --> prints this messages and exits
    -f | --full --> performs a full system upgrade
"

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
        black isort flake8 npm nano=5.3
    sudo npm install --global prettier
}

full=false
while [ ! -z "$1" ]; do
    case $1 in
    "-h" | "--help" ) echo "$help" ; exit 0 ;;
    "-f" | "--full" ) full=true ;;
    esac
    shift
done

if $full ; then
    if apt-get -v &> /dev/null ; then
        _update_system_debian
    else
        echo "For the moment the install script is only for apt systems"
    fi
fi
_install_devenv
