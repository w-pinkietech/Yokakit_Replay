# Implementation Plan: Phase 4 - Framework Modernization & DevContainer

**Branch**: `005-phase-4-e0eaabd` | **Date**: 2025-10-04 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `specs/005-phase-4-e0eaabd/spec.md`

## Execution Flow (/plan command scope)

```
1. ✅ Load feature spec from Input path
   → spec.md loaded successfully
2. ✅ Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Project Type: Laravel web application (backend + frontend)
   → Structure Decision: YokaKit submodule-based development
3. ✅ Fill the Constitution Check section based on the content of the constitution document
   → Constitution v1.2.0 loaded from memory/constitution.md
4. ✅ Evaluate Constitution Check section
   → No violations detected
   → Progress Tracking updated: Initial Constitution Check PASS
5. ✅ Execute Phase 0 → research.md
   → research.md generated (8 primary commits analyzed)
6. ✅ Execute Phase 1 → contracts, data-model.md, quickstart.md
   → data-model.md generated (13 entities + 2 schema changes)
   → contracts/ generated (3 contracts: devcontainer, composer, reverb)
   → quickstart.md generated (15-minute setup guide)
7. ✅ Re-evaluate Constitution Check section
   → No new violations
   → Progress Tracking updated: Post-Design Constitution Check PASS
8. ✅ Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
   → Task generation strategy documented below
9. ✅ STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 9. Phase 2 is executed by /tasks command:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

---

## Summary

Phase 4 modernizes YokaKit's framework infrastructure and establishes comprehensive DevContainer development environment through systematic PHP and Laravel upgrades, WebSocket modernization with Laravel Reverb, and VS Code DevContainer integration. This phase implements the transition from legacy framework versions (Laravel 9.19, PHP 8.0) to modern, actively-supported infrastructure (Laravel 10.x, PHP 8.2) while maintaining full application functionality.

**PinkieIt Commits**: `0cc0475..cdd8d6f` (DevContainer + Framework Modernization)
**Commits to Replay**: 8 primary commits (3 DevContainer unified + 5 framework modernization)
**Estimated Duration**: 1-2 weeks (based on PinkieIt: DevContainer Feb 2025, Framework upgrades June 2025)

**Two-Phase Implementation Strategy**:
- **Phase 4A**: DevContainer Complete Environment (unified implementation from 0cc0475 + 65eea6a + cdd8d6f)
- **Phase 4B**: Framework Modernization (e0eaabd → 4152b54 → 862d537 → d4db04f → 524c1c3)

**Rationale**: DevContainer provides stable development environment before framework upgrades, ensuring consistent testing and validation across all developers and CI/CD.

---

## Technical Context

**Language/Version**: PHP 8.2.0+ (upgraded from 8.1), JavaScript ES6+ (Laravel Mix/Vite)
**Primary Dependencies**:
- Laravel Framework 10.48.29+ (from 9.19)
- Laravel Sanctum 3.2+ (from 2.14)
- Laravel Reverb 1.4+ (replaces beyondcode/laravel-websockets)
- AdminLTE 3.15+ (from 3.8)
- PHPUnit 10.0+ (from 9.5)
- Larastan 2.0+ (from nunomaduro/larastan)

**Storage**: MariaDB 10.11.4 with Eloquent ORM
**Testing**: PHPUnit 10 with ParaTest parallel execution (Phase 3: 425 tests)
**Target Platform**: Docker containers (multi-stage Dockerfile, Linux-based)
**Project Type**: Web application (Laravel backend + Blade frontend, IoT MQTT integration)
**Performance Goals**:
- Test suite: ~66% faster with parallel execution (established in Phase 3)
- DevContainer startup: <5 minutes (40+ extensions install)
- Application response: <200ms p95 (maintained from Phase 3)

**Constraints**:
- Constitutional compliance: YokaKit naming preserved throughout
- Test suite regression: 0 failures (425/425 tests from Phase 3 baseline)
- Framework compatibility: Laravel 9 → 10 migration without breaking changes
- WebSocket compatibility: Pusher protocol maintained for frontend

**Scale/Scope**:
- Application: 93 PHP files, 45 database migrations (from Phase 0 analysis)
- Test suite: 425 tests (5 models, 8 services, 13 feature tests from Phase 3)
- DevContainer: 40+ VS Code extensions, 4 lifecycle commands
- Framework upgrade: 6 major package versions (PHP, Laravel, Sanctum, PHPUnit, Reverb)

**PinkieIt Reference**: Commits 0cc0475..cdd8d6f (8 primary commits)
**Constitutional Requirements**: Identity preservation + YokaKit branding adaptations

---

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Constitutional Principles** (from Constitution v1.2.0):

- [x] **Identity Preservation (NON-NEGOTIABLE)**: YokaKit naming maintained
  - ✅ DevContainer: "YokaKit Development" (not "PinkieIt Development")
  - ✅ Database: "yokakit" (preserved from original)
  - ✅ Docker containers: yokakit-dev (not pinkieit-dev)
  - ✅ SonarLint project key: YokaKit-specific configuration
  - ✅ No PinkieIt branding in any configuration files

- [x] **Historical Fidelity**: PinkieIt improvements extracted incrementally
  - ✅ 8 primary commits analyzed with full 40-character hashes
  - ✅ Unified implementation strategy: 3 DevContainer commits merged (rationale documented)
  - ✅ Framework upgrades: Sequential PHP 8.2 → Laravel 10 → Reverb migration
  - ✅ All commit references maintained for audit trail

- [x] **Sequential Phases**: Phase order respected
  - ✅ Phase 0: GitHub infrastructure ✅ COMPLETED
  - ✅ Phase 1: Docker Foundation ✅ COMPLETED
  - ✅ Phase 2: Docker Architecture Optimization ✅ COMPLETED
  - ✅ Phase 3: Comprehensive Testing (425/425 tests) ✅ COMPLETED
  - ✅ Phase 4: DevContainer-first (4A) → Framework upgrades (4B)

- [x] **Audit Trail**: Commit references maintained
  - ✅ research.md: All 8 commits with full hashes documented
  - ✅ Unified implementation: 3 DevContainer commit hashes preserved (0cc0475, 65eea6a, cdd8d6f)
  - ✅ Constitutional adaptations: pinkieit → yokakit documented for each commit

- [x] **Complexity Bounds**: Appropriate for phase
  - ✅ DevContainer unified implementation: Justified by YokaKit Phase 2 completion
  - ✅ Framework upgrades: Sequential with test validation (PinkieIt achieved 100% pass rate)
  - ✅ No unnecessary intermediate states (unified DevContainer from day one)

**Violations**: None

**Unified Implementation Justification**:
- PinkieIt had 3 DevContainer commits (Feb → June 2025) due to evolving Docker infrastructure
- YokaKit Phase 2 Docker already complete (consolidated Dockerfile, multi-stage builds)
- Implementing final DevContainer form directly avoids unnecessary intermediate states
- All 3 source commit hashes documented for audit trail (0cc0475, 65eea6a, cdd8d6f)

---

## Project Structure

### Documentation (this feature)
```
specs/005-phase-4-e0eaabd/
├── spec.md              # Feature specification (/specify output)
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command - 8 commits analyzed)
├── data-model.md        # Phase 1 output (/plan command - 13 entities)
├── quickstart.md        # Phase 1 output (/plan command - 15-minute setup)
├── contracts/           # Phase 1 output (/plan command - 3 contracts)
│   ├── devcontainer.contract.md
│   ├── composer.contract.md
│   └── reverb.contract.md
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (YokaKit submodule)

