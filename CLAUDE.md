# YokaKit_Replay - Claude Code Context

## Project Overview
YokaKit_Replay is a strategic planning and analysis repository that orchestrates the modernization of the YokaKit application through constitutional compliance, proven pattern analysis, and comprehensive implementation planning.

## Repository Roles & Relationships

### YokaKit_Replay (This Repository)
**Role**: Strategic planning, analysis, and implementation orchestration repository
**GitHub URL**: `https://github.com/YOUR_ORG/YokaKit_Replay` (example)
**Purpose**:
- Comprehensive implementation planning and design (specs/)
- Historical pattern analysis from PinkieIt (docs/analysis/)
- Constitutional compliance governance (memory/constitution.md)
- GitHub management guidance (docs/github-management/)
- Development workflow orchestration

**Key Contents**:
```
YokaKit_Replay/
├── specs/                    # Implementation plans for each phase
│   ├── 001-implement-phase-0/
│   └── 002-phase-1-docker/  # Current: Phase 1 planning
├── docs/                     # Analysis and guidance documents
│   ├── analysis/timeline/   # PinkieIt pattern extraction
│   └── github-management/   # Label/Issue/Milestone guides
├── memory/constitution.md   # Constitutional requirements v1.2.0
├── YokaKit/                 # Submodule → actual development target
└── pinkieit/                # Submodule → pattern reference source
```

**Development Activity**: Planning, documentation, analysis (NO application code changes)

### YokaKit Repository (Submodule, Independent GitHub Repo)
**Role**: Actual development repository where implementation happens
**GitHub URL**: `https://github.com/YOUR_ORG/YokaKit` (independent repository)
**Purpose**:
- Production Laravel application codebase
- Receives improvements from replay process
- GitHub Issue/PR management for actual development
- Target for Docker environment, structural fixes, modernization

**Key Development Activities**:
- Docker infrastructure implementation
- Model relocation (app/Http/Requests → app/Models)
- Laravel 9.19 → 10.x upgrade
- PHP 8.0.2 → 8.2 upgrade
- Quality infrastructure integration

**GitHub Management**:
- **Labels**: 4-tier hierarchy migrated from YokaKit_Replay
- **Issues**: Development tasks created here (not in YokaKit_Replay)
- **Milestones**: Phase 0-6 tracking
- **Pull Requests**: Code review and merge workflow

**Relationship to YokaKit_Replay**: Referenced as Git submodule for coordination, but maintains independent GitHub identity for Issue/PR management

### PinkieIt Repository (Submodule, Reference Only)
**Role**: Historical reference repository for proven patterns
**GitHub URL**: `https://github.com/w-pinkietech/pinkieit` (read-only reference)
**Purpose**:
- Source of proven modernization patterns (189 commits)
- Commit hash references for audit trail
- Pattern extraction for YokaKit improvements
- Constitutional compliance validation

**Usage**: Read-only analysis, NO direct code copying (constitutional requirement)

## Development Workflow

### Planning Phase (YokaKit_Replay)
1. Create implementation plan in `specs/###-feature/`
2. Research PinkieIt patterns from commit history
3. Design contracts, data models, quickstart guides
4. Update constitutional compliance requirements

### Implementation Phase (YokaKit Repository)
1. **Create GitHub Issues** in YokaKit repository with migrated labels
2. **Implement changes** in YokaKit application code
3. **Submit Pull Requests** in YokaKit repository
4. **Reference PinkieIt commits** for audit trail in commit messages
5. **Update YokaKit_Replay submodule** reference after phase completion

### Example: Phase 1 Docker Foundation
```bash
# Planning (in YokaKit_Replay)
/plan "Phase 1 Docker Foundation..."  # Creates specs/002-phase-1-docker/

# GitHub Setup (on YokaKit repository)
gh label create "epic:phase-1" --repo YOUR_ORG/YokaKit --color "0052cc"
gh issue create --repo YOUR_ORG/YokaKit \
  --title "[EPIC] Phase 1: Docker Foundation" \
  --label "epic:phase-1,constitutional:identity-preservation"

# Implementation (in YokaKit submodule directory)
cd YokaKit/
# Create docker-compose.yml, Dockerfile, .devcontainer/, etc.
git add .
git commit -m "feat: add Docker foundation (PinkieIt commit: a5d3b77)"
git push origin feature/phase-1-docker

# Create PR in YokaKit repository
gh pr create --repo YOUR_ORG/YokaKit --title "Phase 1: Docker Foundation"

# After merge, update YokaKit_Replay submodule reference
cd ../
git add YokaKit
git commit -m "chore: update YokaKit submodule to Phase 1 completion"
```

## Repository Architecture Principle

