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
│   ├── 002-phase-1-docker/
│   └── 003-phase-2-docker/  # Current: Phase 2 planning
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

## Current Status: Phase 2 Docker Architecture Optimization - PLANNING COMPLETE ✅

### Phase 0 Completion Status ✅
- **CodeQL Submodule Exclusion**: ✅ YokaKit and pinkieit submodules excluded from analysis
- **Workflow Dependency Removal**: ✅ Laravel/PHP dependencies made optional for Phase 0
- **Infrastructure Validation**: ✅ All workflows execute without Phase 1 dependencies
- **Constitutional Compliance**: ✅ YokaKit identity preserved, audit trail maintained
- **Submodule Management**: ✅ Absolute GitHub URLs configured, .gitmodules fixed

### Phase 1 Completion Status ✅
- **GitHub Management Setup**: ✅ Label migration, milestone structure, Epic issue creation
- **Docker Foundation**: ✅ PHP 8.2 + Apache + MariaDB containerization (PinkieIt a5d3b77 pattern)
- **Application Structure**: ✅ app/ → app/laravel/ reorganization (200+ files, PinkieIt fad82e6)
- **Docker Refinement**: ✅ MQTT container, networking, healthcheck optimization (PinkieIt bfd075e, 3a0f1cd, 13b40d1)
- **Note**: DevContainer deferred to Phase 4 (PinkieIt commit 0cc0475, 2025-02-20)

### Phase 2 Implementation Plan ✅
- **Spec Generation**: ✅ spec.md with 4 PinkieIt commits (b980f1e..08ac389)
- **Planning**: ✅ plan.md, research.md, data-model.md, contracts/, quickstart.md
- **Task Breakdown**: ✅ tasks.md with 24 commit-based tasks (CR1-CR4)
- **Multi-Stage Dockerfile**: 📋 Consolidation of docker/base + docker/app
- **BuildKit Optimization**: 📋 Cache mounts for composer and npm
- **Docker Compose v2**: 📋 Migration to compose.yml naming
- **Constitutional Compliance**: 📋 pinkieit → yokakit adaptations (CR2)

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
- **Phase 1**: Docker Foundation ✅ COMPLETED
- **Phase 2**: Docker Architecture Optimization (4-6 hours) 📋 PLANNING COMPLETE
- **Phase 3**: Comprehensive Testing (2 weeks)
- **Phase 4**: DevContainer & Framework Modernization (1-2 weeks)
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

.specify/memory/
└── pinkieit-commit-pr-history.md      # Complete PinkieIt commit/PR history (277 commits, 35 PRs)

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
- **Phase 1 Completed**: Docker Foundation & Development Environment with commit-based replay
- **Phase 2 Planning Complete**: Docker Architecture Optimization (4 commits, 24 tasks)
- **Analysis Documentation**: Comprehensive analysis in `docs/analysis/` with 0% content overlap
- **Strategic Planning**: 4-month implementation roadmap with 85%+ success probability
- **Document Structure**: Responsibility matrix with clear authority separation
- **PinkieIt Pattern Analysis**: 189 commits of proven modernization extracted
- **Commit-Based Workflow**: Learned to verify actual commits before planning (Phase 1 lesson)

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

## Phase 2 Docker Architecture Optimization Context

### Implementation Approach
- **PinkieIt Pattern Reference**: 4 commits (b980f1e..08ac389) from 2025-06-26
- **Commit Replay Strategy**: CR1 → CR2 → CR3 → CR4 (sequential execution required)
- **Multi-Stage Consolidation**: docker/base + docker/app → single Dockerfile
- **BuildKit Optimization**: Cache mounts for composer and npm dependencies
- **Constitutional Compliance**: pinkieit → yokakit naming adaptations (CR2)

### Key Implementation Files
- **Spec**: `specs/003-phase-2-docker/spec.md` - 4 commits with constitutional clarifications
- **Plan**: `specs/003-phase-2-docker/plan.md` - Commit-by-commit implementation strategy
- **Research**: `specs/003-phase-2-docker/research.md` - Detailed commit analysis (4 commits)
- **Data Model**: `specs/003-phase-2-docker/data-model.md` - Docker infrastructure entities
- **Contracts**: `specs/003-phase-2-docker/contracts/` - Dockerfile, compose.yml, .dockerignore contracts
- **Tasks**: `specs/003-phase-2-docker/tasks.md` - 24 tasks across 4 commit replays

### Docker Architecture Evolution
```text
YokaKit/                 # Submodule - target for improvements
├── Dockerfile           # NEW: Multi-stage (base → build → production)
├── .dockerignore        # NEW: 124 lines, build context optimization
├── compose.yml          # RENAMED: from docker-compose.yml (Docker Compose v2)
├── .devcontainer/
│   └── docker-compose.extend.yml  # UPDATED: yokakit-web-app image reference
└── docker/              # DEPRECATED: Consolidated into root Dockerfile
    ├── base/            # (content moved to Dockerfile)
    └── app/             # (content moved to Dockerfile)
```

### Commit Replay Structure
- **CR1** (b980f1e): .dockerignore + CLAUDE.md (5 tasks)
- **CR2** (f9340aa): Multi-stage Dockerfile + compose.yml + naming (8 tasks)
- **CR3** (fe2acac): BuildKit cache mounts (6 tasks)
- **CR4** (08ac389): Final consolidation (5 tasks)

### Constitutional Requirements for Phase 2
- **Identity Preservation**: yokakit-web-app (NOT pinkieit-web-app) in all Docker configs
- **Historical Fidelity**: All 4 commits reference full PinkieIt hashes (40-char)
- **Naming Adaptations**: CR2 requires pinkieit → yokakit changes (Dockerfile, compose.yml, devcontainer)
- **BuildKit Requirement**: DOCKER_BUILDKIT=1 environment variable for CR3-CR4

### Validation Commands
```bash
# BuildKit requirement
export DOCKER_BUILDKIT=1

# Build multi-stage Dockerfile
docker build -t yokakit-web-app .

# Constitutional compliance check
grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules
# Expected: No results

# Service startup test
docker compose up -d
docker compose ps | grep "Up"
# Expected: All services healthy
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
# Quick reference: Check complete commit/PR history first
cat .specify/memory/pinkieit-commit-pr-history.md

# Then analyze specific commits in pinkieit submodule
cd pinkieit

# For Phase 2 (Quality Infrastructure)
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
- **Phase 2 Implementation**: Execute tasks.md (24 tasks across CR1-CR4)
- **Start with T001**: CR1 Analysis (b980f1e - Docker baseline)
- **Sequential Execution**: CR1 (T001-T005) → CR2 (T006-T013) → CR3 (T014-T019) → CR4 (T020-T024)
- **BuildKit Required**: Enable DOCKER_BUILDKIT=1 for CR3-CR4
- **Constitutional Validation**: Zero pinkieit references after CR2 completion
- **GitHub Issues**: Create Epic and Stories in YokaKit repository
- **Submodule Update**: After Phase 2 completion, update YokaKit_Replay submodule reference

---
*Updated: 2025-10-03 | Constitution: v1.2.0 | Phase 2 Planning Complete (4 commits, 24 tasks) | Ready for Implementation*