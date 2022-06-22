# Instant prompt init
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# Theme setup
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

#COMPLETION
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GCLOUD

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ghrp/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ghrp/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ghrp/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ghrp/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# GO
export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin

# DOOM EMACS
export PATH=$PATH:$HOME/.emacs.d/bin
