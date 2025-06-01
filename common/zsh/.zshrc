# Shell Integrations
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# --- Go ---
export GOPATH="$HOME/.local/share/go"

# --- pipx ---
export PATH="$PATH:/Users/direndbharwani/.local/bin"

# --- pyenv --- 
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# export PIPENV_PYTHON="$PYENV_ROOT/shims/python" 
eval "$(pyenv init - zsh)"

# --- virtualenvwrapper --- 
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.pyenv/versions/$(pyenv version-name)/bin/virtualenv
if [[ -f $(pyenv root)/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh ]]; then
  source $(pyenv root)/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh
fi


if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/kanagawa_zen.toml)"
fi

# --- zinit ---
## set directory to store zinit & plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

## download zinit
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

## load zinit
source "${ZINIT_HOME}/zinit.zsh"

## zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

## snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

## completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion.*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

## faster zsh startup
zinit cdreplay -q

# --- keybinds ---
# TODO: Move to another dotfile
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ---  History --- 
# TODO: Move to another dotfile
HISTSIZE=999
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# --- Aliases ---
# TODO: Move to another dotfile
alias ls="eza -al --icons=auto"
alias lg="lazygit"



