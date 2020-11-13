set -x XDG_CONFIG_HOME $HOME/.config

set PATH $HOME/.local $PATH

set -x LDFLAGS -L/usr/local/opt/zlib/lib
set -x CPPFLAGS -I/usr/local/opt/zlib/include
set -x PKG_CONFIG_PATH /usr/local/opt/openblas/lib/pkgconfig

set -x HOMEBREW_GITHUB_API_TOKEN 719c1f1fcfe30d2034b5ec6e8d1713c6cd271fb3


###########
## anyenv
###########
if test -d $HOME/.anyenv
  #anyenv
  set -x PATH $HOME/.anyenv/bin $PATH
  anyenv init - fish | source
end

## direnv
eval (direnv hook fish)

#エイリアス
alias rmt="rmtrash"
alias rm="rm -i"
alias relogin="exec fish"
alias reload="source ~/.config/fish/config.fish"
alias t="tmuximum"

clear

#Theme
#set -g fish_theme fishface
#set -x MALMO_XSD_PATH $HOME/Malmo-0.21.0-Mac-64bit/Schemas

#プロンプトの設定
#pyenv virtualenvの情報を表示
functions -c fish_prompt _old_fish_prompt
function fish_prompt
	if set -q VIRTUAL_ENV
	echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
	end
	_old_fish_prompt
end

#git情報の表示
function fish_prompt --description 'Write out the prompt'
    if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
    set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

    case root

    if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
            set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
    end

    printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    case '*'

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end

# Ctrl+Rで履歴を検索できるように
function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function fish_user_key_bindings
  bind /cr 'peco_select_history_order' # Ctrl + R
end