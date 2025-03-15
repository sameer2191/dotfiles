# ~/.zshrc file for zsh interactive shells
# Created on: $(date)

#-------------------------------
# HISTORY CONFIGURATION
#-------------------------------
HISTSIZE=10000               # Maximum events for internal history
SAVEHIST=10000               # Maximum events in history file
HISTFILE=~/.zsh_history      # Where to save history to disk
setopt appendhistory         # Append history to the history file (no overwriting)
setopt sharehistory          # Share history across terminals
setopt incappendhistory      # Immediately append to the history file, not just when a term is killed
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups      # Ignore duplicated commands history list
setopt hist_ignore_space     # Ignore commands that start with space
setopt hist_verify           # Show command with history expansion to user before running it

#-------------------------------
# DIRECTORY NAVIGATION
#-------------------------------
setopt auto_cd               # If a command is not found, and is a directory, cd to it
setopt auto_pushd            # Make cd push the old directory onto the directory stack
setopt pushd_ignore_dups     # Don't push multiple copies of the same directory onto the stack
setopt pushd_minus           # Exchanges the meanings of '+' and '-' when used with a number to specify a directory

#-------------------------------
# COMMON ALIASES
#-------------------------------
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# List directory contents
alias ls='ls -G'                      # Colorize output
alias ll='ls -lh'                     # List files in long format
alias la='ls -lha'                    # List all files (including hidden)
alias l='ls -CF'                      # List in columns

# Grep
alias grep='grep --color=auto'        # Colorize grep output
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Safety features
alias cp='cp -i'                      # Confirm before overwriting
alias mv='mv -i'                      # Confirm before overwriting
alias rm='rm -i'                      # Confirm before removing

# System info
alias df='df -h'                      # Human-readable sizes
alias du='du -h'                      # Human-readable sizes

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'

# Miscellaneous
alias h='history'
alias j='jobs -l'
alias c='clear'
alias reload='source ~/.zshrc'        # Reload .zshrc

#-------------------------------
# PROMPT CUSTOMIZATION
#-------------------------------
autoload -Uz colors && colors

# Simple prompt with username, hostname, and current directory
# Format: username@hostname:~/current/directory$
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$ "

# Set window title to user@host:dir
precmd() {
  print -Pn "\e]0;%n@%m: %~\a"
}

#-------------------------------
# COMPLETION SYSTEM
#-------------------------------
autoload -Uz compinit && compinit    # Initialize completion system
zstyle ':completion:*' menu select    # Use menu selection for completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion

#-------------------------------
# PATH CONFIGURATION
#-------------------------------
# Add local bin directories to PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

#-------------------------------
# MISC OPTIONS
#-------------------------------
setopt no_beep                # No beep on error
setopt interactive_comments   # Allow comments in interactive shells

# Editor configuration
export EDITOR='vim'           # Set default editor
export VISUAL='vim'           # Set default visual editor

# Add any custom configurations below