**Structure Decision**: YokaKit operates as independent GitHub repository, referenced as Git submodule in YokaKit_Replay for coordination.

```
YokaKit/  (Git submodule - actual development target)
├── .devcontainer/                    # NEW: Phase 4A
│   ├── devcontainer.json             # VS Code DevContainer config (YokaKit Development)
│   ├── compose.override.yml          # Separate 'dev' service (port 18081)
│   └── post-create.sh                # Setup automation script
├── app/laravel/                      # Laravel application (from Phase 1)
│   ├── app/
│   │   ├── Models/
│   │   ├── Http/Controllers/
│   │   ├── Services/
│   │   └── Logging/CustomizeFormatter.php  # MODIFIED: Monolog 3.x compatibility
│   ├── config/
│   │   ├── broadcasting.php          # MODIFIED: Add 'reverb' connection
│   │   ├── reverb.php                # NEW: Laravel Reverb configuration
│   │   └── websockets.php            # DELETED: Legacy WebSockets removed
│   ├── database/migrations/
│   │   ├── 2025_06_17_add_expires_at_to_personal_access_tokens.php  # NEW: Sanctum 3.x
│   │   └── *_create_websockets_statistics_entries_table.php  # DELETED: Legacy
│   ├── composer.json                 # MODIFIED: PHP 8.2, Laravel 10, Reverb
│   ├── composer.lock                 # MODIFIED: Full dependency update
│   ├── phpunit.xml                   # MODIFIED: PHPUnit 10.5 schema
│   └── tests/                        # MODIFIED: Laravel 10 test fixes
│       ├── Unit/
│       ├── Feature/
│       └── Browser/
├── Dockerfile                        # From Phase 2 (multi-stage consolidated)
├── compose.yml                       # From Phase 2 (Docker Compose v2)
├── .env.example                      # MODIFIED: Add REVERB_* variables
└── CLAUDE.md                         # MODIFIED: PHP 8.2, Laravel 10 docs

YokaKit_Replay/  (Meta-repository - planning & orchestration)
├── specs/005-phase-4-e0eaabd/        # This implementation plan
├── memory/constitution.md            # Constitutional requirements v1.2.0
├── YokaKit/                          # Submodule reference (development target)
└── pinkieit/                         # Submodule reference (pattern source)
```

