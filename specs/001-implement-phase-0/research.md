# Phase 0 Research: GitHub Repository Infrastructure

## Research Findings

### Workflow Simplification and Job Name Standardization
**Decision**: Prioritize simplicity over comprehensive automation, standardize job names for branch protection alignment
**Rationale**:
- User feedback: "なんかいらないactionいっぱいしてない？" (Aren't there a lot of unnecessary actions?) led to workflow simplification
- GitHub branch protection requires exact job name matches for required status checks
- "Waiting for status to be reported" issue resolved by aligning job names with protection requirements
- Infrastructure repository needs basic validation, not complex CI/CD pipelines
**Implementation**:
- Deleted: ci-cd-enhanced.yml, enhanced-ci-cd.yml, manual-dispatch.yml, scheduled-maintenance.yml, security-scanning.yml
- Created: infrastructure-ci.yml (build-and-test, security-scan-codeql, code-coverage, lint-validation)
- Created: security-basic.yml (dependency-check)
- All job names match branch protection required status checks exactly

### GitHub Actions Workflow Architecture
**Decision**: Simplified dual-workflow architecture with standardized job names for maintainability
**Rationale**:
- User feedback indicated overcomplicated workflows were unnecessary for infrastructure repository
- Simplified infrastructure-ci.yml and security-basic.yml provide essential functionality
- Standardized job names (build-and-test, security-scan-codeql, dependency-check, code-coverage, lint-validation) align with branch protection requirements
- Reduced from 5 complex workflows (1,666 lines) to 2 simple workflows (141 lines) for better maintainability
- Focus on core functionality rather than comprehensive automation reduces complexity
**Alternatives considered**:
- Original enhanced workflow system (rejected due to user feedback on unnecessary complexity)
- Single monolithic workflow file (would be harder to maintain and understand)
- Per-feature micro-workflows (would create too many files for simple infrastructure needs)

### Branch Protection with Phase-Based Permissions
**Decision**: Dynamic branch protection rules with team-based permissions tied to development phases
**Rationale**:
- Phase-leads get elevated access during their assigned development phase
- Maintains security while enabling efficient phase-based development workflow
- Aligns with constitutional requirement for sequential phase execution
- Supports PinkieIt commit hash reference requirements through enforced PR process
**Alternatives considered**:
- Static admin-only permissions (would block phase-lead autonomy)
- Branch-per-phase strategy (complicates main branch integration)
- Time-based permissions (requires external scheduling, less flexible)

### GitHub Native Security Tools Integration
**Decision**: CodeQL for static analysis, Dependabot for dependency management, Secret scanning for credential protection
**Rationale**:
- Native GitHub integration reduces external dependencies and complexity
- CodeQL provides comprehensive static analysis without third-party tools
- Dependabot automates dependency updates with security vulnerability detection
- Secret scanning prevents credential exposure in repository
- All tools integrate seamlessly with status checks and PR workflow
**Alternatives considered**:
- Third-party SAST tools (adds complexity, licensing costs, external dependencies)
- Manual security reviews (insufficient scale, human error prone)
- Mixed security tool stack (increases integration complexity, inconsistent reporting)

### Issue Template YAML Schema
**Decision**: Structured YAML forms with conditional fields, labels, and assignee automation
**Rationale**:
- YAML forms provide better user experience than markdown templates
- Conditional fields reduce form complexity while capturing necessary information
- Automatic labeling improves issue organization and routing
- Phase-based assignee rules align with constitutional project management requirements
**Alternatives considered**:
- Markdown issue templates (less structured, harder to parse)
- Multiple template repository (harder to maintain, user confusion)
- External issue management system (reduces GitHub integration, adds complexity)

### Milestone Automation and Project Integration
**Decision**: GitHub native milestones with automated project board updates via Actions
**Rationale**:
- Native milestone integration with issues and pull requests
- Automated project board updates reduce manual overhead
- Phase-based milestone structure aligns with constitutional requirements
- GitHub GraphQL API enables sophisticated automation workflows
**Alternatives considered**:
- External project management tools (reduces GitHub integration)
- Manual milestone management (increases overhead, error prone)
- Issue-based phase tracking (less visible, harder to report progress)

## Technical Specifications

### Workflow Architecture
```yaml
Enhanced Triggers:
  - push: [main, phase-*/*, feature/*]
  - pull_request: [main]
  - schedule: "0 2 * * *" # Daily at 2 AM UTC
  - workflow_dispatch: # Manual triggers with input parameters

Status Checks Required:
  - build-and-test
  - security-scan-codeql
  - dependency-check
  - code-coverage
  - lint-validation
```

### Security Integration Pattern
```yaml
CodeQL Configuration:
  - languages: ["javascript", "typescript", "python", "php"]
  - query-filters: security-extended
  - fail-on: error

Dependabot Configuration:
  - package-managers: ["npm", "composer", "pip"]
  - schedule: weekly
  - auto-merge: patch-level updates only

Secret Scanning:
  - enabled: true
  - push-protection: true
  - custom-patterns: API keys, database credentials
```

### Permission Model
```yaml
Phase-Based Teams:
  - phase-0-leads: Admin access during Phase 0
  - phase-1-leads: Admin access during Phase 1
  - phase-n-leads: Admin access during Phase N
  - contributors: Write access with PR requirements
  - observers: Read access for external stakeholders

Branch Protection Rules:
  - require-pull-request: true
  - required-reviewers: 1 (phase-lead)
  - require-status-checks: true
  - required-checks: [all security and quality gates]
  - restrict-push: true (no direct pushes to main)
```

## Constitutional Compliance Verification

### Identity Preservation
- All templates reference YokaKit project name
- No PinkieIt branding in user-facing documentation
- Submodule documentation preserves YokaKit context

### Sequential Phase Support
- Milestone structure maps to 6 constitutional phases
- Branch naming convention supports phase-{N}-{feature} pattern
- Workflow automation respects phase boundaries

### Submodule Synchronization
- Documentation includes submodule update procedures
- Workflow templates support submodule version management
- Phase completion triggers include submodule synchronization steps

### Audit Trail Requirements
- All commits require PinkieIt reference in PR descriptions
- Branch protection ensures PR workflow compliance
- Security scanning provides compliance audit logs