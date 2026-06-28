# ==============================================================================
# Advanced Automation Shell Functions
# ==============================================================================

# Ejecución de diagnósticos globales sobre dependencias del ecosistema
doctor() {
    echo -e "${COLOR_TITLE}--- Workstation Health Diagnostic ---${COLOR_RESET}"
    local dependencies=(git nvim tmux ghostty ruby rails docker fzf mise)
    for cmd in "${dependencies[@]}"; do
        if command -v "$cmd" &>/dev/null; then
            echo -e " ${COLOR_SUCCESS}✔${COLOR_RESET} $cmd: $(which $cmd) ($($cmd --version | head -n 1))"
        else
            echo -e " ${COLOR_ERROR}✘${COLOR_RESET} $cmd: No instalado en el sistema."
        fi
    done
}

# Creación de directorio y salto inmediato recursivo
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Descompresión atómica de formatos múltiples sin recordar modificadores
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' formato no reconocido" ;;
        esac
    else
        echo "'$1' no es un archivo válido"
    fi
}

# Liberación forzada de puertos TCP/UDP bloqueados por servidores colgados
killport() {
    local port="$1"
    if [[ -z "$port" ]]; then
        echo "Uso: killport <puerto>"
        return 1
    fi
    local pid
    pid=$(lsof -t -i:"$port")
    if [[ -n "$pid" ]]; then
        echo "Terminando procesos bloqueando el puerto $port (PID: $pid)..."
        echo "$pid" | xargs kill -9
        echo -e "${COLOR_SUCCESS}Puerto liberado.${COLOR_RESET}"
    else
        echo "No se encontraron procesos activos en el puerto $port."
    fi
}

# Limpieza total profunda del espacio consumido por Docker de forma segura
docker-clean() {
    echo -e "${COLOR_WARN}Iniciando purga total de recursos en desuso de Docker...${COLOR_RESET}"
    docker system prune -a --volumes -f
}

# Visualización rápida del pronóstico climatológico directo desde la consola
weather() {
    curl -s "https://wttr.in/${1:-Lima}?m"
}

# Consulta rápida de hojas de ayuda y cheatsheets interactivos por comando
cheat() {
    if [[ -z "$1" ]]; then
        echo "Uso: cheat <comando>"
        return 1
    fi
    curl -s "https://cheat.sh/$1"
}