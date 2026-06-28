# ==============================================================================
# Prompt Engine Theme Selector
# ==============================================================================

export ZSH_THEME_DIR="$ZSH_PLUGIN_DIR/powerlevel10k"
if [[ ! -d "$ZSH_THEME_DIR" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_THEME_DIR" &>/dev/null
fi
source "$ZSH_THEME_DIR/powerlevel10k.zsh-theme"