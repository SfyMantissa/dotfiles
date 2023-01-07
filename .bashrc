#     __            __          
#    / /  ___ ____ / /  ________
#   / _ \/ _ `(_-</ _ \/ __/ __/
#  /_.__/\_,_/___/_//_/_/  \__/ 
#                               

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Custom format of path used in my shell prompt.
path () {
    first_two_dirs=$(pwd | cut -d '/' -f 1-3)
    last_two_dirs=$(pwd | rev | cut -d '/' -f 1-2 | rev)
    path_wo_ftd=$(pwd | cut -d '/' -f 4-)
    path_slash_count=$(pwd | grep -o '/' | wc -l)

    if [ "$(pwd)" == "$HOME" ]; then
        echo '~'
    elif [ "$first_two_dirs" == "$HOME" ]; then
        if [ "$path_slash_count" -le 6 ]; then
            echo "${path_wo_ftd/#/\~/}"
        else
            echo "${last_two_dirs/#/\~/.../}"
        fi
    else
        if [ "$path_slash_count" -le 4 ]; then
            pwd
        else
            echo "${last_two_dirs/#/"$first_two_dirs"/.../}"
        fi
    fi
}

# Create and move to directory.
cm () {
  mkdir "$1"
  cd "$1" || return
}

# Custom function to use vi/vim/lvim easier.
v () {
  lvim="$HOME/.local/bin/lvim"

  if [ "$(command -v "$lvim")" ]; then
    "$lvim" "$@"
  elif [ "$(command -v vim)" ]; then
    vim "$@"
  else
    vi "$@"
  fi
}

# Check website SSL/TLS certificate quickly.
cert () {
  nslookup "$1"
  (openssl s_client -showcerts -servername "$1" -connect "$1":443 \
    <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}

# Color support aliases.
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias zgrep='zgrep --color=auto'
fi

# Custom aliases for ls.
alias ll='ls -l'
alias la='ls -A'
alias lh='ls -lh'

# General environment variables.
HISTCONTROL=ignoreboth                                 # Don't put duplicate lines or lines starting with space in the history.
HISTSIZE=                                              # Lines of commands stored in memory.
HISTFILESIZE=                                          # Lines of commands allowed at startup and stored in the history file.
HISTTIMEFORMAT="%F %T "                                # Set timestamp format for history entries.
EDITOR=vim                                             # Set the preferred text editor.
TERM=xterm-256color                                    # Support 256 colors in XTerm.
D='\[\033[38;5;7m\]'                                   # Default color.
C='\[\033[38;5;193m\]'                                 # Remote (SSH) machine prompt custom color.
PS1="\u$C@\h: \$(path) ❱❱$D "                          # Custom prompt.
PS2=''                                                 # No annoying arrows with multiline commands.

# Shell options.
shopt -s histappend                                    # Append to the history file instead of overwriting it.
shopt -s checkwinsize                                  # Dynamically update LINES and COLUMNS depending on window size.
shopt -s globstar                                      # Use "**" to "match all" in a pathname expansion.
shopt -s cmdhist                                       # Save multi-line command as a single entry in history.
shopt -s dotglob                                       # Include dotfiles when globbing files and directories.
shopt -s extglob                                       # Enable extended globbing features.
shopt -s lithist                                       # Store multi-line commands with newlines in history.

# Commands to be executed only on local machine.
if [[ -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then

    source /home/sfy/work/.workrc

    # Automatically start X Server on login.
    if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        startx
    fi

    # Local machine only environment variables.
    TERM=xterm-kitty
    export EDITOR="$HOME/.local/bin/lvim"
    export BROWSER=firefox                             # Set the preferred web browser.
    C='\[\033[38;5;141m\]'                             # Local machine prompt custom color.
    PS1="\u@\h: $C\$(path) ❱❱$D "                      # Custom prompt.
    PATH=$PATH:/home/sfy/.cargo/bin/:/home/sfy/.local/bin/:/home/sfy/repos/dotfiles/.scripts/

    # Other aliases.
    alias z="zathura"
    alias rofi-calc="rofi -modi calc -show calc -no-unicode -calc-command \"xdotool type --clearmodifiers '{expression} = {result}'\""
    alias screenkey="screenkey --bg-color '#111F39' --font 'Iosevka'"
    alias ix="curl -F 'f:1=<-' ix.io"
    alias hh="npx hardhat"
    alias nmpass="sudo grep -r '^psk=' /etc/NetworkManager/system-connections/ \
      | cut -d '/' -f 5 \
      | sed -e 's/.nmconnection//' -e 's/psk=//'"
    alias icat="kitty +kitten icat"
    alias clipboard_in="kitty +kitten clipboard"
    alias clipboard_out="kitty +kitten clipboard --get-clipboard"

fi

