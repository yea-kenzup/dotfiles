---
Date: 2025-11-30
---

# Changes Made
- Added a Linux-specific `BROWSER` environment variable definition to `home/private_dot_zshrc.tmpl`.

## Files Modified
- `home/private_dot_zshrc.tmpl`

## Benefits
- Ensures the `BROWSER` variable is set to `google-chrome-stable` on Linux/WSL environments, providing a consistent default browser for scripts and tools that rely on `$BROWSER`.

## Testing
- Run `chezmoi diff` to verify the added line:
  ```
  export BROWSER="google-chrome-stable"
  ```
- Apply the changes with `chezmoi apply` and open a new terminal session; `echo $BROWSER` should output `google-chrome-stable` on Linux.
