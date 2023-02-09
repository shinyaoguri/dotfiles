# M1チップのMacの場合のHomebrewの設定
set -x PATH /opt/homebrew/bin $PATH
set -x PATH /usr/local/bin $PATH

##########
# エイリアス
##########
# rmtでゴミ箱に移動
alias rmt="trash -F"

# rmは確認させる
alias rm="rm -i"
alias g="git"

# fish
alias relogin="exec fish"
alias reload="source ~/.config/fish/config.fish"

#
alias t="tmuximum"

# 打ち間違え対策
alias '\;s'="ls"
clear

##########
# anyenv
##########
if test -d $HOME/.anyenv
  set -x PATH $HOME/.anyenv/bin $PATH
  anyenv init - fish | source
end

##########
# deno
if test -d $HOME/.deno
  set -x PATH ~/.deno/bin $PATH
end
##########

##########
# Android Studio
##########
set -x PATH $HOME/Library/Android/sdk/platform-tools $PATH

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