**Separation of Concerns**:
- **YokaKit_Replay**: WHAT to do, WHY to do it, HOW to plan (meta-repository)
- **YokaKit**: Actual implementation, Issue tracking, development workflow (application repository)
- **PinkieIt**: Historical reference, pattern source (read-only reference)

This architecture ensures:
- Clear constitutional compliance tracking in YokaKit_Replay
- Standard GitHub development workflow in YokaKit
- Audit trail maintenance through submodule references
- YokaKit identity preservation throughout

## Current Status: Phase 1 Docker Foundation & Development Environment IN PROGRESS 🚧

### Phase 0 Completion Status ✅
- **CodeQL Submodule Exclusion**: ✅ YokaKit and pinkieit submodules excluded from analysis
- **Workflow Dependency Removal**: ✅ Laravel/PHP dependencies made optional for Phase 0
- **Infrastructure Validation**: ✅ All workflows execute without Phase 1 dependencies
- **Constitutional Compliance**: ✅ YokaKit identity preserved, audit trail maintained
- **Submodule Management**: ✅ Absolute GitHub URLs configured, .gitmodules fixed

### Phase 1 Implementation Plan ✅
- **GitHub Management Setup**: ✅ Label migration, milestone structure, Epic issue creation
- **Docker Foundation**: 🚧 PHP 8.2 + Apache + MariaDB containerization (PinkieIt a5d3b77 pattern)
- **Development Environment**: 🚧 DevContainer integration, VS Code configuration
- **Structural Improvements**: 🚧 Model relocation from app/Http/Requests to app/Models
- **Quality Infrastructure**: 🚧 Validation scripts, constitutional compliance automation

### Technical Stack
- **Containerization**: Docker + Docker Compose with multi-stage builds
- **Runtime**: PHP 8.2 + Apache (upgrading from PHP 8.0.2)
- **Database**: MariaDB 10.11.4 with persistent volumes
- **Framework**: Laravel 10.x (upgrading from 9.19)
- **Development**: VS Code DevContainer with Laravel-optimized extensions
- **Quality**: Laravel Pint, Larastan, PHPUnit, constitutional compliance validation
- **Platform**: Cross-platform Docker environment (Windows, macOS, Linux)
- **Security**: GitHub native tools + container security best practices
- **Automation**: GitHub Actions + validation scripts + quality gates
- **Governance**: 4-tier label hierarchy (Epic→Story→Task→Constitutional)

### Key Components
- Enhanced CI/CD workflows with security integration
- Branch protection with quality gates (build, test, security scans, coverage, linting)
- Issue templates with constitutional compliance fields
- 7-phase milestone structure aligned with development roadmap
- Team permission management with phase-based access elevation

## Constitutional Requirements

### Critical Constraints
1. **Identity Preservation (NON-NEGOTIABLE)**: Maintain YokaKit naming, skip PinkieIt name change commits
2. **Historical Fidelity**: Extract improvements from PinkieIt git history, apply incrementally
3. **Sequential Phases**: Strict phase sequence (0→1→2→3→4→5→6)
4. **Submodule Sync**: Update YokaKit submodule at each phase completion
5. **Audit Trail**: All commits must reference PinkieIt commit hashes

### Phase Structure
- **Phase 0**: GitHub repository initialization ✅ COMPLETED
- **Phase 1**: Docker Foundation & Development Environment (4 weeks)
- **Phase 2**: Quality Infrastructure Day (1 day intensive)
- **Phase 3**: Comprehensive Testing (2 weeks)
- **Phase 4**: Framework Modernization (Laravel 10.x + PHP 8.2) (1 week)
- **Phase 5**: Advanced Docker Optimization (1 week)
- **Phase 6**: CI/CD Integration & Final Polish (1 week)

## Repository Structure
```text
.github/
├── workflows/           # GitHub Actions automation
├── ISSUE_TEMPLATE/      # Structured issue forms
└── pull_request_template.md

docs/analysis/
├── README.md                           # Analysis documentation overview
├── RESPONSIBILITY_MATRIX.md           # Document authority definitions
├── current-state/                     # Technical baseline
│   └── yokakit-current-state-analysis.md
├── timeline/                          # Strategy and history
│   ├── development-timeline-analysis.md    # Strategic master plan
│   └── pinkieit-development-timeline.md   # Historical reference
└── quality-assurance/                 # Validation
    └── document-inconsistencies-analysis.md

docs/github-management/
├── LABEL_GUIDE.md                     # Label hierarchy and usage guidelines
├── ISSUE_MILESTONE_GUIDE.md           # Epic/Story/Task definitions
└── README.md                          # GitHub management overview

specs/001-implement-phase-0/
├── spec.md             # Feature specification with clarifications
├── plan.md             # This implementation plan
├── research.md         # Technical research and decisions
├── data-model.md       # Entity definitions and relationships
├── quickstart.md       # Setup and validation guide
└── contracts/          # API schemas and validation rules

memory/
└── constitution.md     # Project constitution v1.1.0
```

