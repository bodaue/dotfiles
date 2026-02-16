export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


# fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Настройки fzf - высота окна 20 строк
export FZF_DEFAULT_OPTS='--height 20'

# aliases
alias bat='batcat'

alias ls='eza --icons --color=auto'
alias ll='eza -lah --icons --git'

source <(kubectl completion zsh)
alias k=kubectl
compdef k=kubectl

alias e='micro'
export EDITOR=micro

alias copy='wl-copy'

# Переменные для конфига
export ZC=~/.zshrc
export zc=~/.zshrc

. "$HOME/.local/bin/env"

# Исправить цвета папок
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Generated for envman. Do not edit.

# Обновить текущую ветку от main
gup() {
  git fetch origin && git merge origin/main
}

# Переключение ветки через fzf

ssh-connect() {
  local host=$(grep "^Host" ~/.ssh/config | grep -v "*" | awk '{print $2}' | fzf)
  [[ -n $host ]] && ssh "$host"
}


rgf() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'batcat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(micro +{2} {1})'
}

# Автоматическая активация venv
autoload -U add-zsh-hook

_auto_venv() {
  # Деактивируй, если вышел из папки с venv
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local parent_dir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parent_dir"/* ]]; then
      deactivate 2>/dev/null
    fi
  fi

  # Активируй venv, если найдено
  local venv_dirs=("venv" ".venv" "env" ".env")
  for venv_dir in "${venv_dirs[@]}"; do
    if [[ -f "$PWD/$venv_dir/bin/activate" ]]; then
      source "$PWD/$venv_dir/bin/activate"
      break
    fi
  done
}

add-zsh-hook chpwd _auto_venv
_auto_venv  # Выполни сразу для текущей директории

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
