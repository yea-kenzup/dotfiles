---
name: write-skills
description: Guide to creating agent skills with proper structure and best practices
---

# How to Write Agent Skills

This skill provides comprehensive guidance on creating reusable agent skills for the Neptune project.

## Skill Fundamentals

Skills are reusable instruction sets that agents can load on-demand via the `skill` tool. They encapsulate specific workflows, best practices, or domain knowledge that agents can reference when needed.

**Why use skills?**
- Avoid repeating instructions across agents
- Standardize workflows across the team
- Share knowledge consistently
- Enable agents to specialize without forgetting core procedures

## File Structure

Skills follow a strict directory structure:

```
.opencode/skill/<skill-name>/SKILL.md
```

**Example:**
```
.opencode/skill/git-release/SKILL.md
.opencode/skill/database-migration/SKILL.md
.opencode/skill/api-testing/SKILL.md
```

**Key Rules:**
- Folder name = skill name (lowercase, hyphens, alphanumeric)
- File name must be `SKILL.md` (all caps)
- Skills can be in `.opencode/skill/` (project) or `~/.opencode/skill/` (global)

## YAML Frontmatter Requirements

Every `SKILL.md` MUST start with YAML frontmatter with these fields:

```yaml
---
name: skill-name          # REQUIRED: 1-64 chars, lowercase, hyphens, alphanumeric
description: brief summary # REQUIRED: 1-1024 chars, specific and actionable
---
```

### Required Fields

**name:**
- 1-64 characters
- Lowercase alphanumeric with single hyphen separators
- Cannot start or end with `-`
- Cannot contain consecutive `--`
- Must match the directory name
- Regex: `^[a-z0-9]+(-[a-z0-9]+)*$`

**description:**
- 1-1024 characters
- Must be specific enough for agents to choose correctly
- Should describe when and why to use this skill
- Include key outcomes or deliverables

### What NOT to Include

Do NOT use these optional fields in skill frontmatter:
- `license` - Not needed for internal skills
- `compatibility` - Not needed for agent skills
- `metadata` - Keep frontmatter simple, only required fields

Keep frontmatter minimal and focused on the two required fields only.

## Skill Content Structure

After the frontmatter, structure your skill content with these sections:

### 1. Purpose/Overview
Briefly explain what this skill does and when to use it.

```
## Purpose

This skill guides you through creating database migrations using Alembic for the Neptune multi-tenant architecture.
```

### 2. Prerequisites
List any requirements or context needed before using this skill.

```
## Prerequisites

- Migration tool is installed and configured (Alembic, Flyway, etc.)
- Database connection string is available
- Understanding of multi-tenant patterns (if applicable)
```

### 3. Step-by-Step Instructions
Provide clear, actionable steps for the workflow.

```
## Steps

1. Create a new migration:
   ```bash
   alembic revision -m "describe_changes"
   ```

2. Edit the generated migration file in `backend/alembic/versions/`

3. Add upgrade() and downgrade() functions

4. Test the migration locally
```

### 4. Code Examples
Include relevant code snippets or patterns.

```
## Example Migration

```python
# For Alembic:
def upgrade():
    op.create_table(
        'new_table',
        sa.Column('id', sa.Integer(), primary_key=True),
        sa.Column('name', sa.String(255)),
        sa.Column('tenant_id', sa.Integer(), nullable=False),
    )

# For other tools, follow their API
```

5. Deploy and verify
```

### 5. Best Practices
Highlight important considerations and gotchas.

```
## Best Practices

- Always include tenant_id in tenant-specific tables (if using multi-tenancy)
- Write both upgrade() and downgrade() for reversibility
- Test migrations with realistic data volumes
- Never modify existing migrations after deployment
- Follow your migration tool's conventions
```

### 6. When NOT to Use This Skill
Clarify when this skill is not appropriate.

```
## When NOT to Use

- For one-off data fixes (use scripts/)
- When modifying existing deployed migrations
- For schema changes in production databases directly
```

## Associated Files and Scripts

Skills can include companion files and scripts to enhance their functionality:

### Directory Structure with Associated Files

