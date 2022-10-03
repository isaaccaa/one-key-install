#!/bin/bash

cecho() {
	echo -e "\033[44;37;5m $1 \033[0m"
}

uinstall(){
	cecho "Installing $1"
	echo "Installing $1" >> install.log
	sudo apt-get install -y --no-install-recommends $1 1>>install.log 2>&1
	cecho "Install Done"
}

uclone(){
	cecho "clone $1 to $2"
	echo "clone $1 to $2" >> install.log
	git clone --depth=1 $1 $2 1>>install.log 2>&1
	cecho "clone $1 done!"
}
touch install.log
# Update source for nodejs
cecho "Update source for nodejs"
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - 1>>install.log 2>&1
# Update System
cecho "Update System"
sudo apt-get update 1>>install.log 2>&1
sudo apt-get upgrade -y 1>>install.log 2>&1

# Clone my dotfiles
cecho "Clone my dotfiles"
# cd to home
cd ~
# clone dotfiles
#git clone https://gitee.com/isaaccaa/config.git .config 1>>install.log 2>&1
uclone https://gitee.com/isaaccaa/config.git .config


# Install and Configure ZSH

#sudo apt-get install zsh 
uinstall zsh

# p10k
#git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
uclone https://gitee.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
# zsh-autosuggestions
#git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
uclone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# zsh-syntax-highlighting
uclone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# make soft link for zshrc
cecho "make soft link for zshrc"
ln -s ~/.config/zsh/zshrc ~/.zshrc

# change default shell to zsh
cecho "change default shell to zsh"
chsh -s $(which zsh)

# Install Softwares
#sudo apt-get install -y neovim neofetch ranger htop axel tmux
uinstall neovim
uinstall neofetch
uinstall ranger
uinstall htop
uinstall axel
uinstall tmux

# make soft link for tmux.conf
cecho "make soft link for tmux.conf"
ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.config/tmux/tmux.conf.local ~/.tmux.conf.local

# Install nodejs in ubuntu
uinstall nodejs
#sudo apt install -y nodejs
# Configure npm global
cecho "Configure npm global"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
# install yarn
cecho "install yarn"
npm install -g yarn 1>>install.log 2>&1

# Install neovim npm plug
cecho "Install neovim npm plug"
yarn global add neovim 1>>install.log 2>&1

# Installl neovim python plug
cecho "Installl neovim python plug"
pip3 install --user --upgrade pynvim 1>>install.log 2>&1
