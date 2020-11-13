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
echo -e "\nfish-shellの存在確認"
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
fish -c 'fisher install 0rax/fish-bd'


###########
# brew install
###########
echo -e "\nbrew install"
brew_install_list=("git" "rmtrash" "nkf" "tree" "wget" "anyenv" "direnv" "peco" "tmux")
for item in ${brew_install_list[@]}; do
	if type $item >/dev/null 2>&1; then
		echo -e "-> ✅ $item was already exist"
	else
		echo "-> ❌ $item was not exist"
		brew install $item
	fi		
done

if type "convert" >/dev/null 2>&1; then
	echo -e "-> ✅ imagemagick was already exist"
else
	echo -e "-> ❌ imagemagick was not exist"
	brew install imagemagick
fi

if type "nvim" >/dev/null 2>&1; then
	echo -e "-> ✅ neovim was already exist"
else
	echo -e "-> ❌ neovim was not exist"
	brew install neovim
fi
