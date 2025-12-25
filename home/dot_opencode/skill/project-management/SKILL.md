# Project Management: Epics and Stories Organization

This skill provides comprehensive guidance on how to structure and organize epics and stories in GitHub.

## Purpose

Establish clear project management practices for organizing work into epics (large initiatives) and stories (individual tasks), ensuring proper hierarchy, tracking, and completion workflows.

## ⚠️ CRITICAL: Epic Creation Workflow

**IMPORTANT:** When creating epics and stories, ALWAYS follow this sequence:

### Step 1: Create the Epic FIRST
1. Create the epic issue in GitHub
2. Add `epic` label and other relevant labels
3. Write clear business objective in the body
4. Include an empty Sub-Issues section

**Example:**
```markdown
## Overview
Implement a comprehensive authentication and authorization system for both 
customer/tenant users and administrative users.

## Sub-Issues
(Stories will be added here as they are created)
```

### Step 2: Create ALL Stories as Sub-Issues
**Before creating the epic, you MUST have the sub-issue IDs to link them properly.**

The correct workflow is:
1. **First:** Create all user stories as GitHub issues
2. **Second:** Link each story to the epic using GitHub's sub-issue API
3. **Third:** Add the epic and all stories to the project board

**Why this order matters:**
- GitHub's sub-issue relationship requires issue IDs
- You cannot link issues that don't exist yet
- The project board update happens AFTER issues are created and linked

### Step 3: Link Stories to Epic Using GitHub API
After creating all stories, use the GitHub sub-issue API to link them:

```bash
# For each story, link it to the parent epic
github-perso_sub_issue_write(
  method: "add",
  owner: "subagenta",
  repo: "neptune", 
  issue_number: 103,  # Epic number
  sub_issue_id: 3761837331  # Story's internal ID (from creation response)
)
```

**Key points:**
- Use the story's internal ID, not the issue number
- The internal ID is returned when you create the issue
- This creates a proper parent-child relationship in GitHub

### Step 4: Add to Project Board
Only AFTER all issues are created and linked, add them to the project board:

```bash
# Use the project-updater agent
task(
  subagent_type: "project-updater",
  prompt: "Add epic #103 and stories #104-#115 to Technical Project board"
)
```

## ⚠️ CRITICAL PRINCIPLE: All Work Must Be Tracked in GitHub Issues

**This is non-negotiable:** Every piece of work—whether it's a feature, bug fix, documentation, or refactoring—must have a corresponding GitHub issue.

## Key Concepts

### Epic
An **epic** is a large, strategic initiative that encompasses multiple related stories.

**Characteristics:**
- Large scope (typically 2-4 weeks or more of work)
- Contains multiple related stories (typically 5-15 stories)
- Labeled with `epic` label
- Has a clear business objective
- Tracked as a parent issue with sub-issues

**Epic Title Format:**
- Use `[EPIC]` prefix to make it easily identifiable
- Example: `[EPIC] Authentication System`

**Epic Structure:**
```markdown
## Overview
Brief description of the epic's business objective and scope.

## Business Goals
- Goal 1
- Goal 2
- Goal 3

## Technical Scope
### Component 1
- Feature A
- Feature B

### Component 2
- Feature C
- Feature D

## Architecture Components
### Backend
- Models, API endpoints, middleware

### Frontend  
- Pages, components, state management

### Database
- Schema changes, tables, migrations

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Dependencies
- Library/framework dependencies
- External service integrations

## Out of Scope (Future Enhancements)
- Feature X
- Feature Y

## Sub-Issues
This epic will be broken down into the following user stories:
(Stories are linked via GitHub's sub-issue feature)
```

### Story
A **story** is a discrete, deliverable piece of work that can be completed independently.

**Story Title Format:**
- Use descriptive, specific titles
- Example: `User Story: User Registration and Signup Flow`
- Or: `User Story: Admin Customer Impersonation` (if applicable)

