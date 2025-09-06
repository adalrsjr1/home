# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

###################
# Custom Settings #
###################

# don't put duplicate lines or lines starting with space in the history
# see bash(1) for more options
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:ps:cd:history"

# append history instead of overwriting
shopt -s histappend
# synchronize history across sessions
export PROMPT_COMMAND="history -a; history -c; history -r"

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# search through history with up/down arrows
# e.g.: vim <up/down arrow> will loop through vim commands only
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward' 2>/dev/null

# shell-color-prompt to avoid edit PS1 manually
#   less /usr/share/doc/bash-color-prompt/README.md
#   less /etc/profile.d/bash-color.sh
#
if [ -t 0 ]; then
    bash_color_prompt_force=1
    source /etc/profile.d/bash-color-prompt.sh
fi
# util for color manifulation
colorpre='\[\e[1;' # '1;' for bold
colorsuf='m\]'
colorreset="${colorpre}0${colorsuf}"
PROMPT_COLOR="1;32"
PROMPT_DIRECTORY=""
PROMPT_USERHOST=""
PROMPT_SEPARATOR=""
function prompt_command {
    ref=$(/usr/bin/git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ -n "$ref" ]; then
        # check if working directory is dirty
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            git_branch="($ref*) " # dirty
        else
            git_branch-"(ref) "
        fi
    else
        git_branch=""
    fi
    # update terminal title
    echo -n -e "\e]0;${PWD}\a"
}
PROMPT_COMMAND="$PROMPT_COMMAND; prompt_command"
# add current git branch using same PROMPT_COLOR
PROMPT_END='${colorpre@P}${PROMPT_COLOR}${colorsuf@P}${git_branch@P}${colorreset@P}'
if [[ $TERM_PROGRAM != "vscode" ]]; then
    # add success/failed icon like vscode terminal
    PROMPT_END='${colorpre@P}$(if [ $? -eq 0 ]; then echo "34"; else echo "31"; fi)${colorsuf@P}● ${colorreset@P}'$PROMPT_END
fi

if [[ -d "/usr/local/go" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
    go env -w GOPATH="$HOME/.go"
    go env -w GOBIN="$(go env GOPATH)/bin"
    export PATH="$PATH:$(go env GOBIN)"
fi