**Key Changes from Phase 3**:
- **NEW**: `.devcontainer/` directory with complete VS Code setup
- **MODIFIED**: `composer.json` - PHP 8.2, Laravel 10, Reverb dependencies
- **NEW**: `config/reverb.php` - Laravel Reverb server configuration
- **MODIFIED**: `config/broadcasting.php` - Add Reverb connection
- **DELETED**: `config/websockets.php` - Legacy WebSockets removed
- **NEW**: Database migration for Sanctum 3.x (expires_at column)
- **DELETED**: WebSockets statistics migration
- **MODIFIED**: `app/Logging/CustomizeFormatter.php` - Monolog 3.x compatibility
- **MODIFIED**: `phpunit.xml` - PHPUnit 10.5 schema
- **MODIFIED**: Test files - Laravel 10 compatibility fixes

---

## Phase 0: Outline & Research

**Status**: ✅ Complete (research.md generated)

**Key Findings** (from research.md):

1. **DevContainer Unified Implementation**:
   - PinkieIt: 3 commits over 4 months (0cc0475, 65eea6a, cdd8d6f)
   - YokaKit: Single unified implementation (final evolved form)
   - Rationale: Phase 2 Docker already complete, no intermediate states needed

2. **Framework Upgrade Path**:
   - PHP 8.2 first (enables Laravel 10 requirement)
   - Laravel 10 initial upgrade (accept test failures)
   - Laravel 10 completion (fix all tests, 100% pass rate)
   - Laravel Reverb installation (modern WebSocket)
   - Legacy WebSockets removal (clean migration)