**Story Structure:**
```markdown
**Parent Epic:** #103

## User Story
As a [user type], I want to [action] so that [benefit].

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Technical Details

### Backend Implementation
**File:** `path/to/file.py`

**Endpoints:** `POST /api/v1/endpoint`

**Request/Response examples**

**Database Changes:**
- Table schema
- Migrations

### Frontend Implementation
**File:** `path/to/component.tsx`

**Components, pages, state management**

## Test Cases
- [ ] Test 1
- [ ] Test 2

## Security Considerations
- Security requirement 1
- Security requirement 2

## Performance Requirements
- Performance metric 1
- Performance metric 2

## Definition of Done
- [ ] Implementation complete
- [ ] Tests written (>90% coverage)
- [ ] Documentation updated
- [ ] Security review completed
- [ ] Deployed to production

## Related Issues
- #103 (Parent Epic)
- Depends on: #104
- Blocks: #106
```

## Creating a Comprehensive Epic with Stories

### Planning Phase

**Before creating any GitHub issues:**

1. **Analyze the Requirements**
   - Understand the full scope of the epic
   - Identify major components (backend, frontend, database, security)
   - Break down into logical user stories
   - Consider dependencies between stories

2. **Design the Story Breakdown**
   - Group related functionality into stories
   - Ensure each story is independently deliverable
   - Typical epic has 5-15 stories
   - Each story should be 1-5 days of work

3. **Plan the Technical Architecture**
   - Database schema changes
   - API endpoints needed
   - Frontend components
   - Security requirements
   - Testing strategy

### Creation Sequence

**CRITICAL: Follow this exact order:**

#### Step 1: Create Epic Issue
```bash
github-perso_issue_write(
  method: "create",
  owner: "<your-org>",
  repo: "<your-repo>",
  title: "[EPIC] Authentication System",
  labels: ["epic", "authentication", "high-priority", "security"],
  body: "Comprehensive epic description with all sections..."
)
```

**Epic gets issue number, e.g., #103**

#### Step 2: Create ALL Story Issues
```bash
# Story 1
github-perso_issue_write(
  method: "create",
  owner: "<your-org>", 
  repo: "<your-repo>",
  title: "User Story: User Registration and Signup Flow",
  labels: ["story", "authentication", "backend", "frontend"],
  body: "Complete story with acceptance criteria, technical details, etc..."
)
# Returns: {"id": "3761837331", "url": "...issues/104"}

# Story 2  
github-perso_issue_write(
  title: "User Story: Email/Password Authentication and Login",
  ...
)
# Returns: {"id": "3761837611", "url": "...issues/105"}

# Continue for all stories...
```

**Save the internal IDs from each response!**

#### Step 3: Link Stories to Epic
```bash
# Link each story using its internal ID
github-perso_sub_issue_write(
  method: "add",
  owner: "<your-org>",
  repo: "<your-repo>",
  issue_number: 103,  # Epic number
  sub_issue_id: 3761837331  # Story 1 internal ID
)

github-perso_sub_issue_write(
  method: "add",
  issue_number: 103,
  sub_issue_id: 3761837611  # Story 2 internal ID  
)

# Continue for all stories...
```

#### Step 4: Add to Project Board
```bash
task(
  subagent_type: "project-updater",
  description: "Add auth epic to project",
  prompt: "Add epic #103 and all sub-issues (#104-#115) to the Technical Project board.
  Set appropriate status (Backlog/Todo) and ensure proper parent-child relationships."
)
```

### Example: Authentication Epic Breakdown

**Epic #103: Authentication System**

**User Stories:**
1. #104 - User Registration and Signup Flow
2. #105 - Email/Password Authentication and Login  
3. #106 - JWT Token Refresh and Rotation
4. #107 - Password Reset and Recovery Flow
5. #108 - OAuth Integration (Google, GitHub, Microsoft)
6. #109 - Multi-Factor Authentication (MFA) with TOTP
7. #114 - Session Management and Multi-Device Support

