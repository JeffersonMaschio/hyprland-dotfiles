typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# fastfetch
if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="dd/mm/yyyy"

plugins=(git 
		 zsh-autosuggestions 
		 zsh-syntax-highlighting 
		 zsh-interactive-cd
		 extract
		 universalarchive
		 
		 )


source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='micro'

export MICRO_TRUECOLOR=1

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

export FZF_DEFAULT_OPTS=" \
  --height=60% \
  --layout=reverse \
  --border=rounded \
  --border-label='╢ Select a process ╟' \
  --border-label-pos=top \
  --prompt='> ' \
  --info=right \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --color=border:#585b70,label:#cba6f7 \
  --color=header:#6c7086 \
  --tabstop=4"


# My Aliases
alias ls="exa -l -h --icons=always --color=always"
alias m="micro"
alias "git clone"="git clone --depth=1"
alias uso="df / -h"
alias pc="inxi -Fz"
alias rain="terminal-rain -t"
alias peso="ncdu"


eval "$(direnv hook zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Instalar pacotes com yay + fzf
yayf() {
    yay -Slq | fzf --multi --preview 'yay -Si {1}'  --preview-window=right:65%:wrap | xargs -ro yay -S
}

# Desinstalar pacotes com yay + fzf
yayr() {
    yay -Qq | fzf --multi --preview 'yay -Qi {1}' --preview-window=right:65%:wrap | xargs -ro yay -Rns
}



# (cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh


# Load Angular CLI autocompletion.
source <(ng completion script)

export PATH=$PATH:/home/jefferson/.spicetify
export PATH=$PATH:~/.spicetify
export PATH=$PATH:/home/jefferson/go/bin
. "$HOME/.local/bin/env"
