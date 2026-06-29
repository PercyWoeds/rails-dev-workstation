
```markdown
# rails-dev-workstation

Estación de trabajo e infraestructura de dotfiles profesional, modular e idempotente optimizada para **Arch Linux**, enfocada en el desarrollo ágil de **Ruby on Rails** utilizando **Neovim (LazyVim)**, **Ghostty**, **Tmux**, e Inteligencia Artificial local con **Ollama**.

## 1. Arquitectura del Repositorio

El repositorio gestiona sus enlaces simbólicos de manera limpia y modular hacia `$HOME` utilizando **GNU Stow**:

```text
rails-dev-workstation/
├── install.sh         # Script de aprovisionamiento central e idempotente
├── git/               # Configuración global de Git, diffing con Delta y LazyGit
├── ghostty/           # Terminal acelerada por GPU con el tema Tokyo Night
├── tmux/              # Multiplexor con navegación estilo Vim y persistencia
├── zsh/               # Configuración modular de la Shell, aliases (+100) y funciones
└── nvim/              # IDE LazyVim extendido para Ruby, Rails, Linters y Ollama

```

## 2. Instalación Avanzada

Para realizar la instalación completa de manera automatizada y desatendida, clone este repositorio en su entorno local y ejecute el instalador base:

```bash
git clone [https://github.com/PercyWoeds/rails-dev-workstation.git](https://github.com/PercyWoeds/rails-dev-workstation.git)
cd rails-dev-workstation
chmod +x install.sh
./install.sh

```

El instalador implementa un enfoque de **idempotencia estricta**: detectará automáticamente dependencias faltantes, instalará herramientas CLI nativas y entornos mediante `mise`, y generará respaldos atómicos fechados en `~/.dotfiles_backups/` si existen conflictos de archivos, evitando la sobreescritura destructiva de sus configuraciones previas.

## 3. Gestión y Personalización

### Agregar complementos de Neovim

Los plugins se encuentran desacoplados en archivos Lua dentro de `nvim/.config/nvim/lua/plugins/`. Para añadir un plugin, cree un archivo estructurado bajo la especificación clásica de `lazy.nvim`:

```lua
return {
  "autor/repositorio",
  opts = {},
}

```

### Configuración del Modelo de Inteligencia Artificial (Ollama)

Por defecto, la suite de desarrollo utiliza **CodeCompanion** acoplado al backend local de Ollama. Puede modificar o conmutar de manera transparente el LLM de desarrollo (como `qwen2.5-coder:7b` o `deepseek-coder`) editando la clave `schema.model.default` dentro de `nvim/.config/nvim/lua/plugins/ai_companion.lua`.

### Flujo de Actualización Permanente

Para sincronizar las bases de datos de paquetes de Arch Linux, el AUR helper y actualizar los esquemas de dependencias de LazyVim en paralelo, ejecute de forma directa el script integrado del ecosistema:

```bash
update

```

## 4. FAQ (Preguntas Frecuentes)

**¿Es seguro ejecutar el script múltiples veces?** Sí, todas las directivas de instalación verificaran la existencia previa del binario o del enlace simbólico. Si el entorno ya está aprovisionado, el script saltará el paso sin duplicar líneas ni alterar configuraciones activas.

**¿Cómo restauro mis configuraciones de respaldo?** En caso de que el sistema genere un conflicto en el despliegue de Stow, sus archivos originales se almacenarán intactos bajo un directorio estructurado con marca de tiempo dentro de `~/.dotfiles_backups/`. Puede moverlos manualmente de vuelta a sus respectivas ubicaciones en caso de ser necesario.

```
