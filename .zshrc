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
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# GCLOUD

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# GO
export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin

# DOOM EMACS
export PATH=$PATH:$HOME/.emacs.d/bin

# Babashka task runner auto-complete
_bb_tasks() {
    local matches=(`bb tasks |tail -n +3 |cut -f1 -d ' '`)
    compadd -a matches
    _files # autocomplete filenames as well
}
compdef _bb_tasks bb

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ghrp/.utils/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ghrp/.utils/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ghrp/.utils/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ghrp/.utils/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

alias ftr="rlwrap java -jar ~/dev/ftr/target/ftr.jar"
alias zen="rlwrap java -jar ~/dev/ftr/target/zen.jar"

export PATH=$PATH:$HOME/.local/share/nvim/plugged/vim-iced/bin

export GRAALVM_HOME="/Users/ghrp/graalvm-ce-java17-22.3.0/Contents/Home"
export PATH="/Users/ghrp/graalvm-ce-java17-22.3.0/Contents/Home/bin:$PATH"
export PATH="/Users/ghrp/.local/bin:$PATH"
