# Dotfiles Agent Configuration Guide

This document provides comprehensive guidance for AI agents to help configure and manage the dotfiles for user `jboubix` (yea-kenzup). This is a Chezmoi-managed dotfiles repository with multi-platform support and extensive tooling integration.

## Project Overview

**User**: jboubix (yea-kenzup)  
**Email**: youness.elabbassi@kenzup.com  
**Organization**: Kenzup  
**Dotfiles Manager**: Chezmoi  
**Shell**: Zsh with Oh My Zsh  
**Platforms**: Linux (WSL2), macOS (Darwin), Arch Linux  

## Repository Structure

```
/home/jboubix/.local/share/chezmoi/
├── docs/                           # Documentation directory
│   └── 0000-200-*.md              # Change documentation files
├── home/                          # Main dotfiles directory
│   ├── .chezmoidata/             # Chezmoi data files
│   │   ├── packages-common.yaml  # Cross-platform packages
│   │   ├── packages-darwin.yaml  # macOS packages
│   │   ├── packages-ubuntu.yaml  # Ubuntu packages
│   │   ├── packages-arch-pacman.yaml # Arch pacman packages
│   │   ├── packages-arch-brew.yaml   # Arch Linuxbrew packages
│   │   └── packages-arch-paru.yaml   # Arch AUR packages
│   ├── .chezmoiexternals/        # External dependencies
│   │   └── arch.toml.tmpl        # Arch Linux external packages
│   ├── dot_config/               # Application configurations
│   │   ├── Code/                 # VS Code settings
│   │   └── crush/                # Crush AI tool configuration
│   ├── dot_oh-my-zsh_custom/     # Custom Oh My Zsh components
│   │   └── themes/
│   │       └── jboubix.zsh-theme # Custom Zsh theme
│   ├── dot_ssh/                  # SSH configuration and keys
│   ├── dot_kube/                 # Kubernetes configuration
│   ├── dot_local/                # Local binaries and scripts
│   ├── private_dot_*             # Private configuration files
│   └── jboubix/                  # User-specific directory
├── AGENTS.md                      # This file - Agent instructions
└── README.md
```

## Key Configuration Files

### 1. Package Management

The system uses modular package configuration files separated by platform and installation method:

**Cross-Platform (`packages-common.yaml`)**:
- `npm`: Node.js packages for AI tools
- `uv`: Python packages
- `vscode`: VS Code extensions
- `cursor`: Cursor extensions

**Platform-Specific Files**:
- `packages-darwin.yaml`: macOS packages (brew, casks)
- `packages-ubuntu.yaml`: Ubuntu packages (apt)
- `packages-arch-pacman.yaml`: Arch Linux pacman packages
- `packages-arch-brew.yaml`: Arch Linux Linuxbrew packages
- `packages-arch-paru.yaml`: Arch Linux AUR packages (paru)

**Arch Linux (Primary)**:
- `pacman`: Core system packages (base-devel, git, neovim, tmux, etc.)
- `pacman_sudo`: System packages requiring sudo (coreutils, lsof)
- `brew`: Additional tools (gh, fzf, jq, tree, etc.)
- `paru`: AUR packages (visual-studio-code-bin, bun, android tools)

**macOS**:
- `brew`: Core packages and casks
- Development tools and CLI utilities

**Ubuntu**:
- `apt`: Basic system packages

**Development Tools**:
- VS Code extensions for Python, Rust, Kubernetes
- Cursor extensions with additional Kubernetes tools
- NPM packages for AI tools (Claude, Gemini, OpenAI)

### 2. Shell Configuration

**Zsh Setup**:
- Theme: Custom `jboubix` theme (based on suvash)
- Oh My Zsh with custom plugins
- Custom aliases and functions
- History management with hstr
- Path management for multiple tools

**Key Aliases**:
- `ch` = chezmoi
- `chyolo` = chezmoi apply --force
- `kc` = kubectl
- `tf` = terraform
- `c` = code, `cu` = cursor
- `cc` = ccr code, `ccui` = ccr ui

### 3. SSH Configuration

**Key Management**:
- Multiple encrypted private keys using age encryption
- 1Password integration for key management
- Host configurations for various servers (Kenzup, Freterium, etc.)

**Important Hosts**:
- `kenzup`: Main Kenzup server
- `kenzup-tools`: Tools server
- Various bastion hosts and development servers

### 4. Development Environment

**Languages & Tools**:
- Rust, Python (uv), Node.js (nvm, bun)
- Docker, Kubernetes (kubectl, helm)
- Terraform, Git
- Neovim, Micro editors

**AI Tools Integration**:
- Claude Code Router configuration
- Crush AI tool with OpenRouter and LM Studio
- Multiple AI model providers

### 5. External Dependencies

**Managed by Chezmoi**:
- Oh My Zsh and plugins
- Powerlevel10k theme
- Age encryption tool
- Paru AUR helper
- WSL Windows Hello
- Git repositories (monorepo, Flutter)

## Platform-Specific Configuration

### Linux/WSL2
- WSL-specific PATH configurations
- PulseAudio server setup
- Linuxbrew integration
- Google Cloud SDK

### macOS
- Homebrew paths
- Java environment setup
- Android SDK configuration
- 1Password agent integration

## Security Considerations

1. **Encrypted Keys**: All SSH private keys are encrypted with age
2. **1Password Integration**: Sensitive data stored in 1Password
3. **Template Variables**: Sensitive values use Chezmoi template functions
4. **Git Configuration**: Separate user identity for work

