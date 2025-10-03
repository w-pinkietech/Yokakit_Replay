# Implementation Plan: Phase 2 Docker Architecture Optimization

**Branch**: `003-phase-2-docker` | **Date**: 2025-10-03 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/003-phase-2-docker/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path ✅
   → Spec found and validated with Clarifications section
2. Fill Technical Context ✅
   → Detected Project Type: web (Docker infrastructure optimization)
3. Fill the Constitution Check section ✅
   → Based on constitution v1.2.0 requirements
4. Evaluate Constitution Check section ✅
   → Constitutional compliance verified (1 adaptation commit)
   → Update Progress Tracking: Initial Constitution Check ✅
5. Execute Phase 0 → research.md ✅
   → 4 PinkieIt commits analyzed (b980f1e..08ac389)
6. Execute Phase 1 → contracts, data-model.md, quickstart.md ✅
   → Design artifacts generated
7. Re-evaluate Constitution Check section ✅
   → No new violations detected
   → Update Progress Tracking: Post-Design Constitution Check ✅
8. Plan Phase 2 → Describe task generation approach ✅
9. STOP - Ready for /tasks command ✅
```

**IMPORTANT**: The /plan command STOPS at step 9. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Primary requirement: Optimize YokaKit Docker infrastructure through multi-stage Dockerfile consolidation, BuildKit cache optimization, and architectural streamlining. Technical approach: Replay 4 PinkieIt commits (b980f1e..08ac389) with YokaKit naming adaptations.

## Technical Context
**Language/Version**: Dockerfile (multi-stage), Docker Compose v2
**Primary Dependencies**: Docker BuildKit, PHP 8.2-apache, composer, npm
**Storage**: Docker volumes (existing from Phase 1)
**Testing**: Docker build success, container startup validation
**Target Platform**: Linux containers (Docker)
**Project Type**: web - Docker infrastructure optimization
**Performance Goals**: Build time reduction (BuildKit cache), image size optimization
**Constraints**: Maintain Phase 1 3-container stack (web-app, db, mqtt)
**Scale/Scope**: 4 commits, 4-6 hours implementation

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### I. Historical Fidelity Replay ✅
- **Compliance**: All Docker optimizations follow PinkieIt commits b980f1e..08ac389
- **Evidence**: 4 commit hashes verified, full 40-character references maintained
- **Action**: Commit-by-commit replay (CR1-CR4)

### II. Submodule Synchronization Management ✅
- **Compliance**: YokaKit submodule update planned for Phase 2 completion
- **Evidence**: Constitutional requirement for explicit submodule version updates
- **Action**: Update submodule reference after CR4 completion

### III. Identity Preservation (NON-NEGOTIABLE) ✅
- **Compliance**: YokaKit naming enforced in all Docker configurations
- **Evidence**: f9340aa adaptation documented (pinkieit → yokakit)
- **Action**: 3 specific naming changes (image, containers, network)

### IV. Sequential Modernization Phases ✅
- **Compliance**: Phase 2 follows Phase 1 completion
- **Evidence**: Phase 1 Docker foundation complete (CR1-CR6)
- **Action**: Sequential CR1→CR2→CR3→CR4 execution

### V. Quality-First Implementation ✅
- **Compliance**: Validation at each commit replay
- **Evidence**: Validation criteria in contracts
- **Action**: Constitutional compliance check after each CR

### VI. GitHub Workflow Management ✅
- **Compliance**: Issue tracking for Phase 2
- **Evidence**: GitHub Issue creation planned in tasks
- **Action**: Create Phase 2 Epic issue in YokaKit repository

### VII. Repository Governance ✅
- **Compliance**: Pull request workflow for Phase 2
- **Evidence**: Branch 003-phase-2-docker created
- **Action**: PR to main after Phase 2 completion

### VIII. Project Management Integration ✅
- **Compliance**: Phase 2 milestone tracking
- **Evidence**: specs/003-phase-2-docker/ structure
- **Action**: Track progress in tasks.md

### IX. GitHub Issue Management Hierarchy ✅
- **Compliance**: Phase 2 Epic → Stories (CR1-CR4) → Tasks
- **Evidence**: Commit replay structure documented
- **Action**: Create GitHub Issues per CR

### X. Constitutional Label Requirements ✅
- **Compliance**: constitutional:identity-preservation label required
- **Evidence**: All GitHub Issues for Phase 2 include constitutional labels
- **Action**: Apply labels during Issue creation

## Project Structure

### Documentation (this feature)
```
specs/003-phase-2-docker/
├── plan.md              # This file (/plan command output) ✅
├── spec.md              # Feature specification ✅
├── research.md          # Phase 0 output (/plan command) ✅
├── data-model.md        # Phase 1 output (/plan command) ✅
├── quickstart.md        # Phase 1 output (/plan command) ✅
├── contracts/           # Phase 1 output (/plan command) ✅
│   ├── dockerfile.contract.md
│   ├── compose.contract.md
│   └── dockerignore.contract.md
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (YokaKit repository)
```
YokaKit/
├── Dockerfile           # NEW (multi-stage, consolidates docker/base + docker/app)
├── .dockerignore        # NEW (124 lines, build context optimization)
├── compose.yml          # RENAMED from docker-compose.yml
├── docker/base/         # DEPRECATED (consolidated into Dockerfile)
├── docker/app/          # DEPRECATED (consolidated into Dockerfile)
└── .devcontainer/
    └── docker-compose.extend.yml  # UPDATED (yokakit image references)
```

