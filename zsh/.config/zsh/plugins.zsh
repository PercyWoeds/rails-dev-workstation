# ==============================================================================
# Unattended Plugin Manager & Dynamic Loading
# ==============================================================================

export ZSH_PLUGIN_DIR="$XDG_DATA_HOME/zsh/plugins"
mkdir -p "$ZSH_PLUGIN_DIR"

# Función interna de aprovisionamiento idempotente de plugins externos
load_plugin() {
    local repo_url="$1"
    local plugin_name="${repo_url##*/}"
    local target_path="$ZSH_PLUGIN_DIR/$plugin_name"

    if [[ ! -d "$target_path" ]]; then
        git clone --depth 1 "$repo_url" "$target_path" &>/dev/null
    fi

    if [[ -f "$target_path/$plugin_name.plugin.zsh" ]]; then
        source "$target_path/$plugin_name.plugin.zsh"
    elif [[ -f "$target_path/$plugin_name.zsh" ]]; then
        source "$target_path/$plugin_name.zsh"
    fi
}

# Carga de la suite de plugins solicitada
load_plugin "https://github.com/zsh-users/zsh-autosuggestions"
load_plugin "https://github.com/zsh-users/zsh-syntax-highlighting"
load_plugin "https://github.com/zsh-users/zsh-completions"
load_plugin "https://github.com/zsh-users/zsh-history-substring-search"

# Vinculación de teclas para history-substring-search estilo Vim
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down