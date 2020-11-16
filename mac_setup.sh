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

###########
# fisherman
###########
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
# brew install
###########
echo -e "\nbrew install"
brew_install_list=("git" "rmtrash" "nkf" "tree" "wget" "direnv" "peco" "tmux" "vim")
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
if [ -e /Library/Java/JavaVirtualMachines/openjdk.jdk ]; then
	echo -e "-> ✅ JAVA_HOME was already exist"
	java --version
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
# neo-vim
###########
echo -e "\nneovimの設定"
if [ -d ~/.config/nvim ]; then
	echo -e "-> ✅ directry ~/.config/nvim was already exist"
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
#pyenv virtual-env
if [ -e ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ]; then
	echo "-> ✅ pyenv-virtualenv was already existed"
else
	echo "-> ❌ pyenv-virtualenv was not existed"
	git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
fi


###########
# brew cask
###########
echo -e "\nbrew cask install"
# LaTeX
if [ $(brew list --cask | grep mactex-no-gui) ]; then
	echo -e "-> ✅ MacTeX(no gui) was already exist"
else
	echo -e "-> ❌ MacTeX(no gui) was not exist"
	brew cask install mactex-no-gui
fi

