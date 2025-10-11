# CRUSH.md

This file documents build, lint, test commands, and general code style guidelines for working with this Chezmoi configuration repository.

## Commands

### Build/Setup
*   **chezmoi apply**: Apply all configurations.
    ```bash
    chezmoi apply
    ```

### Testing
*   **Run all checks (if any exist)**: No explicit test suite found in the root. If tests are added later, add them here.
    ```bash
    # Example: If using a testing framework like Go's built-in for a configuration utility:
    # go test ./...
    ```
*   **Run a single test (example)**: No specific test pattern found to run a single test.
    ```bash
    # Example:
    # goto test file_name_test.sh && ./file_name_test.sh
    ```

### Utility Commands
*   **List files (for exploration)**:
    ```bash
    ls -F
    ```
*   **View file contents (with line numbers)**:
    ```bash
    view <file_path>
    ```

## Code Style Guide

This configuration primarily manages dotfiles via Chezmoi templates (`.tmpl`) and shell scripts (`.sh.tmpl`).

### Shell Scripts (`*.sh.tmpl`)
1.  **Idempotency**: All `run_onchange_*` scripts must be idempotent (can be run multiple times without undesired side effects).
2.  **Error Handling**: Use `set -euo pipefail` at the top of all shell scripts for strict execution.
3.  **Cross-Platform**: Be mindful of differences between macOS (Darwin), Arch Linux, and Ubuntu. Detect operating systems explicitly where necessary (e.g., using `uname`).
4.  **Chezmoi Variables**: Prioritize using Chezmoi template variables (e.g., `{{ .chezmoi.os }}`) over direct system checks when possible.

### Templates (`*.toml.tmpl`, `*.zshrc.tmpl`, etc.)
1.  **Imports/Includes**: Use standard Chezmoi template functions for file inclusions (`{{ template "installers.sh.tmpl" . }}`).
2.  **Formatting**: Maintain consistent indentation (2 spaces for YAML/TOML, 4 spaces for Go/other code if present).
3.  **Naming**: Configuration files generally follow their upstream naming conventions (e.g., `.tmux.conf`, `.zshrc`). Scripts use an ordering prefix (`run_onchange_001_...`).

### Error Handling
*   In **shell scripts**: Use clear exit codes and log messages for failures. Rely on `set -e` for immediate termination on error.

## Agent Guidelines

Agents operating in this repository are expected to:
*   Prioritize using Chezmoi template syntax (`{{ ... }}`) when modifying configuration files that use it.
*   Use `ls` and `grep` to understand existing files before making modifications, especially for new scripts.
*   Be cautious modifying encrypted private files (they are age-encrypted). Do not attempt to edit them directly unless explicitly asked to manipulate the age keys/config.

## Cursor & Copilot Rules

*   `.cursor/rules/` and `.cursorrules` were not found.
*   `.github/copilot-instructions.md` was not found.

If any command above is not sufficient or if a better test command exists, please provide it for inclusion in this file.
