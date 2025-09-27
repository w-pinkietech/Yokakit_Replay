# Data Model: GitHub Repository Infrastructure

## Entity Definitions

### Branch Protection Rule
**Purpose**: Configuration that enforces quality gates and review processes on protected branches
**Fields**:
- `branch_pattern`: String pattern for protected branches (e.g., "main", "phase-*")
- `required_reviewers`: Integer count of required PR reviewers (default: 1)
- `required_status_checks`: Array of required CI/CD status check names
- `enforce_admins`: Boolean to apply rules to repository administrators
- `allow_force_pushes`: Boolean to permit force pushes (default: false)
- `allow_deletions`: Boolean to permit branch deletion (default: false)
- `required_linear_history`: Boolean to enforce linear history (default: true)

**Relationships**:
- Associated with GitHub Repository
- References Status Check entities
- Maps to Team Permission entities

**Validation Rules**:
- At least one required status check must be specified
- Required reviewers must be >= 1 for main branch
- Branch pattern must be valid Git reference pattern

### Workflow Template
**Purpose**: Pre-configured automation scripts for CI/CD processes with enhanced trigger support
**Fields**:
- `name`: Unique workflow identifier
- `triggers`: Object containing trigger configuration (push, PR, schedule, dispatch)
- `jobs`: Array of job definitions with steps and requirements
- `permissions`: Object defining workflow token permissions
- `concurrency_group`: String for workflow concurrency management
- `timeout_minutes`: Integer for maximum workflow execution time

**Relationships**:
- Generates Status Check entities
- References Security Scanning entities
- Associated with Repository entity

**State Transitions**:
- queued → in_progress → completed/failed/cancelled
- Manual dispatch triggers: pending → queued
- Scheduled triggers: waiting → queued

### Issue Template
**Purpose**: Standardized forms for GitHub issues with conditional fields and automated routing
**Fields**:
- `template_name`: Unique identifier for the template
- `template_type`: Enum (bug_report, feature_request, general_inquiry)
- `form_fields`: Array of field definitions with types and validation
- `labels`: Array of automatic labels to apply
- `assignees`: Array of default assignee rules
- `project_mapping`: Object for automatic project board assignment

**Relationships**:
- Maps to Milestone entities (phase-based assignment)
- References Team Permission entities (assignee rules)
- Associated with Label entities

**Validation Rules**:
- Required fields must be specified in form schema
- Labels must exist in repository configuration
- Assignees must have repository access permissions

### Team Permission
**Purpose**: Phase-based access control with dynamic permission elevation
**Fields**:
- `team_name`: Unique team identifier (e.g., "phase-1-leads")
- `permission_level`: Enum (admin, write, read)
- `active_phases`: Array of phase numbers where team has elevated access
- `members`: Array of GitHub usernames
- `auto_assignment_rules`: Object for automatic PR/issue assignment

**Relationships**:
- Referenced by Branch Protection Rule entities
- Maps to Milestone entities (phase boundaries)
- Associated with Issue Template assignee rules

**State Transitions**:
- inactive → active (when entering assigned phase)
- active → inactive (when exiting assigned phase)
- Permission elevation/demotion based on phase transitions

### Milestone
**Purpose**: Project phase markers with timeline and completion criteria
**Fields**:
- `milestone_title`: Phase name (e.g., "Phase 0: Repository Setup")
- `description`: Detailed phase objectives and deliverables
- `due_date`: Target completion date
- `completion_percentage`: Calculated based on associated issues
- `phase_number`: Integer representing sequential phase order
- `constitutional_requirements`: Array of constitutional compliance checkpoints

**Relationships**:
- Associated with Issue entities (phase assignment)
- Referenced by Team Permission entities (phase boundaries)
- Maps to Pull Request entities (phase completion verification)

**Validation Rules**:
- Due dates must be sequential (Phase N due before Phase N+1)
- Phase numbers must be unique and sequential
- Constitutional requirements must reference valid constitution sections

### Security Scanning Entity
**Purpose**: Configuration for GitHub native security tools integration
**Fields**:
- `tool_name`: Enum (codeql, dependabot, secret_scanning)
- `configuration`: Object with tool-specific settings
- `schedule`: Cron expression for automated scans
- `alert_thresholds`: Object defining when to create alerts/block PRs
- `exclusion_patterns`: Array of file/directory patterns to exclude

**Relationships**:
- Referenced by Workflow Template entities
- Generates Status Check entities
- Associated with Branch Protection Rule requirements

**State Transitions**:
- scheduled → running → completed (with results)
- alert_triggered → acknowledged → resolved
- vulnerability_detected → patched → verified

## Data Flow Patterns

### Repository Initialization Flow
```
1. Create Branch Protection Rules → Configure required status checks
2. Setup Team Permissions → Apply phase-based access controls
3. Generate Workflow Templates → Enable enhanced triggers
4. Deploy Issue Templates → Configure automated routing
5. Initialize Milestones → Map to constitutional phases
6. Activate Security Scanning → Integrate native tools
```

### Phase Transition Flow
```
1. Milestone completion triggers → Team permission updates
2. Phase-lead access elevation → Branch protection adjustments
3. Workflow template updates → Phase-specific automation
4. Issue template routing → New phase assignee rules
```

### Pull Request Integration Flow
```
1. PR creation → Workflow triggers → Status checks execution
2. Security scanning → Results integration → Pass/fail determination
3. Review requirements → Phase-lead approval → Merge eligibility
4. Constitutional compliance → Submodule sync → Phase advancement
```

## Constitutional Compliance Integration

### Identity Preservation
- All entity names and descriptions maintain YokaKit branding
- Template text preserves YokaKit project context
- No PinkieIt references in user-facing configurations

### Sequential Phase Enforcement
- Milestone entities enforce constitutional phase sequence
- Team permissions respect phase boundaries
- Workflow templates support phase-specific automation

### Audit Trail Maintenance
- All entities include fields for PinkieIt commit references
- Change history tracking for constitutional compliance
- Security scanning results provide audit evidence