3. **Technology Decisions**:
   - VS Code DevContainer: 40+ Laravel development extensions
   - PHP 8.2: Larastan package migration (nunomaduro/larastan → larastan/larastan)
   - Laravel 10: Sanctum 3.x, PHPUnit 10, AdminLTE 3.15
   - Laravel Reverb: Pusher protocol compatibility (frontend unchanged)

4. **Risk Assessment**:
   - Low risk: PHP 8.2 upgrade (Docker image already php:8.2.27)
   - Medium risk: Laravel 10 upgrade (PinkieIt achieved 100% test pass rate)
   - Low risk: Reverb migration (Pusher protocol maintains frontend compatibility)
   - Low risk: DevContainer complexity (extensions optional, core works without all)

**Output**: research.md with all technical context resolved

---

## Phase 1: Design & Contracts

**Status**: ✅ Complete (data-model.md, contracts/, quickstart.md generated)

**Entities Identified**: 13 configuration entities + 2 database schema changes

**Configuration Entities**:
1. DevContainer Configuration (devcontainer.json)
2. VS Code Extensions Configuration (40+ extensions)
3. DevContainer Service Configuration (compose.override.yml)
4. SQL Tools Database Connection (YokaKit Database)
5. PHP Dependencies (composer.json upgrades)
6. Laravel Reverb Configuration (config/reverb.php)
7. Broadcasting Configuration (config/broadcasting.php)
8. DevContainer Lifecycle Commands (4 hooks)
9. DevContainer Features (GitHub CLI, Docker, Zsh)
10. GitHub Codespaces Configuration
11. PHPUnit Configuration (PHPUnit 10 schema)
12. Monolog 3.x Formatter Compatibility
13. Removed: Legacy WebSockets Configuration

**Database Schema Changes**:
1. Add `expires_at` column to `personal_access_tokens` (Sanctum 3.x requirement)
2. Remove WebSockets statistics table (legacy cleanup)

**Contracts Defined**: 3 contracts in contracts/

1. **devcontainer.contract.md**: Complete DevContainer configuration validation
   - DevContainer JSON: name, service, ports, extensions
   - VS Code Settings: PHP 8.2, Laravel base URL, SonarLint, SQL Tools
   - Lifecycle Commands: YokaKit naming adaptations
   - Compose Override: yokakit-dev service, port 18081
   - Constitutional adaptations: pinkieit → yokakit throughout

2. **composer.contract.md**: Framework upgrade dependency validation
   - PHP 8.2 upgrade: composer.json requirements
   - Laravel 10 upgrade: framework packages (Laravel, Sanctum, UI, Dusk)
   - AdminLTE upgrade: 3.8 → 3.15
   - Laravel Reverb installation: laravel/reverb ^1.4
   - Legacy removal: beyondcode/laravel-websockets, pusher/pusher-php-server

3. **reverb.contract.md**: WebSocket modernization validation
   - Reverb server configuration: config/reverb.php (93 lines)
   - Broadcasting configuration: 'reverb' connection
   - Environment variables: REVERB_APP_KEY, REVERB_APP_SECRET, REVERB_APP_ID
   - Pusher protocol compatibility verification
   - Legacy cleanup: config/websockets.php deleted

**Quickstart**: 15-minute setup guide validated

1. Clone and setup (2 min)
2. Environment configuration (3 min) - Add Reverb credentials
3. DevContainer setup (5 min) - VS Code or DevContainers CLI
4. Framework upgrades (5 min) - composer update, migrations, tests
5. Reverb WebSocket setup (optional, 2 min) - Start Reverb server

