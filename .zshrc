# FUCK INSTANT PROMPT. ALL MY HOMIES HATE INSTANT PROMPT.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# exports
export EDITOR=nvim
export XDG_CURRENT_DESKTOP=gtk
export PATH=$HOME/.local/bin:$PATH

# start x.org if on tty1 and not started already
if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || sx
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# swap backspace and capslock
# xmodmap -e "clear lock"
# xmodmap -e "keycode 22 = Caps_Lock"
# xmodmap -e "keycode 66 = BackSpace"

# changes key repeat
xset r rate 150 35

# colors
autoload -U colors && colors

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# auto/tab complete
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
zstyle :compinstall filename '/home/creui/.zshrc'

autoload -Uz compinit
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# accept changing directory by only directory names, idk i forgot the second one
setopt autocd extendedglob

# NO TO BEEPING, NO TO NOTIFICATIONS, then idk
unsetopt beep nomatch notify

#idk
bindkey -e

# nicer outputs
alias grep='grep --color=auto'
alias ls='ls -AF --color=auto'

# autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# powerlevel10k theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh
