#     __            __
#    / /  ___ ____ / /  ________
#   / _ \/ _ `(_-</ _ \/ __/ __/
#  /_.__/\_,_/___/_//_/_/  \__/

###########
#+General+#
###########
[[ $- != *i* ]] && return # If not running interactively, don't do anything.

####################
#+Custom functions+#
####################

# Custom format of path used in my shell prompt.
function __p() {
    local first_two_dirs
    local last_two_dirs
    local path_wo_ftd
    local path_slash_count

    first_two_dirs=$(pwd | cut -d '/' -f 1-3)
    last_two_dirs=$(pwd | rev | cut -d '/' -f 1-2 | rev)
    path_wo_ftd=$(pwd | cut -d '/' -f 4-)
    path_slash_count=$(pwd | grep -o '/' | wc -l)

    if [ "$(pwd)" == "$HOME" ]; then
        echo '~'
    elif [ "$first_two_dirs" == "$HOME" ]; then
        [ "$path_slash_count" -le 6 ] && \
            echo "${path_wo_ftd/#/\~/}" || \
            echo "${last_two_dirs/#/\~/.../}"
    else
        [ "$path_slash_count" -le 4 ] && \
            pwd || \
            echo "${last_two_dirs/#/"$first_two_dirs"/.../}"
    fi
}

# Current git branch if in git repo (for shell prompt).
function __gb() {
	git branch 2>/dev/null \
        | grep '\*' \
        | cut -d ' ' -f 2- \
        | sed -e 's/^/\[\ /' -e 's/$/\]/'
}

# Create and move to directory.
function cm() {
    mkdir "$1"
    cd "$1" || return
}

# Custom function to use vi/vim/nvim easier.
function v() {
    if [ "$(command -v nvim)" ]; then
        nvim "$@"
    elif [ "$(command -v vim)" ]; then
        vim "$@"
    else
        vi "$@"
    fi
}

# Check website SSL/TLS certificate quickly.
function cert() {
    (echo "Q" \
        | openssl s_client -servername "$1" -connect "$1":443 \
        | openssl x509 -noout -text) 2>/dev/null \
        | grep -e DNS -e Not -e Subject: -e Issuer: \
        | sed 's/^\s*//'
}

###########
#+Aliases+#
###########

# Aliases for ls.
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
alias lh='ls -lh'

# Color support aliases.
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias zgrep='zgrep --color=auto'
fi

#########################
#+Environment Variables+#
#########################
export EDITOR=vim       # Preferred text editor.

HISTCONTROL=ignoreboth  # Don't put duplicates in the history.
HISTSIZE=               # Lines of commands stored in memory.
HISTFILESIZE=           # Lines of commands stored in history (startup).
HISTTIMEFORMAT="%F %T " # Timestamp format for history entries.
PS2=''                  # No annoying arrows with multiline commands.
A='\[\033[38;5;146m\]'  # Pointer color.
C='\[\033[38;5;222m\]'  # Remote (SSH) machine prompt color.
P='\[\033[38;5;141m\]'  # Path color.
B='\[\033[38;5;120m\]'  # Git branch color.
D='\[\033[38;5;007m\]'  # Default color.

# Custom prompt.
PS1="${A}󰁆 ${C}[ \u@\h] ${P}[󰴠 \$(__p)] ${B}\$(__gb)${D}\n"

#################
#+Shell Options+#
#################
shopt -s histappend     # Append new entries to the history file.
shopt -s checkwinsize   # Update LINES and COLUMNS on window size change.
shopt -s globstar       # Use "**" to "match all" in a pathname expansion.
shopt -s cmdhist        # Multi-line command as single entries in history.
shopt -s dotglob        # Include dotfiles when globbing.
shopt -s extglob        # Enable extended globbing features.
shopt -s lithist        # Multi-line commands with newlines in history.

#################
#+Local Machine+#
#################
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
    source "${HOME}"/.bash_local
    source "${HOME}"/.bash_helpers
fi