**Output**: data-model.md, contracts/*, quickstart.md

---

## Phase 2: Task Planning Approach

*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:

**Commit-Based Replay with Unified Implementation**:

### Phase 4A: DevContainer Complete Environment
**Story**: Unified DevContainer Implementation (0cc0475 + 65eea6a + cdd8d6f)
- **Tasks** (estimated 8-10 tasks):
  1. Validate PinkieIt DevContainer commits (0cc0475, 65eea6a, cdd8d6f)
  2. Create `.devcontainer/devcontainer.json` with YokaKit naming
  3. Create `.devcontainer/compose.override.yml` with yokakit-dev service
  4. Create `.devcontainer/post-create.sh` setup script
  5. Configure VS Code extensions (40+ extensions)
  6. Configure VS Code settings (PHP 8.2, Laravel, SonarLint, SQL Tools)
  7. Configure lifecycle commands (initializeCommand with yokakit input)
  8. Test DevContainer in VS Code (verify all extensions install)
  9. Test DevContainer with DevContainers CLI (alternative validation)
  10. Commit with reference to PinkieIt hashes (0cc0475, 65eea6a, cdd8d6f)

### Phase 4B: Framework Modernization
**Sequential Commit Replays** (5 stories):

#### Story 1: PHP 8.2 Upgrade (e0eaabd)
- **Tasks** (estimated 4-5 tasks):
  1. Validate PinkieIt commit e0eaabd
  2. Update `composer.json` PHP requirement to ^8.2.0
  3. Replace nunomaduro/larastan with larastan/larastan
  4. Run `composer update` and resolve dependencies
  5. Run test suite (425 tests, expect all passing)
  6. Update CI/CD workflow PHP version
  7. Commit with reference to e0eaabd

#### Story 2: Laravel 10 Initial Upgrade (4152b54)
- **Tasks** (estimated 6-7 tasks):
  1. Validate PinkieIt commit 4152b54
  2. Update `composer.json` Laravel packages (framework, sanctum, ui, dusk)
  3. Update PHPUnit to ^10.0, Collision to ^7.0, Ignition to ^2.0
  4. Run `composer update` and resolve dependencies
  5. Migrate `phpunit.xml` to PHPUnit 10.5 schema
  6. Update `app/Logging/CustomizeFormatter.php` for Monolog 3.x
  7. Add `.phpunit.cache/` to `.gitignore`
  8. Run test suite (expect ~95% passing, CSRF issues expected)
  9. Commit with reference to 4152b54

#### Story 3: Laravel 10 Completion (862d537)
- **Tasks** (estimated 5-6 tasks):
  1. Validate PinkieIt commit 862d537
  2. Update AdminLTE to ^3.15
  3. Create Sanctum 3.x migration (add expires_at column)
  4. Fix AdminLTE datatable component (datatable-index.blade.php)
  5. Add CSRF middleware bypass to test files (BaseControllerTest, etc.)
  6. Fix Laravel 10 compatibility tests (environment-specific assertions)
  7. Run test suite (expect 100% passing, 425/425 tests)
  8. Commit with reference to 862d537

#### Story 4: Laravel Reverb Installation (d4db04f)
- **Tasks** (estimated 5-6 tasks):
  1. Validate PinkieIt commit d4db04f
  2. Add `laravel/reverb` ^1.4 to `composer.json`
  3. Run `composer update` and install Reverb
  4. Publish Reverb configuration (`config/reverb.php`)
  5. Add Reverb connection to `config/broadcasting.php`
  6. Configure environment variables (REVERB_APP_KEY, REVERB_APP_SECRET, REVERB_APP_ID)
  7. Test Reverb server startup (`php artisan reverb:start`)
  8. Verify Pusher protocol compatibility
  9. Commit with reference to d4db04f

#### Story 5: Remove Legacy WebSockets (524c1c3)
- **Tasks** (estimated 4-5 tasks):
  1. Validate PinkieIt commit 524c1c3
  2. Remove `beyondcode/laravel-websockets` and `pusher/pusher-php-server` from composer.json
  3. Run `composer update` to remove packages
  4. Delete `config/websockets.php`
  5. Delete WebSockets statistics migration
  6. Update tests to validate Reverb (not WebSockets)
  7. Run test suite (expect 100% passing, 425/425 tests)
  8. Commit with reference to 524c1c3

**Ordering Strategy**:
- **Sequential execution required**: DevContainer (Phase 4A) must complete before framework upgrades (Phase 4B)
- **Framework upgrades**: Must follow PHP 8.2 → Laravel 10 initial → Laravel 10 completion → Reverb installation → Legacy removal sequence
- **Test validation**: After each story, run test suite to ensure no regressions
- **Constitutional compliance**: Validate YokaKit naming after DevContainer story

**Parallelization**: None - all tasks are sequential due to framework dependencies

**Estimated Output**: ~40-45 numbered, ordered tasks in tasks.md
- Phase 4A: 8-10 tasks (DevContainer unified)
- Phase 4B: 28-35 tasks (5 framework upgrade stories × 5-7 tasks each)

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

---

## Commit Replay Strategy

### Phase 4A: Unified DevContainer Implementation

**Unified Story**: 0cc0475 + 65eea6a + cdd8d6f → DevContainer Complete
**PinkieIt Commits**:
- `0cc04757fa60ad18e1b941206fb9b5a6843f8bd2` (2025-02-20, Initial)
- `65eea6abe9dfaaf0017ff85e0f0a701edc3c9b81` (2025-06-26, Optimization)
- `cdd8d6f8e9a6e6db0cabce8e1d7ec0196a743f38` (2025-06-27, Finalization)

**Files**: 4 files (devcontainer.json, compose.override.yml, post-create.sh, lifecycle updates)

**Tasks Preview**:
1. Create `.devcontainer/devcontainer.json` with YokaKit Development name
2. Configure 40+ VS Code extensions (PHP, Laravel, quality tools)
3. Configure settings (PHP 8.2, SonarLint yokakit key, SQL Tools yokakit database)
4. Create `.devcontainer/compose.override.yml` with yokakit-dev service (port 18081)
5. Create lifecycle commands (initializeCommand with yokakit input)
6. Test DevContainer in VS Code and DevContainers CLI
7. Commit with references to all 3 PinkieIt hashes

**Constitutional Handling**:
- `name`: "PinkieIt Development" → "YokaKit Development"
- `image`: pinkieit-dev → yokakit-dev
- `container_name`: pinkieit-dev → yokakit-dev
- `database`: pinkieit → yokakit
- `projectKey`: w-pinkietech_pinkieit → YokaKit-specific
- `initializeCommand`: `yes pinkie-it` → `yes yokakit`

---

### Phase 4B: Framework Modernization (Sequential Stories)

#### Story 1: e0eaabd - PHP 8.2 Upgrade
**PinkieIt Commit**: `e0eaabdc98a333c799e4ad8b2de321f369a9562f`
**Date**: 2025-06-17
**Files**: 4 files (composer.json, composer.lock, sonarqube.yml, CLAUDE.md)

**Tasks Preview**:
1. Update PHP requirement ^8.1.0 → ^8.2.0
2. Replace nunomaduro/larastan with larastan/larastan
3. Run composer update, verify 425 tests pass
4. Commit with reference to e0eaabd

**Constitutional Handling**: None (no PinkieIt-specific content)

---

#### Story 2: 4152b54 - Laravel 10 Initial Upgrade
**PinkieIt Commit**: `4152b54f7399c29e4f2570517cdb429db5956710`
**Date**: 2025-06-17
**Files**: 6 files (composer.json, composer.lock, phpunit.xml, CustomizeFormatter.php, .gitignore, CLAUDE.md)

**Tasks Preview**:
1. Update Laravel packages (^9.19 → ^10.0, Sanctum ^2.14 → ^3.2, UI ^3.4 → ^4.0)
2. Update test packages (PHPUnit ^9.5 → ^10.0, Dusk ^6.25 → ^7.0)
3. Migrate phpunit.xml to PHPUnit 10.5 schema
4. Fix Monolog 3.x compatibility in CustomizeFormatter
5. Run tests, expect ~95% passing (CSRF issues expected)
6. Commit with reference to 4152b54

**Constitutional Handling**: None (framework upgrade, no naming)

---

#### Story 3: 862d537 - Laravel 10 Completion
**PinkieIt Commit**: `862d5379a95a58b0274f2cba0ee15c53cd6f042f`
**Date**: 2025-06-17
**Files**: 9 files (AdminLTE, Sanctum migration, datatable component, tests)

**Tasks Preview**:
1. Update AdminLTE 3.8 → 3.15
2. Create Sanctum 3.x migration (expires_at column)
3. Fix AdminLTE datatable component integration
4. Add CSRF middleware bypass to test files
5. Fix Laravel10CompatibilityTest assertions
6. Run tests, expect 100% passing (425/425 tests)
7. Commit with reference to 862d537

**Constitutional Handling**: None (test fixes, no naming)

---

#### Story 4: d4db04f - Laravel Reverb Installation
**PinkieIt Commit**: `d4db04f46e8e8edc3c684288546ea7aad7a0e8b4`
**Date**: 2025-06-18
**Files**: 4 files (composer.json, composer.lock, broadcasting.php, reverb.php)

**Tasks Preview**:
1. Add laravel/reverb ^1.4 to composer.json
2. Publish config/reverb.php (93 lines)
3. Add 'reverb' connection to broadcasting.php
4. Configure REVERB_* environment variables
5. Test Reverb server startup
6. Commit with reference to d4db04f

**Constitutional Handling**: None (Reverb configuration is application-agnostic)

---

#### Story 5: 524c1c3 - Remove Legacy WebSockets
**PinkieIt Commit**: `524c1c38a7305b61008d2ff56ce1e4563da92aed`
**Date**: 2025-06-19
**Files**: 6 files (composer.json, composer.lock, config/websockets.php deletion, migration deletion, test updates)

**Tasks Preview**:
1. Remove beyondcode/laravel-websockets and pusher/pusher-php-server
2. Delete config/websockets.php
3. Delete WebSockets statistics migration
4. Update tests to validate Reverb instead of WebSockets
5. Run tests, expect 100% passing (425/425 tests)
6. Commit with reference to 524c1c3

**Constitutional Handling**: None (package removal, no naming)

---

## Complexity Tracking

*Fill ONLY if Constitution Check has violations that must be justified*

**No violations - This section is empty**

---

## Progress Tracking

*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command) - research.md ✅
- [x] Phase 1: Design complete (/plan command) - data-model.md, contracts/, quickstart.md ✅
- [x] Phase 2: Task planning approach described (/plan command) ✅
- [ ] Phase 3: Tasks generated (/tasks command) - tasks.md
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS ✅
- [x] Post-Design Constitution Check: PASS ✅
- [x] All technical context resolved (research.md) ✅
- [x] Complexity deviations documented (none) ✅

**Artifacts Generated**:
- ✅ `research.md`: 437 lines (8 commits analyzed: 3 DevContainer unified + 5 framework upgrades)
- ✅ `data-model.md`: 557 lines (13 entities + 2 schema changes)
- ✅ `contracts/`: 3 contracts (devcontainer.contract.md, composer.contract.md, reverb.contract.md)
- ✅ `quickstart.md`: 356 lines (15-minute setup guide, DevContainer-first approach)
- ✅ `plan.md`: This implementation plan

**Next Step**: Run `/tasks` to generate detailed task breakdown

**Estimated Task Count**: 40-45 tasks
- Phase 4A: 8-10 tasks (DevContainer unified implementation)
- Phase 4B: 28-35 tasks (5 framework upgrade stories)

---

*Based on Constitution v1.2.0 - See `memory/constitution.md`*
*PinkieIt Reference*: `0cc0475..cdd8d6f` (8 primary commits: 3 DevContainer + 5 framework)
*Created*: 2025-10-04
