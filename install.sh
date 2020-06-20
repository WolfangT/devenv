#!/bin/ah
# Custom bash script for setting up Wolfang's Debian developer eviroment

NANO=nano-4.9.3

# general update
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl gcc git mc unzip python3 python3-dev python3-pip python3-venv python3-wheel nano/sid
python3 -m pip install --upgrade flake8 black isort

# get git repo
cd
git clone https://github.com/WolfangT/wolfang-env.git
cd wolfang-env
git pull
cp -R .config .ssh .bashrc .gitconfig .isort.cfg ~
# make the .nanorc
echo "" > ~/.nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh -s
cat .nanorc >> ~/.nanorc
cd
rm -rf wolfang-env

# install latest nano
#curl "https://www.nano-editor.org/dist/v4/$NANO.tar.gz" | sudo tar -zxC "/opt"
#cd "/opt/$NANO" && sudo ./configure --enable-all --enable-utf8 && sudo make && sudo make install
#cd ~