**Structure Decision**: Docker infrastructure optimization - consolidates Phase 1's docker/base and docker/app into single multi-stage Dockerfile at repository root, following Docker Compose v2 conventions.

## Phase 0: Outline & Research ✅

**Research Complete**: research.md generated with 4 commit analysis

**Decisions Made**:
1. **.dockerignore Strategy**: Direct copy from b980f1e (124 lines, no adaptations)
2. **Multi-Stage Dockerfile**: Consolidate docker/base + docker/app (f9340aa)
3. **BuildKit Cache**: Implement composer/npm cache mounts (fe2acac)
4. **Stage Consolidation**: Simplify to base→build→production (08ac389)

**Alternatives Considered**:
- Keep docker/base + docker/app separate: Rejected (PinkieIt proven consolidation pattern)
- Skip BuildKit cache: Rejected (significant build time improvement)
- Maintain docker-compose.yml name: Rejected (Docker Compose v2 migration)

**Output**: research.md with all technical decisions resolved

## Phase 1: Design & Contracts ✅

**Artifacts Generated**:

1. **data-model.md**: 5 Docker infrastructure entities
   - Multi-Stage Dockerfile (base/build/production stages)
   - .dockerignore Configuration (124 ignore rules)
   - Docker Compose Services (web-app, db, mqtt with YokaKit naming)
   - BuildKit Cache Mounts (composer/npm)
   - DevContainer Configuration (yokakit-dev)

2. **contracts/**: 3 configuration contracts
   - `dockerfile.contract.md`: Multi-stage build specification with YokaKit adaptations
   - `compose.contract.md`: Service orchestration with yokakit naming
   - `dockerignore.contract.md`: Build context optimization rules

3. **quickstart.md**: 30-minute setup guide
   - Enable BuildKit
   - Apply CR1-CR4 changes
   - Constitutional compliance check

**Output**: Complete design documentation ready for task generation

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `.specify/templates/tasks-template.md` as base
- Generate tasks from 4 commit replays (CR1-CR4)
- Each CR: Analyze → Implement → Validate → Commit → (GitHub Issue)
- Constitutional compliance validation at each CR

**Ordering Strategy**:
- Sequential (CR1→CR2→CR3→CR4) - each depends on previous
- CR1: .dockerignore foundation
- CR2: Multi-stage Dockerfile + compose.yml rename + naming adaptations
- CR3: BuildKit cache optimization
- CR4: Final consolidation

**Task Categories**:
1. **CR1 (b980f1e)**: .dockerignore + CLAUDE.md [3-4 tasks]
2. **CR2 (f9340aa)**: Dockerfile + compose.yml + naming [5-6 tasks]
3. **CR3 (fe2acac)**: BuildKit cache mounts [3-4 tasks]
4. **CR4 (08ac389)**: Final consolidation [3-4 tasks]
5. **Validation**: Constitutional compliance, cleanup [2-3 tasks]

**Estimated Output**: 16-21 numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)
**Phase 4**: Implementation (execute tasks.md following constitutional principles)
**Phase 5**: Validation (build success, services operational, constitutional compliance)

Implementation follows constitutional requirements:
- YokaKit identity preservation (pinkieit → yokakit adaptations)
- PinkieIt commit hash references for audit trail
- Quality-first validation at each CR
- Submodule synchronization at phase completion

## Complexity Tracking
*No constitutional violations requiring justification*

All Docker optimizations align with constitutional requirements. Multi-stage consolidation simplifies rather than complicates infrastructure.

## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning approach described (/plan command)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved (Clarifications Session 2025-10-03)
- [x] Complexity deviations documented (none required)

---
*Based on Constitution v1.2.0 - See `/memory/constitution.md`*