**Admin Stories (if applicable):**
8. #111 - Admin User Model and RBAC
9. #112 - Admin Authentication with Enhanced Security
10. #110 - Admin User Impersonation (if needed)
11. #113 - Audit Logging System for Admin Actions

**Frontend Integration:**
12. #115 - Frontend Auth Components and Protected Routes

**Total:** 1 Epic + 12 Stories = 13 issues

## Story Writing Best Practices

### Comprehensive Acceptance Criteria

**Bad:**
```markdown
- [ ] Login works
- [ ] User can reset password
```

**Good:**
```markdown
- [ ] User can submit login form with email and password
- [ ] Backend validates credentials against hashed password
- [ ] Successful login returns JWT access and refresh tokens
- [ ] Failed login returns clear error message
- [ ] Account lockout after 5 failed attempts (15 min cooldown)
- [ ] Login attempts are rate limited (10 per minute per IP)
- [ ] Tokens are stored securely (HTTP-only cookies)
- [ ] User is redirected to dashboard after successful login
- [ ] "Remember me" option extends refresh token expiration
- [ ] Login page shows loading state during authentication
```

### Detailed Technical Specifications

Include:
- **Exact file paths** for implementation
- **API endpoint specifications** with request/response examples
- **Database schema** with field types and constraints
- **Frontend components** with props and state
- **Code examples** for complex logic
- **Security considerations** specific to the story
- **Performance requirements** with metrics

**Example:**
```markdown
### Backend Implementation
**File:** `backend/app/api/v1/endpoints/auth.py` (or appropriate path)

**Endpoint:** `POST /api/v1/auth/login`

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecureP@ssw0rd123",
  "remember_me": false
}
```

**Response:**
```json
{
  "access_token": "eyJhbGc...",
  "refresh_token": "eyJhbGc...",
  "token_type": "bearer",
  "expires_in": 900,
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "full_name": "John Doe"
  }
}
```
```

### Test Cases

**Comprehensive test coverage:**
```markdown
## Test Cases
- [ ] Valid credentials return tokens and user data
- [ ] Invalid email returns 401 error
- [ ] Invalid password returns 401 error
- [ ] Unverified email returns 403 error
- [ ] Locked account returns 403 error
- [ ] 5 failed attempts lock account for 15 minutes
- [ ] Access token expires after 15 minutes
- [ ] Refresh token can generate new access token
- [ ] Remember me extends refresh token to 30 days
- [ ] Session is tracked in database
```

### Security Considerations

**Always include:**
- Specific security measures
- Attack vectors prevented
- Compliance requirements
- Data protection methods

**Example:**
```markdown
## Definition of Done
- [ ] Backend endpoint implemented and tested
- [ ] Frontend component implemented (if applicable)
- [ ] Database migration created and applied (if applicable)
- [ ] Unit tests written (>90% coverage)
- [ ] Integration tests pass
- [ ] API documentation updated
- [ ] Security review completed
- [ ] Performance benchmarks met
- [ ] Code review approved
- [ ] Deployed to staging
- [ ] QA testing completed
- [ ] Deployed to production
```

### Definition of Done

**Complete checklist:**
```markdown
## Definition of Done
- [ ] Backend endpoint implemented and tested
- [ ] Frontend component implemented
- [ ] Database migration created and applied
- [ ] Unit tests written (>90% coverage)
- [ ] Integration tests pass
- [ ] API documentation updated
- [ ] Security review completed
- [ ] Performance benchmarks met
- [ ] Code review approved
- [ ] Deployed to staging
- [ ] QA testing completed
- [ ] Deployed to production
```

## Labels and Organization

### Epic Labels
- `epic` - **Required** for all epics
- `high-priority` - High business value
- Functional area: `authentication`, `billing`, `gtm`, `marketing`
- Stack: `backend`, `frontend`, `database`, `devops`

### Story Labels  
- `story` - **Required** for all stories
- Parent epic label: `authentication`, `billing`, etc.
- Stack: `backend`, `frontend`, `database`
- Priority: `P1-HIGH`, `P2-MEDIUM`, `P3-LOW`

### Project Board Integration

**After creating issues:**
1. Use `project-updater` agent to add to board
2. Epic goes to "Backlog" status
3. Stories start as "Todo" or "Backlog"
4. Update status as work progresses

## Common Pitfalls and Solutions

### Pitfall 1: Creating Epic Without Stories
**Problem:** Epic created but no stories exist yet
**Solution:** Always create stories BEFORE or immediately AFTER epic

### Pitfall 2: Wrong Linking Order
**Problem:** Trying to link stories before they exist
**Solution:** Create stories first, then link them to epic

### Pitfall 3: Missing Internal IDs
**Problem:** Can't link stories because internal IDs weren't saved
**Solution:** Save the `id` field from each story creation response

### Pitfall 4: Not Using Sub-Issue API
**Problem:** Manually listing stories in epic body doesn't create GitHub relationships
**Solution:** Use `github-perso_sub_issue_write` to create proper links

### Pitfall 5: Forgetting Project Board
**Problem:** Issues created but not visible on project board
**Solution:** Always use `project-updater` agent after creating issues

## Quick Reference Checklist

### Creating an Epic with Stories

- [ ] Analyze requirements and plan story breakdown
- [ ] Create epic issue in GitHub (get epic number, e.g., #103)
- [ ] Create ALL story issues (save each internal ID)
- [ ] Link each story to epic using `sub_issue_write` API
- [ ] Add epic and stories to project board via `project-updater`
- [ ] Verify all stories show as sub-issues on epic page
- [ ] Verify epic and stories appear on project board

### Writing a Story

- [ ] Title starts with "User Story:" and is descriptive
- [ ] References parent epic: `**Parent Epic:** #103`
- [ ] Includes user story format: "As a [user], I want [action] so that [benefit]"
- [ ] Has comprehensive acceptance criteria (10+ items)
- [ ] Includes detailed technical implementation section
- [ ] Specifies exact file paths and endpoints
- [ ] Provides code examples for complex logic
- [ ] Lists all test cases (10+ tests)
- [ ] Documents security considerations
- [ ] Defines performance requirements
- [ ] Has complete "Definition of Done" checklist
- [ ] Labels include: `story`, parent epic category, stack tags