## Security Requirements
- GitHub native security tools only (CodeQL, Dependabot, Secret scanning)
- Required status checks: build, test, security scans, coverage, linting
- Branch protection with phase-lead approval requirements
- No direct pushes to main branch, PR workflow enforced
- Security-first repository governance with audit logging

## Development Guidelines
- Follow constitutional principles for all implementations
- Maintain YokaKit identity throughout development process
- Reference PinkieIt commits for audit trail maintenance
- Phase-based team permissions with elevated access during assigned phases
- Quality-first approach with automated validation gates

## Recent Context
- **Phase 0 Completed**: GitHub repository infrastructure with constitutional compliance
- **Analysis Documentation**: Comprehensive analysis in `docs/analysis/` with 0% content overlap
- **Strategic Planning**: 4-month implementation roadmap with 85%+ success probability
- **Document Structure**: Responsibility matrix with clear authority separation
- **PinkieIt Pattern Analysis**: 189 commits of proven modernization extracted

## Analysis Documentation Structure
- **Technical Baseline**: Current YokaKit system assessment (93 PHP files, 45 migrations)
- **Strategic Master Plan**: Phase-by-phase implementation strategy with proven patterns
- **Historical Reference**: PinkieIt development timeline with GitHub commit IDs
- **Quality Assurance**: Cross-document validation with 98% accuracy verification

## GitHub Issue Management Structure
- **Label Hierarchy**: Epic → Story → Task → Constitutional (4-layer system)
- **Issue Templates**: Feature request with constitutional compliance fields
- **Milestone Structure**: Phase 0-6 with clear completion criteria
- **Workflow Management**: needs-triage → in-progress → blocked → closed

## Phase 1 Docker Foundation Context

### Implementation Approach
- **PinkieIt Pattern Reference**: commit a5d3b77ad98f34afae9ac7c6cd6be55770a4309c (2024-07-01 Docker foundation)
- **YokaKit Repository Preparation**: GitHub label migration, milestone setup, Epic issue creation
- **Docker Infrastructure**: Single-stage foundation → multi-stage evolution path
- **Development Environment**: DevContainer with hot-reload and quality tools integration
- **Constitutional Compliance**: Automated validation for identity preservation and historical fidelity

### Key Implementation Files
- **Plan**: `specs/002-phase-1-docker/plan.md` - Complete implementation strategy
- **Research**: `specs/002-phase-1-docker/research.md` - Technical decisions and PinkieIt analysis
- **Data Model**: `specs/002-phase-1-docker/data-model.md` - Entity definitions and relationships
- **Contracts**: `specs/002-phase-1-docker/contracts/` - Configuration specifications
- **Quickstart**: `specs/002-phase-1-docker/quickstart.md` - 15-minute developer setup guide

### Docker Environment Structure
```text
YokaKit/                 # Submodule - target for improvements
├── docker/              # NEW: Docker infrastructure
│   ├── php/Dockerfile   # PHP 8.2 + Apache configuration
│   ├── apache/          # Web server configuration
│   └── mariadb/         # Database initialization
├── .devcontainer/       # NEW: VS Code integration
├── docker-compose.yml   # NEW: Development orchestration
└── scripts/validation/  # NEW: Constitutional compliance automation
```

### Constitutional Requirements for Phase 1
- **Identity Preservation**: All containers, volumes, networks use YokaKit naming
- **Historical Fidelity**: Reference PinkieIt commit a5d3b77 for Docker foundation patterns
- **Quality First**: Validation scripts enforce constitutional compliance at each step
- **Sequential Phases**: Complete GitHub setup before technical implementation

### Validation Commands
```bash
# Constitutional compliance check
./scripts/validation/constitutional-compliance.sh

# Docker environment health
./scripts/validation/docker-environment.sh

# Laravel structure validation
./scripts/validation/laravel-structure.sh

# Development quality verification
./scripts/validation/development-quality.sh
```

## Spec Creation Guidelines (CRITICAL - Learned from Phase 1)

### ALWAYS Verify PinkieIt Actual Commit History First

**DO NOT assume** what PinkieIt did based on high-level descriptions. **ALWAYS check actual commits.**

#### Phase 1 Lesson Learned

**Initial Mistake** ❌:
- Assumed "Docker Foundation" meant simple Dockerfile + docker-compose.yml
- Assumed "Model relocation" was app/Http/Requests → app/Models
- Created 48 tasks based on assumptions