```
.opencode/skill/<skill-name>/
├── SKILL.md              # Main skill documentation (required)
├── templates/            # Optional: Reusable templates
│   ├── script-template.sh
│   └── config-template.yaml
├── scripts/              # Optional: Helper scripts
│   ├── setup.sh
│   ├── validate.sh
│   └── deploy.sh
├── examples/             # Optional: Working examples
│   ├── example1.py
│   ├── example2.py
│   └── README.md
└── config/              # Optional: Configuration files
    └── default.config.json
```

### Including Files in Skills

Reference associated files directly in your SKILL.md:

**Linking to scripts:**
```markdown
## Setup

Run the setup script to initialize the environment:

```bash
bash .opencode/skill/database-migration/scripts/setup.sh
```

This script will:
- Verify Alembic installation
- Check database connectivity
- Initialize required directories
```

**Referencing templates:**
```markdown
## Template

Use this migration template as a starting point:

```python
# See: .opencode/skill/database-migration/templates/migration-template.py
# Copy and customize for your needs
```

**Linking to examples:**
```markdown
## Complete Examples

- [Basic migration](examples/basic-migration.py)
- [Multi-tenant migration](examples/tenant-migration.py)
- [Complex transaction example](examples/transaction-example.py)
```

### Creating Helper Scripts

Helper scripts in the `scripts/` directory can automate common tasks. Scripts can be written in **shell (bash)** or **Python**.

**Example: Shell Script (setup.sh)**
```bash
#!/bin/bash
set -e

echo "Validating migration prerequisites..."

# Check Alembic
if ! command -v alembic &> /dev/null; then
    echo "Error: Alembic not installed"
    exit 1
fi

# Check database connection
if ! psql -c "SELECT 1" > /dev/null 2>&1; then
    echo "Error: Cannot connect to database"
    exit 1
fi

echo "✓ All prerequisites met"
```

**Example: Python Script (validate.py)**
```python
#!/usr/bin/env python3
"""Validates migration syntax before applying."""

import sys
import py_compile
from pathlib import Path

def validate_migration(migration_file):
    """Validate Python syntax of migration file."""
    try:
        py_compile.compile(migration_file, doraise=True)
        print(f"✓ Migration syntax is valid: {migration_file}")
        return True
    except py_compile.PyCompileError as e:
        print(f"✗ Syntax error in {migration_file}:")
        print(f"  {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: validate.py <migration_file>")
        sys.exit(1)
    
    migration_file = sys.argv[1]
    success = validate_migration(migration_file)
    sys.exit(0 if success else 1)
```

**Choosing Shell vs Python:**

| Use Shell | Use Python |
|-----------|-----------|
| System commands (cp, rm, mkdir) | Complex logic |
| Environment checks | Data processing |
| Simple validation | File transformations |
| Conditional execution | API interactions |
| Quick one-liners | Error handling with context |

**Making Scripts Executable:**

For shell scripts:
```bash
chmod +x .opencode/skill/my-skill/scripts/setup.sh
```

For Python scripts:
```bash
chmod +x .opencode/skill/my-skill/scripts/validate.py
# Add shebang: #!/usr/bin/env python3
```

Both can be called from SKILL.md documentation:
```markdown
# Shell script
bash .opencode/skill/my-skill/scripts/setup.sh

# Python script
python .opencode/skill/my-skill/scripts/validate.py migration.py
```

### Creating Reusable Templates

Templates provide starting points for common workflows:

**Example: migration-template.py**
```python
"""
Migration template for database schema changes.

Instructions:
1. Replace DESCRIPTION with your change summary
2. Implement upgrade() function with your schema changes
3. Implement downgrade() function (must be reversible)
4. Ensure all tenant-specific tables include tenant_id (if applicable)
"""

from alembic import op
import sqlalchemy as sa

# Update these
DESCRIPTION = "add feature column"
TABLE_NAME = "your_table_name"

def upgrade():
    """Apply migration changes."""
    # Example:
    # op.add_column(TABLE_NAME, 
    #     sa.Column('feature_flag', sa.Boolean(), default=False)
    # )
    pass

def downgrade():
    """Revert migration changes."""
    # Must be reversible - opposite of upgrade()
    # Example:
    # op.drop_column(TABLE_NAME, 'feature_flag')
    pass
