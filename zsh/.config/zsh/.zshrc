# ==============================================================================
# Zsh Main Configuration - Modular Shell Engine
# ==============================================================================

# Definición del directorio base de configuraciones de Zsh
export ZSH_CONFIG="$HOME/.config/zsh"

# Cargar configuración de prompt de forma prioritaria (Powerlevel10k)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh"
fi

# Inicializar sistema de módulos en orden de dependencia crítico
for module in exports history options plugins completion aliases functions prompt; do
    if [[ -f "$ZSH_CONFIG/${module}.zsh" ]]; then
        source "$ZSH_CONFIG/${module}.zsh"
    fi
done

# Cargar e inicializar herramientas CLI si están instaladas (Idempotente)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# Habilitar sintaxis e historial recursivo de comandos
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"