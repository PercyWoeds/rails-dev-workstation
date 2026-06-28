#!/usr/bin/env bash

# ==============================================================================
# rails-dev-workstation - Idempotent Arch Linux Bootstrap & Provisioning Script
# ==============================================================================

set -euo pipefail
IFS=$'\n\t'

# --- Configuración de Colores (Paleta Desértica / Earth-tones) ---
export COLOR_RESET="\033[0m"
export COLOR_ERROR="\033[38;5;167m"   # Terracota / Rojo Suave
export COLOR_SUCCESS="\033[38;5;143m" # Verde Oliva / Salvia
export COLOR_WARN="\033[38;5;214m"    # Ocre / Arena Intensa
export COLOR_INFO="\033[38;5;109m"    # Azul Arcilla / Desértico
export COLOR_TITLE="\033[38;5;179m"   # Oro Viejo / Arena Base

log_info()    { printf "${COLOR_INFO}[INFO]${COLOR_RESET} %s\n" "$1"; }
log_success() { printf "${COLOR_SUCCESS}[SUCCESS]${COLOR_RESET} %s\n" "$1"; }
log_warn()    { printf "${COLOR_WARN}[WARN]${COLOR_RESET} %s\n" "$1"; }
log_error()   { printf "${COLOR_ERROR}[ERROR]${COLOR_RESET} %s\n" "$1"; >&2; }

# --- Verificación de Entorno Operativo ---
if [ ! -f /etc/arch-release ]; then
    log_error "Este script está optimizado exclusivamente para distribuciones basadas en Arch Linux."
    exit 1
fi

# --- Variables Globales de Entorno ---
export DOTFILES_DIR
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export BACKUP_DIR="$HOME/.dotfiles_backups/backup_$(date +%Y%m%d_%H%M%S)"

# --- Asegurar estructura base de directorios XDG ---
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.cache"

# --- Detector e instalador del AUR Helper (Idempotente) ---
setup_aur_helper() {
    log_info "Verificando gestor de paquetes AUR..."
    if command -v paru &> /dev/null; then
        export AUR_HELPER="paru"
        log_success "AUR Helper detectado: paru"
    elif command -v yay &> /dev/null; then
        export AUR_HELPER="yay"
        log_success "AUR Helper detectado: yay"
    else
        log_info "No se detectó un AUR Helper. Instalando yay de forma automática..."
        sudo pacman -S --needed --noconfirm base-devel git
        local tmp_dir
        tmp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay-bin.git "$tmp_dir"
        (cd "$tmp_dir" && makepkg -si --noconfirm)
        rm -rf "$tmp_dir"
        export AUR_HELPER="yay"
        log_success "yay se ha instalado de forma correcta."
    fi
}

# --- Sincronización e Instalación Base de Paquetes ---
install_system_packages() {
    log_info "Sincronizando repositorios e instalando dependencias nativas..."
    
    # Paquetes nativos de repositorio oficial de Arch
    local native_packages=(
        git curl wget zsh tmux fzf fd ripgrep bat eza zoxide tree jq 
        delta btop htop just direnv github-cli docker docker-compose 
        postgresql-libs sqlite unzip zip p7zip imagemagick ffmpeg stow
    )

    # Paquetes específicos del AUR
    local aur_packages=(
        ghostty dust dua-cli yazi-git mise-bin
    )

    log_info "Instalando paquetes desde repositorios oficiales..."
    sudo pacman -S --needed --noconfirm "${native_packages[@]}"

    log_info "Instalando paquetes desde el AUR a través de $AUR_HELPER..."
    $AUR_HELPER -S --needed --noconfirm "${aur_packages[@]}"
}

# --- Gestión de Backups y Enlaces Simbólicos mediante GNU Stow ---
deploy_dotfiles_stow() {
    log_info "Preparando despliegue de configuraciones mediante GNU Stow..."
    local modules=(git ghostty tmux zsh)

    for module in "${modules[@]}"; do
        if [ -d "$DOTFILES_DIR/$module" ]; then
            # Buscar colisiones directas antes de ejecutar stow para realizar copias de respaldo
            find "$DOTFILES_DIR/$module" -type f | while read -r file; do
                # Calcular la ruta destino relativa al HOME
                local relative_path="${file#$DOTFILES_DIR/$module/}"
                local target_file="$HOME/$relative_path"

                if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
                    log_warn "Conflicto detectado en archivo existente: $target_file. Moviendo a backup."
                    mkdir -p "$(dirname "$BACKUP_DIR/$relative_path")"
                    mv "$target_file" "$BACKUP_DIR/$relative_path"
                fi
            done

            log_info "Enlazando módulo: $module"
            stow -R -d "$DOTFILES_DIR" -t "$HOME" "$module"
        fi
    done
    log_success "Estructuras de configuración sincronizadas mediante Stow."
}

# --- Configuración del Entorno de Runtimes mediante Mise (Idempotente) ---
provision_runtimes() {
    log_info "Configurando runtimes de desarrollo mediante mise..."
    eval "$("$HOME/.local/share/mise/bin/mise" activate bash 2>/dev/null || mise activate bash)"

    # Instalación idempotente de Ruby
    if ! mise current ruby &> /dev/null; then
        log_info "Instalando última versión estable de Ruby..."
        mise use --global ruby@latest
        gem install bundler --no-document
    else
        log_success "Ruby ya configurado: $(mise current ruby)"
    fi

    # Instalación idempotente de Node.js
    if ! mise current node &> /dev/null; then
        log_info "Instalando última versión LTS de Node.js..."
        mise use --global node@lts
    else
        log_success "Node.js ya configurado: $(mise current node)"
    fi
}

# --- Configuración del Entorno Docker ---
configure_docker_service() {
    log_info "Verificando políticas y servicios del motor Docker..."
    if ! systemctl is-active --quiet docker; then
        log_info "Habilitando e iniciando el demonio Docker..."
        sudo systemctl enable --now docker.service
    fi

    if ! groups "$USER" | grep &>/dev/null '\bdocker\b'; then
        log_info "Agregando el usuario actual al grupo docker..."
        sudo usermod -aG docker "$USER"
        log_warn "Se requiere cerrar sesión e iniciar de nuevo para aplicar cambios del grupo Docker."
    fi
}

# --- Orquestación Principal ---
main() {
    clear
    printf "${COLOR_TITLE}"
    printf "======================================================================\n"
    printf "      RAILS DEVELOPMENT WORKSTATION - ARCH LINUX INITIALIZATION       \n"
    printf "======================================================================\n"
    printf "${COLOR_RESET}\n"

    setup_aur_helper
    install_system_packages
    deploy_dotfiles_stow
    provision_runtimes
    configure_docker_service

    printf "\n${COLOR_SUCCESS}======================================================================\n"
    printf "     ¡ESTACIÓN DE TRABAJO CONFIGURADA DE MANERA EXITOSA!              \n"
    printf "======================================================================${COLOR_RESET}\n"
    printf "Detalles de la instalación:\n"
    printf " - Shell por defecto: Recuerda ejecutar 'chsh -s $(which zsh)' si no lo has hecho.\n"
    printf " - Respaldos en: %s\n" "$BACKUP_DIR"
    printf "Por favor, reinicia la terminal o tu sesión para aplicar todos los cambios.\n\n"
}

chmod +x "$HOME/.config/zsh/scripts/"* 2>/dev/null || true

main "$@"