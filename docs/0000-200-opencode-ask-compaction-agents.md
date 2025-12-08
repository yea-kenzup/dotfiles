# 2025-12-06: Added OpenCode &quot;ask&quot; and &quot;compaction&quot; agents

## Changes Made
- Added `google/gemini-2.5-flash-lite-preview-09-2025` model to `provider.openrouter.models`.
- Added `ask` agent: primary mode like `debug` for details/inquiry (bash + read tools).
- Added `compaction` agent: primary mode for code compaction analysis (no tools, specific Gemini model).

## Files Modified
- `home/dot_config/opencode/opencode.jsonc.tmpl`

## Benefits
- `ask`: Enables read-only troubleshooting/inquiries mirroring `debug`.
- `compaction`: Fast, tool-less analysis for code compaction/minification using lightweight Gemini model.

## Testing
- `chezmoi diff home/dot_config/opencode/opencode.jsonc.tmpl`
- `chezmoi data`
- `chyolo`
- In OpenCode TUI: Switch to `ask` (verify bash/read OK, no writes); `compaction` (no tools available).