**Reality Check** ✅:
```bash
# Check actual PinkieIt commits
cd pinkieit
git log --oneline --reverse a5d3b77..13b40d1

# Discovered:
a5d3b77: Initial Docker (correct assumption)
643414f: Rename YokaKit→PinkieIt (MUST SKIP - constitutional)
fad82e6: app/ → app/laravel/ (MASSIVE - not just models!)
bfd075e: Enhanced docker-compose (networking, healthcheck)
3a0f1cd: Volume refinements
13b40d1: MQTT container addition
```

**Corrected Approach** ✅:
- Analyzed each commit with `git show {hash} --stat`
- Understood actual file changes (200+ files in fad82e6!)
- Created commit-by-commit replay tasks (47 tasks)
- Accurate timeline: 2-3 weeks (not 4 weeks)

### Mandatory Workflow for All Future Phases

#### Step 1: Identify Relevant PinkieIt Commits
```bash
# For Phase 2 (Quality Infrastructure)
cd pinkieit
git log --oneline --grep="test\|quality\|phpunit\|coverage" --reverse

# Or by date range (if known from timeline analysis)
git log --oneline --after="2025-06-13" --before="2025-06-14" --reverse
```

#### Step 2: Analyze Each Commit in Detail
```bash
# For each commit, check what was actually changed
git show {commit_hash} --stat        # File list
git show {commit_hash}               # Full diff
git show {commit_hash}:path/to/file  # Specific file content
```

#### Step 3: Map Commits to Constitutional Requirements
```
FOR EACH COMMIT:
  IF commit renames YokaKit → PinkieIt:
    → SKIP (constitutional requirement III)
  ELSE IF commit adds PinkieIt branding:
    → ADAPT with YokaKit naming
  ELSE:
    → REPLAY with YokaKit identity preserved
```

#### Step 4: Create Commit-Based tasks.md
```markdown
## COMMIT REPLAY 1: {hash} - {description}
**PinkieIt Commit**: `{full_hash}`
**Date**: {date}
**Files Changed**: {count} files

### Tasks
- [ ] T001: Validate {commit changes}
- [ ] T002: Implement {commit changes}
- [ ] T003: Test {commit result}
- [ ] T004: Commit with reference to {hash}
```

#### Step 5: Verify Before Creating GitHub Issues
- [ ] All commits analyzed? (not just first/last)
- [ ] Constitutional skips documented? (643414f, etc.)
- [ ] Naming adaptations planned? (pinkieit → yokakit)
- [ ] File paths accurate? (check actual commit diffs)
- [ ] Dependencies clear? (commit order matters)

### PinkieIt Analysis Commands Reference

```bash
# Get commit sequence for a feature
git log --oneline --grep="keyword" --reverse

# Check commit details
git show {hash} --stat                    # Summary
git show {hash} --name-only               # File list only
git show {hash}                           # Full diff

# Find commits by date
git log --oneline --after="YYYY-MM-DD" --before="YYYY-MM-DD"

# Find commits by file
git log --oneline -- path/to/file

# Check file content at specific commit
git show {hash}:path/to/file
```

### Red Flags (Indicators You Need to Check Commits)

🚩 **Vague descriptions**: "structural improvements", "modernization", "cleanup"
🚩 **Large file counts**: If timeline mentions "200+ files", check what actually changed
🚩 **Multiple related commits**: Sequential commits often refine each other
🚩 **Timeline gaps**: If commits span months, check what happened between
🚩 **Merge commits**: Check the PR commits, not just the merge

### Constitutional Compliance in Spec Creation

#### ALWAYS Document Skipped Commits
```markdown
## COMMIT REPLAY X: {hash} - CONSTITUTIONAL SKIP
**PinkieIt Commit**: `{hash}` - {description}
**Action**: SKIP (Constitutional requirement: {reason})
**No tasks generated for this commit.**
```

#### ALWAYS Adapt Naming
```markdown
## Constitutional Adaptations
- pinkieit → yokakit (all service names)
- PinkieIt → YokaKit (all documentation)
- DB name "yokakit" preserved (if exists in original)
```

## Next Steps
- **Begin Implementation**: Start with Story #20 (CR1: a5d3b77 Docker Foundation)
- **Follow Commits**: Execute tasks in chronological order (CR1 → CR3 → CR4-6 → PV)
- **Validate Continuously**: Constitutional compliance at every commit
- **Document Progress**: Update Epic #1 as stories complete

---
*Updated: 2025-10-02 | Constitution: v1.2.0 | Phase 1 Commit-Based Plan Ready | Lesson: Always Check Actual Commits!*