# ==============================================================================
# Environment Variables & Exports
# ==============================================================================

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Reducción del tiempo de espera de secuencias de escape (Mejora modo Vim en Zsh)
export KEYTIMEOUT=1

# Configuración por defecto de FZF (Tokyo Night integrando ripgrep)
export FZF_DEFAULT_COMMAND='fg --type f --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--allures=reverse --height=45% --border --color=bg+:#24283b,bg:#1a1b26,spinner:#bb9af7,hl:#2ac3de,fg:#a9b1d6,header:#9ece6a,info:#0db9d7,pointer:#7aa2f7,marker:#9ece6a,fg+:#c0caf5,prompt:#7aa2f7,hl+:#2ac3de"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


path=($ZSH_CONFIG/scripts $path)
export PATH
