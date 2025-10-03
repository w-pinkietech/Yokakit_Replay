# Feature Specification: Phase 2 Docker Architecture Optimization

**Feature Branch**: `003-phase-2-docker`
**Created**: 2025-10-03
**Status**: Draft
**Input**: User description: "Phase 2: b980f1e..08ac389 - Docker Architecture Optimization - Multi-stage Dockerfile consolidation, BuildKit cache optimization, and production-ready Docker architecture based on PinkieIt proven patterns"

## Execution Flow (main)
```text
1. Parse PinkieIt commit range from Input
   → Range: b980f1e..08ac389 (4 commits)
2. Analyze each commit for technical changes
   → Identify: files changed, purpose, YokaKit adaptations
3. Identify constitutional issues:
   → Rename commits: SKIP
   → Branding commits: ADAPT with YokaKit naming
4. Extract user scenarios from commit deliverables
   → Developer workflow improvements
5. Generate functional requirements from commits
   → Each requirement maps to commit deliverable
6. Identify key entities (Docker infrastructure)
7. Run constitutional compliance check
   → Verify: Identity preservation, historical fidelity
8. Return: SUCCESS (spec ready for planning)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

### Section Requirements
- **Mandatory sections**: Must be completed for every feature
- **Optional sections**: Include only when relevant to the feature
- When a section doesn't apply, remove it entirely (don't leave as "N/A")

### For AI Generation
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question] for any assumption you'd need to make
2. **Don't guess**: If the prompt doesn't specify something (e.g., "login system" without auth method), mark it
3. **Think like a tester**: Every vague requirement should fail the "testable and unambiguous" checklist item
4. **Common underspecified areas**:
   - User types and permissions
   - Data retention/deletion policies
   - Performance targets and scale
   - Error handling behaviors
   - Integration requirements
   - Security/compliance needs

---

## User Scenarios & Testing *(mandatory)*

### Primary User Story
As a YokaKit developer, I need optimized Docker build and deployment infrastructure so that development iterations are faster and production deployments are more efficient, following proven patterns from PinkieIt's Docker optimization phase.

### Acceptance Scenarios
1. **Given** Phase 1 Docker foundation (docker/base + docker/app structure), **When** Phase 2 optimization is applied, **Then** a single multi-stage Dockerfile consolidates all build logic
2. **Given** repeated Docker builds during development, **When** BuildKit cache mounts are enabled, **Then** dependency installation (composer, npm) reuses cached layers reducing build time
3. **Given** production deployment requirements, **When** multi-stage build completes, **Then** final image contains only runtime dependencies without build tools
4. **Given** Docker build context with source code, **When** .dockerignore is applied, **Then** unnecessary files (tests, docs, IDE configs) are excluded from build context
5. **Given** docker-compose.yml configuration, **When** renamed to compose.yml, **Then** follows Docker Compose v2 naming conventions

### Edge Cases
- What happens when BuildKit is not enabled in Docker daemon?
- How does the system handle missing docker/base or docker/app directories during consolidation?
- What occurs when YokaKit naming conflicts with PinkieIt references in consolidated Dockerfile?

## Requirements *(mandatory)*

### Functional Requirements

**From Commit b980f1e (Docker Build Context Optimization)**:
- **FR-001**: System MUST provide .dockerignore file with 124 comprehensive ignore rules to exclude unnecessary files from Docker build context
- **FR-002**: System MUST exclude development files (node_modules, tests, IDE configs, logs) from Docker image builds
- **FR-003**: System MUST reduce build context size by ignoring Git files, temporary files, and OS-specific files

**From Commit f9340aa (Multi-Stage Dockerfile Consolidation)**:
- **FR-004**: System MUST consolidate docker/base/Dockerfile and docker/app configuration into single multi-stage Dockerfile
- **FR-005**: System MUST implement base stage with PHP 8.2-apache foundation
- **FR-006**: System MUST implement build stage for asset compilation and dependency installation
- **FR-007**: System MUST implement production stage with optimized runtime and compiled assets
- **FR-008**: System MUST rename docker-compose.yml to compose.yml following Docker Compose v2 conventions
- **FR-009**: System MUST preserve YokaKit naming in all Docker configurations (yokakit-web-app, yokakit-dev containers)

**From Commit fe2acac (Build Cache Optimization)**:
- **FR-010**: System MUST implement BuildKit cache mounts for composer dependency installation
- **FR-011**: System MUST implement BuildKit cache mounts for npm dependency installation
- **FR-012**: System MUST separate dependency installation into dedicated stages for improved layer caching
- **FR-013**: System MUST distinguish between development and production build stages

**From Commit 08ac389 (Final Consolidation)**:
- **FR-014**: System MUST simplify multi-stage structure by removing redundant stages
- **FR-015**: System MUST optimize layer ordering for better Docker build caching
- **FR-016**: System MUST produce production-ready Docker image with minimal size and optimal performance
- **FR-017**: System MUST maintain compatibility with existing services (web-app, db, mqtt) from Phase 1

**Constitutional Requirements**:
- **FR-018**: System MUST replace all "PinkieIt" references with "YokaKit" in Dockerfile comments
- **FR-019**: System MUST use "yokakit" prefix for all image and container names
- **FR-020**: System MUST preserve YokaKit identity throughout Docker configuration

### Key Entities *(include if feature involves data)*

- **Multi-Stage Dockerfile**: Consolidated build configuration containing base, build, and production stages with YokaKit-specific naming
- **.dockerignore**: Build context exclusion rules file (124 lines) preventing unnecessary files from entering Docker build
- **compose.yml**: Docker Compose v2 configuration file (renamed from docker-compose.yml) orchestrating yokakit-web-app, yokakit-db, yokakit-mqtt services
- **BuildKit Cache Mounts**: Docker BuildKit feature for persistent caching of composer and npm dependencies across builds
- **Docker Build Stages**: Separated stages for base runtime (PHP 8.2-apache), dependency build (composer/npm), and production image
- **YokaKit Docker Services**: Renamed containers (yokakit-web-app, yokakit-dev) maintaining constitutional identity preservation

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [x] No implementation details beyond commit-level descriptions
- [x] Focused on Docker optimization value and efficiency gains
- [x] Written for technical stakeholders understanding PinkieIt replay
- [x] All mandatory sections completed

### Requirement Completeness
- [x] No [NEEDS CLARIFICATION] markers (all commits verified)
- [x] Requirements are testable against commit deliverables
- [x] Success criteria are measurable (file counts, build time reduction)
- [x] Scope is clearly bounded (4 commits, 1 day)
- [x] Dependencies identified (Phase 1 Docker foundation)

### Constitutional Compliance
- [x] Identity Preservation: YokaKit naming documented for f9340aa
- [x] Historical Fidelity: All 4 commits from PinkieIt verified
- [x] Audit Trail: Full commit hashes (40 characters) referenced
- [x] No rename commits in range (no skips required)

---

## Execution Status
*Updated by main() during processing*

- [x] PinkieIt commit range parsed (b980f1e..08ac389)
- [x] 4 commits analyzed with git show
- [x] Constitutional adaptations identified (1 commit: f9340aa)
- [x] User scenarios defined from developer workflow
- [x] Requirements generated from commit deliverables
- [x] Docker infrastructure entities identified
- [x] Review checklist passed

---

## YokaKit_Replay Extensions (Commit-Based Replay)

### PinkieIt Commit Range
**Start**: `b980f1eef1c628962186f7e18012c1330a55b579` (2025-06-26 19:47:40)
**End**: `08ac3897e478078d254e1ca54c8f244216d1862b` (2025-06-26 21:55:57)
**Total Commits**: 4
**Estimated Duration**: 1 day (based on commit timestamps)

### PinkieIt Commit References

#### Commit 1: b980f1e
**Message**: Phase 1: Docker baseline metrics and optimization foundation
**Files**: .dockerignore (124 lines), CLAUDE.md (38 lines)
**Constitutional**: No PinkieIt references, direct replay

#### Commit 2: f9340aa
**Message**: Phase 2: Consolidate Docker architecture with multi-stage Dockerfile
**Files**: Dockerfile (129 lines), compose.yml (renamed), .devcontainer/docker-compose.extend.yml
**Constitutional**: **ADAPT** - pinkieit-web-app → yokakit-web-app, "PinkieIt" → "YokaKit" in comments

#### Commit 3: fe2acac
**Message**: Phase 2: Optimize Dockerfile with build stage separation and cache mounts
**Files**: Dockerfile (166 lines), ProductionLineFactory.php
**Constitutional**: Maintain YokaKit naming from commit 2

#### Commit 4: 08ac389
**Message**: Phase 2: Complete Docker optimization with multi-stage consolidation
**Files**: Dockerfile (96 lines), compose.yml
**Constitutional**: Maintain YokaKit naming

### Constitutional Compliance Verification

#### Commit Range Verification
- ✅ All 4 commits verified against PinkieIt git log (b980f1e, f9340aa, fe2acac, 08ac389)
- ✅ Commit hashes are full 40-character format
- ✅ Commit dates accurate (2025-06-26, 19:47-21:55)
- ✅ Commit sequence matches chronological order

#### Constitutional Adaptations
- ✅ 0 rename commits (no identity-changing commits)
- ✅ 1 adaptation commit documented (f9340aa) with specific changes
- ✅ PinkieIt references identified: Dockerfile comment, image/container names
- ✅ All adaptations include file paths (Dockerfile, compose.yml, .devcontainer/docker-compose.extend.yml)

#### YokaKit Naming Adaptations
- ✅ f9340aa: Specific adaptations documented
  - Dockerfile comment: "PinkieIt" → "YokaKit"
  - Image name: pinkieit-web-app → yokakit-web-app
  - Container names: pinkieit-dev/pinkieit-web-app → yokakit-dev/yokakit-web-app
- ✅ fe2acac: Maintain YokaKit naming from f9340aa (no new PinkieIt references)
- ✅ 08ac389: Maintain YokaKit naming (references existing naming)
- ✅ b980f1e: No PinkieIt/YokaKit adaptations needed (CLAUDE.md update only)

#### Scope Boundaries
- ✅ All 4 commits logically belong to Docker optimization phase
- ✅ b980f1e: Phase 1 baseline (sets foundation for Phase 2)
- ✅ f9340aa, fe2acac, 08ac389: Phase 2 Docker consolidation and optimization
- ✅ No dependency commits from future phases detected
- ✅ Commit sequence: baseline → consolidation → optimization → finalization

### Implementation Readiness
- [x] All commits verified
- [x] Constitutional strategy confirmed
- [x] Adaptations clarified
- [x] Scope boundaries clear
- [x] Ready for /plan

### Next Steps
1. ~~Run `/clarify` to verify commit range accuracy and constitutional compliance~~ ✅ Complete
2. Run `/plan` to generate commit-based implementation plan with technical context
3. Run `/tasks` to create commit-by-commit task breakdown (expected: ~12-16 tasks for 4 commits)

**Constitution Version**: v1.2.0
**Phase Dependencies**: Phase 1 (CR1-CR6) Docker Foundation
