# ==============================================================================
# Zsh Completion Engine Tuning
# ==============================================================================

setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Estilos del sistema de autocompletado (Z-Styles)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:targets' list-colors '=(#b)(*)/=34'