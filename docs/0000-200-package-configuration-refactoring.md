# Package Configuration Refactoring

## Date
2025-10-26

## Changes Made

### 1. Split Package Configuration by Platform and Installation Method

**Previous Structure:**
- Single monolithic `packages.yaml` file containing all packages for all platforms

**New Structure:**
- `packages-common.yaml` - Cross-platform packages (npm, uv, VS Code, Cursor extensions)
- `packages-darwin.yaml` - macOS-specific packages (brew, casks)
- `packages-ubuntu.yaml` - Ubuntu-specific packages (apt)
- `packages-arch-pacman.yaml` - Arch Linux pacman packages
- `packages-arch-brew.yaml` - Arch Linux Linuxbrew packages
- `packages-arch-paru.yaml` - Arch Linux AUR packages

### 2. Updated Chezmoi Configuration

**File Modified:** `home/.chezmoi.toml.tmpl`

**Changes:**
- Added template logic to include and merge package files based on detected platform
- Uses `include` function to read individual package YAML files
- Merges packages conditionally:
  - Darwin: common + darwin packages
  - Ubuntu: common + ubuntu packages  
  - Arch: common + arch-pacman + arch-brew + arch-paru packages

### 3. Package Distribution

**Common Packages (Cross-platform):**
- NPM: Claude Code tools, Gemini CLI, OpenAI Codex, opencode-ai, dotenv
- UV: openai
- VS Code Extensions: Python, TOML, Ruff, Peacock, Mirrord, YAML, GitHub
- Cursor Extensions: Similar to VS Code with Kubernetes tools

**Darwin (macOS):**
- Brew: git, gh, zoxide, fzf, jq, tree, wget, gpg, go, minikube, awscli, gcc, watchman, cloudflared, telnet, direnv, tmuxp, wtp, crush, kubelogin
- Casks: 1password-cli

**Ubuntu:**
- APT: coreutils, zsh, git

**Arch Linux:**
- Pacman Sudo: coreutils, lsof
- Pacman: base-devel, man-db, man-pages, uv, docker-compose, zsh, git, micro, tmux, openssh, neovim, ripgrep, zoxide, procps-ng, curl, file, terraform, kubectl, helm, portaudio, eza
- Brew: gh, fzf, jq, tree, wget, gpg, watchman, crush, kubelogin, wtp, direnv, tmuxp
- Paru: visual-studio-code-bin, bun, android tools

## Benefits

1. **Modularity**: Each platform/installation method has its own configuration file
2. **Maintainability**: Easier to manage and update platform-specific dependencies
3. **Caching**: Chezmoi can better cache installations per platform/method
4. **Scalability**: Simple to add new platforms or installation methods
5. **Clarity**: Clear separation of concerns for different package managers

## Files Modified

- `home/.chezmoidata/packages.yaml` → **REMOVED**
- `home/.chezmoidata/packages-common.yaml` → **CREATED**
- `home/.chezmoidata/packages-darwin.yaml` → **CREATED**
- `home/.chezmoidata/packages-ubuntu.yaml` → **CREATED**
- `home/.chezmoidata/packages-arch-pacman.yaml` → **CREATED**
- `home/.chezmoidata/packages-arch-brew.yaml` → **CREATED**
- `home/.chezmoidata/packages-arch-paru.yaml` → **CREATED**
- `home/.chezmoi.toml.tmpl` → **MODIFIED**

## Migration Notes

- All existing packages have been preserved and redistributed to appropriate files
- No package functionality was lost during the refactoring
- Installation scripts continue to work without modification
- Chezmoi template system handles the merging automatically

## Testing

- Changes committed to repository
- Chezmoi configuration validated for template syntax
- Package distribution verified across all platforms