## Common Tasks for AI Agents

### 1. Adding New Packages

To add a new package, edit the appropriate package file in `home/.chezmoidata/`:

**For cross-platform packages** (npm, uv, extensions):
```yaml
# packages-common.yaml
npm:
  - new-npm-package
vscode:
  extensions:
    - publisher.extension-name
```

**For platform-specific packages**:
```yaml
# packages-arch-pacman.yaml
arch:
  pacman:
    - new-package

# packages-darwin.yaml  
darwin:
  brew:
    - new-mac-tool
  casks:
    - new-mac-app
```

### 2. Adding SSH Hosts

Edit `home/dot_ssh/config.tmpl` and add new host configurations:

```
Host new-server
    HostName server.example.com
    User username
    IdentityFile ~/.ssh/key-name
```

### 3. Adding Aliases

Edit `home/private_dot_zsh_aliases.tmpl`:

```bash
alias newalias="command"
```

### 4. Environment Variables

Add to `home/private_dot_zshrc.tmpl` in the appropriate platform section:

```bash
export NEW_VAR="value"
```

### 5. VS Code/Cursor Extensions

Add to the appropriate package file:

**Cross-platform extensions** (packages-common.yaml):
```yaml
vscode:
  extensions:
    - publisher.extension-name
cursor:
  extensions:
    - publisher.extension-name
```

**Platform-specific extensions** (if needed):
Add to platform-specific package files like `packages-darwin.yaml`

## Applying Changes

### Force Apply Changes
When making configuration changes, use the following command to apply them:

```bash
chyolo
```

This alias runs `chezmoi apply --force` which overwrites existing files with the new configuration.

### Documentation Requirements

**ALL CHANGES** must be documented in the `docs/` directory using the following format:

1. **File Naming**: `docs/0000-200-descriptive-name.md`
   - Use sequential numbering (0000-200, 0000-201, etc.)
   - Use descriptive kebab-case filenames

2. **Required Sections**:
   ```markdown
   # Change Title
   
   ## Date
   YYYY-MM-DD
   
   ## Changes Made
   [Detailed description of what was changed]
   
   ## Files Modified
   [List of files added/modified/removed]
   
   ## Benefits
   [Explanation of why this change was made]
   
   ## Testing
   [How the change was tested/verified]
   ```

3. **Documentation Process**:
   - Create documentation file **before** or **during** the change process
   - Update the file with actual changes made
   - Include all files that were modified, created, or removed
   - Explain the reasoning behind the changes

### Change Workflow

1. **Plan**: Create documentation file with planned changes
2. **Implement**: Make the actual configuration changes
3. **Document**: Update the documentation file with actual changes
4. **Apply**: Run `chyolo` to apply changes
5. **Commit**: Commit both the changes and documentation

## Chezmoi Commands

**Essential Commands**:
- `chezmoi apply`: Apply dotfiles
- `chezmoi diff`: Show differences
- `chezmoi edit <file>`: Edit a file
- `chezmoi add <file>`: Add new file
- `chezmoi update`: Update external dependencies

**Force Apply**:
- `chezmoi apply --force`: Overwrite existing files

## Troubleshooting

### Common Issues

1. **Template Variables Not Resolving**:
   - Ensure 1Password CLI is installed and authenticated
   - Check template syntax in `.tmpl` files

2. **SSH Keys Not Working**:
   - Verify age decryption is working
   - Check 1Password integration

3. **Package Installation Fails**:
   - Check platform-specific package managers
   - Verify external dependencies are available

4. **Path Issues**:
   - Ensure all tools are in PATH
   - Check platform-specific path configurations

### Debugging Commands

```bash
# Check Chezmoi status
chezmoi status

# Dry run apply
chezmoi apply --dry-run

# Check template variables
chezmoi data

# Verify external dependencies
chezmoi update
```

## File Naming Conventions

- `dot_*`: Files that start with a dot in the target system
- `private_dot_*`: Private files that should be encrypted/secure
- `*.tmpl`: Template files with Chezmoi variables
- `*_tmpl`: Alternative template naming

## Integration Points

1. **1Password**: API keys, passwords, SSH keys
2. **Git**: Work identity (yea-kenzup)
3. **Kubernetes**: Multiple cluster configurations
4. **AI Tools**: Claude, Crush, various model providers
5. **Development**: VS Code, Cursor, Neovim
6. **Cloud**: AWS, Google Cloud, various servers

## Best Practices

1. **Always use templates** for sensitive data
2. **Test changes** with `chezmoi diff` before applying
3. **Keep platform-specific configs** in appropriate package files
4. **Use descriptive names** for aliases and functions
5. **Document ALL changes** in `docs/` directory using the required format
6. **Encrypt sensitive files** with age
7. **Use 1Password** for secrets management
8. **Apply changes** with `chyolo` after making modifications
9. **Follow the documentation workflow** for every change

## Emergency Recovery

If dotfiles are corrupted:

1. Backup current state: `chezmoi archive > backup.tar.gz`
2. Reset to clean state: `chezmoi unmanaged`
3. Reapply: `chezmoi apply`
4. Restore from backup if needed

## Contact Information

- **Primary User**: jboubix (yea-kenzup)
- **Email**: youness.elabbassi@kenzup.com
- **Organization**: Kenzup
- **Repository**: Private Chezmoi dotfiles

---

*This configuration supports a comprehensive development environment with AI tooling, multi-platform compatibility, and enterprise-grade security practices.*