```

### Example Configuration Files

Store default configurations for reproducible workflows:

**Example: config/default.config.json**
```json
{
  "migration": {
    "auto_version": true,
    "include_tenant_id": true,
    "test_before_deploy": true
  },
  "validation": {
    "check_syntax": true,
    "check_reversibility": true,
    "check_naming": true
  },
  "deployment": {
    "backup_before_migrate": true,
    "dry_run_first": true
  }
}
```

### Best Practices for Associated Files

1. **Keep scripts simple** - Single responsibility, easy to understand
2. **Add executable permissions** - `chmod +x scripts/*.sh`
3. **Include error handling** - Fail fast with clear error messages
4. **Document usage** - Comments explaining what each script does
5. **Make templates self-documenting** - Include inline instructions
6. **Test thoroughly** - Scripts should work as-is for users
7. **Avoid hardcoded paths** - Use relative paths when possible
8. **Version control** - Commit all files to git

### Referencing Files in SKILL.md

When mentioning associated files, use paths relative to skill root:

```markdown
## Implementation Steps

1. Copy the template:
   ```bash
   cp .opencode/skill/my-skill/templates/template.py my-implementation.py
   ```

2. Run the setup script:
   ```bash
   bash .opencode/skill/my-skill/scripts/setup.sh
   ```

3. Follow the example in:
   ```
   .opencode/skill/my-skill/examples/complete-example.py
   ```
```

### Organizing Complex Skills

For skills with extensive content, use subdirectories:

```
.opencode/skill/complex-skill/
├── SKILL.md
├── scripts/
│   ├── setup.sh
│   ├── validate.sh
│   ├── teardown.sh
│   └── utils.sh
├── templates/
│   ├── basic.template
│   ├── advanced.template
│   └── README.md
├── examples/
│   ├── simple-case/
│   │   ├── code.py
│   │   └── README.md
│   └── complex-case/
│       ├── code.py
│       └── README.md
└── config/
    ├── default.json
    └── production.json
```

## Skill Discovery and Loading

In this environment, skills are discovered by:
1. Walking up from current directory to git root
2. Loading `*.opencode/skill/*/SKILL.md` in `.opencode/`
3. Loading `.claude/skills/*/SKILL.md` for Claude compatibility
4. Loading global skills from `~/.opencode/skill/*/SKILL.md`

**How agents use skills:**
- The `skill` tool shows available skills with name + description
- Agents call `skill({ name: "skill-name" })` to load full content
- Skills are loaded on-demand, not automatically

## Permissions Configuration

Control skill access in `opencode.json`:

```json
{
  "permission": {
    "skill": {
      "pr-review": "allow",          // Loads immediately
      "internal-*": "deny",           // Hidden from agent
      "experimental-*": "ask",        // User prompt required
      "*": "allow"                    // Default behavior
    }
  }
}
```

**Permission Behaviors:**
- `allow`: Skill loads immediately without prompt
- `deny`: Skill hidden from agent, access rejected
- `ask`: User prompted for approval before loading

**Override per agent:**

In agent frontmatter:
```yaml
---
permission:
  skill:
    "internal-*": "allow"
---
```

In `opencode.json` for built-in agents:
```json
{
  "agent": {
    "plan": {
      "permission": {
        "skill": {
          "internal-*": "allow"
        }
      }
    }
  }
}
```

## Disabling Skills

Completely disable skills for specific agents:

**Custom agents:**
```yaml
---
tools:
  skill: false
---
```

**Built-in agents:**
```json
{
  "agent": {
    "plan": {
      "tools": {
        "skill": false
      }
    }
  }
}
```

## Naming Best Practices

Follow these conventions for skill names:

**Good Examples:**
- `git-release` - Clear, specific
- `database-migration` - Describes domain + action
- `api-testing` - Technology + activity
- `tenant-setup` - Neptune-specific concept

**Bad Examples:**
- `release` (too vague - git-release? npm-release?)
- `db-mig` (abbreviations create confusion)
- `-test-api` (starts with hyphen)
- `db--migration` (double hyphen)
- `API_TESTING` (uppercase, underscores)

**Naming Formula:**
`[domain]-[action]` or `[technology]-[workflow]`
- domain: backend, frontend, database, devops
- action: testing, migration, deployment, setup
- technology: git, postgres, docker, kubernetes

## Description Best Practices

Write descriptions that help agents choose the right skill:

**Vague (bad):**
```
description: Handle git operations
```

**Specific (good):**
```
description: Create GitHub releases with changelogs from merged PRs
```

**Too short:**
```
description: Test APIs
```

**Detailed enough:**
```
description: Test REST API endpoints using pytest and verify responses match OpenAPI schema
```

## Troubleshooting

If a skill doesn't show up:

1. **File naming:**
   - Check that file is `SKILL.md` (all caps)
   - Verify directory name matches `name` field
   - Ensure skill name follows naming rules

2. **Frontmatter:**
   - Confirm `name` and `description` exist
   - Validate YAML syntax (no trailing spaces)
   - Check for unknown fields (they're ignored but indicate issues)

3. **Permissions:**
   - Verify skill isn't denied in `opencode.json`
   - Check agent-specific permission overrides
   - Ensure skill tool is enabled (`tools: skill: true`)

4. **Uniqueness:**
   - Ensure skill names are unique across all locations
   - Global skills shadow project skills with same name

## Examples

### Simple Skill: Git Commit

```yaml
---
name: git-commit
description: Create conventional commits with properly formatted messages
---

