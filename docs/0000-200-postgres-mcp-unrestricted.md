# 0000-200-postgres-mcp-unrestricted

## Date
Sat Dec 06 2025

## Changes Made
Added top-level `mcpServers.postgres` configuration to enable postgres-mcp server with unrestricted access mode.

## Files Modified
- `home/dot_config/opencode/opencode.jsonc.tmpl`

## Benefits
Allows opencode agents unrestricted access to local Postgres database via MCP server for advanced interactions.

## Testing
- `chezmoi diff` to review changes
- `chyolo` to apply
- Restart opencode and test MCP connectivity