# Chezmoi Dotfiles Agent Guide

## Commands
- `chyolo` = `chezmoi apply --force` (apply all changes)
- `chezmoi diff` = show changes before applying
- `chezmoi status` = check current state
- `chezmoi edit <file>` = edit specific file
- `chezmoi add <file>` = add new file to management
- `tmux source ~/.tmux.conf` = reload tmux configuration after changes

## Code Style
- YAML: 2-space indentation, use arrays for packages
- Shell: Zsh syntax, export vars at top, aliases in separate file
- Templates: Use `.tmpl` extension, 1Password integration for secrets
- File naming: `dot_*` for dotfiles, `private_dot_*` for encrypted files

## Package Management
- Cross-platform: `packages-common.yaml` (npm, uv, vscode, cursor)
- Platform-specific: `packages-{darwin,ubuntu,arch-*}.yaml`
- Extensions: Use publisher.extension-name format

## Documentation
ALL changes require docs/0000-200-*.md with Date, Changes Made, Files Modified, Benefits, Testing sections.

## Key Aliases
- `ch` = chezmoi, `chyolo` = chezmoi apply --force
- `kc` = kubectl, `tf` = terraform
- `c` = code, `cu` = cursor
- `cc` = ccr code, `ccui` = ccr ui

## File Structure
- `home/.chezmoidata/`: Package configs (YAML)
- `home/dot_*`: Dotfiles (templates use .tmpl)
- `home/private_dot_*`: Encrypted private configs
- `docs/0000-200-*.md`: Change documentation

## Security
- Use age encryption for SSH keys
- 1Password integration for secrets
- Template variables for sensitive data
- Never commit plaintext secrets

## Testing
- Always run `chezmoi diff` before applying
- Use `chezmoi apply --dry-run` to test
- Verify template variables with `chezmoi data`