## Purpose

Standardize commit messages across the Neptune project using conventional commits format.

## Structure

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Example

```
feat(backend): add API key authentication

Implements API key validation for tenant-specific endpoints.
Checks X-API-Key header against database records.

Fixes #123
```
```

### Complex Skill: Database Migration

```yaml
---
name: database-migration
description: Create database migrations for schema-per-tenant or standard architecture
---

## Purpose

Guide through creating database migrations using appropriate migration tool.

## Prerequisites

- Migration tool initialized
- Database connection available
- Understanding of multi-tenant patterns (if applicable)

## Steps

1. **Generate migration:**
   ```bash
   # For Alembic:
   alembic revision -m "add_feature_column"
   ```

2. **Edit migration file:**
   - Open generated migration file
   - Add tenant_id column for tenant-specific tables (if applicable)
   - Implement upgrade() and downgrade()

3. **Test locally:**
   ```bash
   alembic upgrade head
   alembic downgrade -1
   ```

4. **Verify schema:**
   ```bash
   psql -c "\d table_name"
   ```

## Best Practices

- Always include tenant_id in tenant-specific tables (if applicable)
- Write reversible migrations (upgrade + downgrade)
- Test with realistic data volumes
- Never modify deployed migrations

## Example

```python
from alembic import op
import sqlalchemy as sa

def upgrade():
    op.add_column('users',
        sa.Column('feature_flag', sa.Boolean(), default=False)
    )

def downgrade():
    op.drop_column('users', 'feature_flag')
```

## When NOT to Use

- For one-off data fixes (use scripts/)
- Direct production schema changes
- Modifying existing migrations
```

## When to Create a Skill

Create a skill when:

1. **Repetitive Instructions:** Multiple agents need the same workflow
2. **Complex Procedures:** Multi-step processes that benefit from standardization
3. **Domain Knowledge:** Specific technical patterns or conventions
4. **Team Standards:** Consistent ways of doing things across agents
5. **Troubleshooting:** Common debugging procedures or solutions

## Review Process

Before adding a skill to `.opencode/skill/`:

1. **Test the skill:** Walk through instructions yourself
2. **Check clarity:** Another developer should understand without help
3. **Verify examples:** Code samples should be accurate and runnable
4. **Review permissions:** Ensure appropriate access level
5. **Check conflicts:** Verify no naming conflicts with existing skills
6. **Document dependencies:** List any tools or prerequisites
7. **Verify frontmatter:** Only `name` and `description` fields, no optional fields

## Quick Checklist

- [ ] Directory name matches `name` field
- [ ] File is named `SKILL.md` (all caps)
- [ ] YAML frontmatter is valid with only `name` and `description`
- [ ] `name` follows naming rules (lowercase, hyphens)
- [ ] `description` is 1-1024 characters
- [ ] No optional fields (license, compatibility, metadata) in frontmatter
- [ ] Content is clear and actionable
- [ ] Examples are accurate
- [ ] Permissions configured if needed
- [ ] Tested by loading with skill tool

## Additional Resources

- [OpenCode Skills Documentation](https://opencode.ai/docs/skills/)
- [Claude Skills Reference](https://docs.anthropic.com/claude/docs/skills)
- Use agent's skill tool to list available skills

---

**Remember:** Good skills are specific, well-documented, and solve real problems agents encounter repeatedly. They should be loaded rarely but trusted completely.
