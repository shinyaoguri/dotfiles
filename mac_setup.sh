#!/bin/bash

###########
#Xcodeの確認
###########
echo -e "\nXcodeの存在確認"
if type "xcode-select" >/dev/null 2>&1; then
  echo -e "-> ✅ Xcode already exist"
else
  echo -e ">>> Xcode was not exists\n>>> Please install Xcode from AppStore."
  return 2> /dev/null
  exit
fi

###########
# Homebrew
###########
echo -e "\nHomebrewの存在確認"
if type "brew" >/dev/null 2>&1; then
  echo -e "-> ✅ brew already exist"
else
  echo -e ">>> Homebrew was not exist\n>>> Please install Homebrew\n>>> [https://brew.sh/index_ja]"
  return 2> /dev/null
  exit
fi

###########
# SSH
###########
echo -e "\nSSHの設定確認"
if [ -d ~/.ssh ]; then
	echo -e "-> ✅ .ssh directry was already exist"
	if [ -e ~/.ssh/id_rsa.pub ]; then
		echo -e "-> ✅ .ssh/id_rsa.pub was already exist"
	else
		echo -e "-> ❌ .ssh/id_ras.pub was not exist\n-> Please setup SSH\n"
		return 2> /dev/null
		exit
	fi
else
	echo -e "-> ❌ .ssh was not exist\n-> Please setup SSH\n"
	echo -e "-> Please add your id_rsa.pub file to GitHub\n"
	return 2> /dev/null
	exit
fi

###########
# Git
###########
echo -e "\nGitの設定"
if type "git" >/dev/null 2>&1; then
	echo -e "-> ✅ git was already exist"
else
	echo -e "-> ❌ git was not exist"
	brew install git
fi

###########
# dotfiles
###########
echo -e "\ndotfilesのダウンロード"
if [ -d ~/dotfiles ]; then
	echo -e "-> ✅ dotfiles was already exist"
	cd ~/dotfiles
else
	echo -e "-> ❌ dotfiles was not exist"
	git clone git@github.com:shinyaoguri/dotfiles.git ~/dotfiles
	cd ~/dotfiles
fi

###########
# brew install
###########
echo -e "\nbrew install"
brew_install_list=("rmtrash" "nkf" "tree" "wget" "direnv" "peco" "tmux" "vim")
for item in ${brew_install_list[@]}; do
	if type $item >/dev/null 2>&1; then
		echo -e "-> ✅ $item was already exist"
	else
		echo "-> ❌ $item was not exist"
		brew install $item
	fi		
done

# anyenv
if type "anyenv" >/dev/null 2>&1; then
	echo -e "-> ✅ anyenv was already exist"
else
	echo -e "-> ❌ anyenv was not exist"
	brew install anyenv
	anyenv install --init
fi

# imagemagick
if type "convert" >/dev/null 2>&1; then
	echo -e "-> ✅ imagemagick was already exist"
else
	echo -e "-> ❌ imagemagick was not exist"
	brew install imagemagick
fi

# Neovim
if type "nvim" >/dev/null 2>&1; then
	echo -e "-> ✅ neovim was already exist"
else
	echo -e "-> ❌ neovim was not exist"
	brew install neovim
fi

# Java
if type "java" >/dev/null 2>&1; then
	echo -e "-> ✅ java was already exist"
else
	echo -e "-> ❌ java was not exist"
	brew install openjdk
fi
# TODO Javaが存在する場合の条件を追加する
if [ -e /Library/Java/JavaVirtualMachines/openjdk.jdk ]; then
	echo -e "-> ✅ JAVA_HOME was already exist"
else
	echo -e "-> ❌ JAVA_HOME symboliclink was not exist"
	sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
fi

# zlib
if [ $(brew list --formula | grep zlib) ]; then
	echo -e "-> ✅ zlib has been exist"
else
	echo -e "-> ❌ zlib was not exist"
	brew install zlib
fi

# Dart
if type "dart" >/dev/null 2>&1; then
	echo -e "-> ✅ dart was already exist"
else
	echo -e "-> ❌ dart was not exist"
	brew tap dart-lang/dart
	brew install dart
fi

###########
# CocoaPods
###########
if type "pod" >/dev/null 2>&1; then
	echo -e "-> ✅ CocoaPods was already exist"
else
	echo -e "-> ❌ CocoaPods was not exist"
	sudo gem install cocoapods
	pod setup
fi


###########
# fish
###########
echo -e "\nfish-shellの設定"
if type "fish" >/dev/null 2>&1; then
	echo -e "-> ✅ fish-shell was already exist"
else
	brew install fish
fi

if [ -d ~/.config/fish ]; then
	echo -e "-> ✅ directry ~/.config/fish was already exist"
else
    echo -e "-> ❌ directry ~/.config/fish was not exist"
	mkdir -p ~/.config/fish
fi
ln -nfs ~/dotfiles/config.fish ~/.config/fish/config.fish
ln -nfs ~/dotfiles/.zshrc ~/.zshrc

# fisherman
if [ -e ~/.config/fish/functions/fisher.fish ]; then
  echo -e "-> ✅ fisherman was already exist"
else
  echo -e "-> ❌ fisherman was not exist"
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  fish -c 'fisher -v'
fi

# plugins
if [ "$(fish -c 'fisher list | grep fish-bd')" ]; then
	echo -e "-> ✅ fisher plugin [0rax/fish-bd] was already exist"
else
	echo -e "-> ❌ fisher plugin [0rax/fish-bd] was not exist"
	fish -c 'fisher install 0rax/fish-bd'
fi

###########
# neo-vim
###########
echo -e "\nneovimの設定"
if [ -d ~/.config/nvim ]; then
	echo -e "-> ✅ ~/.config/nvim was already exist"
else
	mkdir -p ~/.config/nvim
fi
ln -nfs ~/dotfiles/init.vim ~/.config/nvim/init.vim

###########
# anyenv
###########
echo -e "\nanyenvの設定"
envs=("rbenv" "nodenv" "pyenv" "jenv")
for env in ${envs[@]}
do
	if type $env >/dev/null 2>&1; then
		echo -e "-> ✅ $env was already exist"
	else
		anyenv install $env
	fi
done


###########
# brew cask
###########
echo -e "\nbrew cask install"
# LaTeX
read -p "Do you want to install MacTeX? (y/N): " yn
case "$yn" in
  [yY]*)
		if [ $(brew list --cask | grep mactex-no-gui) ]; then
			echo -e "\n-> ✅ MacTeX(no gui) was already exist"
		else
			echo -e "\n-> ❌ MacTeX(no gui) was not exist"
			brew cask install mactex-no-gui
		fi
		;;
  *)
		echo -e "\n-> MacTeX will not be installed"
  ;;
esac
# Virtualbox
read -p "Do you want to install VirtualBox? (y/N): " yn
case "$yn" in
  [yY]*)
		if type "VirtualBox" >/dev/null 2>&1; then
			echo -e "\n-> ✅ VirtualBox was already exist"
		else
			echo -e "\n-> ❌ VirtualBox was not exist"
			brew cask install virtualbox
		fi
		;;
  *)
		echo -e "\n-> VirtualBox will not be installed"
  ;;
esac


echo -e "\nDone\n"
