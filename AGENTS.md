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
├── home/                          # Main dotfiles directory
│   ├── .chezmoidata/             # Chezmoi data files
│   │   └── packages.yaml         # Package management configuration
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
└── README.md
```

## Key Configuration Files

### 1. Package Management (`packages.yaml`)

The system supports multiple package managers across different platforms:

**Arch Linux (Primary)**:
- `pacman`: Core system packages (rust, git, neovim, tmux, etc.)
- `paru`: AUR packages (visual-studio-code-bin, bun)
- `brew`: Additional tools (gh, fzf, jq, tree, etc.)

**macOS**:
- `brew`: Core packages and casks
- `npm`: Node.js packages

**Ubuntu**:
- `apt`: Basic system packages

**Development Tools**:
- VS Code extensions
- Cursor extensions
- NPM packages for AI tools

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

To add a new package, edit `home/.chezmoidata/packages.yaml`:

```yaml
arch:
  pacman:
    - new-package
  brew:
    - new-tool
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

Add to `packages.yaml`:

```yaml
vscode:
  extensions:
    - publisher.extension-name
cursor:
  extensions:
    - publisher.extension-name
```

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
3. **Keep platform-specific configs** in conditional blocks
4. **Use descriptive names** for aliases and functions
5. **Document new configurations** in this file
6. **Encrypt sensitive files** with age
7. **Use 1Password** for secrets management

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