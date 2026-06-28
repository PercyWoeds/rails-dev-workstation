# .zshenv - Cargado para todas las instancias de la shell (login/no-login/scripts)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Configuración de rutas críticas de runtime (mise, cargo, go, npm)
export MISE_DATA_DIR="$XDG_DATA_HOME/mise"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"

typeset -U path
path=(
  $HOME/.local/bin
  $MISE_DATA_DIR/shims
  $CARGO_HOME/bin
  $GOPATH/bin
  $path
)
export PATH

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"