### Linking and Organization

- [ ] Stories created as GitHub issues
- [ ] Internal IDs saved from creation responses
- [ ] Each story linked to epic via `sub_issue_write` API
- [ ] Epic and stories added to project board
- [ ] Proper labels applied to all issues
- [ ] Dependencies documented in story body

## Example Epic Creation Script

```markdown
# 1. Create Epic
epic = github-perso_issue_write(
  title: "[EPIC] Authentication System",
  labels: ["epic", "authentication", "security"],
  body: "Full epic description..."
)
# Returns: #103

# 2. Create Stories
story_ids = []

story1 = github-perso_issue_write(
  title: "User Story: User Registration",
  labels: ["story", "authentication", "backend"],
  body: "**Parent Epic:** #103\n\nFull story..."
)
story_ids.append(story1.id)  # Save: 3761837331

story2 = github-perso_issue_write(
  title: "User Story: Login Flow",
  ...
)
story_ids.append(story2.id)  # Save: 3761837611

# Continue for all stories...

# 3. Link Stories to Epic
for story_id in story_ids:
  github-perso_sub_issue_write(
    method: "add",
    issue_number: 103,
    sub_issue_id: story_id
  )

# 4. Add to Project Board
task(
  subagent_type: "project-updater",
  prompt: "Add epic #103 and stories #104-#115 to board"
)
```

## Additional Resources

- GitHub Issues API: https://docs.github.com/en/rest/issues
- GitHub Sub-Issues: https://docs.github.com/en/issues/tracking-your-work-with-issues

---

**Remember:** 
1. Epic FIRST (or stories first, then epic, then link them)
2. Create ALL stories
3. Link stories to epic using API
4. Add to project board LAST
5. Comprehensive stories with detailed specs ensure successful implementation
