# ==============================================================================
# Shell History Configuration
# ==============================================================================

export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

export HISTSIZE=100000
export SAVEHIST=100000

# Opciones nativas del manejo de historial
setopt HIST_IGNORE_ALL_DUPS     # Borrar duplicados previos al ingresar nuevos
setopt HIST_REDUCE_BLANKS       # Eliminar espacios innecesarios
setopt HIST_SAVE_NO_DUPS        # No guardar duplicados en el archivo físico
setopt HIST_VERIFY              # Permitir edición de comandos del historial con expansión
setopt SHARE_HISTORY            # Compartir historial entre terminales concurrentes