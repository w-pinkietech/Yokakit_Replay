# Tasks: Phase 1 Docker Foundation & Development Environment

**Input**: Design documents from `/specs/002-phase-1-docker/`
**Prerequisites**: plan.md ✅, research.md ✅, data-model.md ✅, contracts/ ✅, quickstart.md ✅
**Target Repository**: YokaKit (w-pinkietech/YokaKit)
**Reference Pattern**: PinkieIt commit a5d3b77ad98f34afae9ac7c6cd6be55770a4309c

## Execution Flow
```
1. Load plan.md ✅ - Tech stack: PHP 8.2, Laravel 10.x, Apache, MariaDB, Docker
2. Load data-model.md ✅ - Entities: DockerEnvironment, ApplicationStructure, DevContainerConfig
3. Load contracts/ ✅ - 4 contracts: docker-compose, devcontainer, labels, validation
4. Load research.md ✅ - PinkieIt pattern analysis complete
5. Generate tasks ✅ - Infrastructure setup with validation-first approach
6. Order by dependencies ✅ - GitHub prep → Docker → DevContainer → Structure → Quality
7. Mark parallel tasks ✅ - Independent configuration files marked [P]
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Paths relative to YokaKit repository root
- Constitutional requirement: All changes maintain YokaKit identity

## Week 0: GitHub Issue Management (Post-Epic Setup)

### Phase 0.1: Story Issue Creation
- [ ] **T001** [P] Create Story Issue: Week 1 Docker Foundation Setup
  - **File**: GitHub Issue in w-pinkietech/YokaKit
  - **Labels**: epic:phase-1, story:feature, constitutional:identity-preservation
  - **Description**: Create comprehensive Story issue for Docker foundation with task breakdown
  - **Validation**: Issue created and linked to Epic #1 and Phase 1 milestone
  - **Reference**: YokaKit_Replay specs/002-phase-1-docker/plan.md Week 1 section

- [ ] **T002** [P] Create Story Issue: Week 2 Development Environment
  - **File**: GitHub Issue in w-pinkietech/YokaKit
  - **Labels**: epic:phase-1, story:feature, constitutional:identity-preservation
  - **Description**: Create Story issue for DevContainer and development tooling
  - **Validation**: Issue created with clear acceptance criteria
  - **Reference**: YokaKit_Replay specs/002-phase-1-docker/plan.md Week 2 section

- [ ] **T003** [P] Create Story Issue: Week 3 Structural Improvements
  - **File**: GitHub Issue in w-pinkietech/YokaKit
  - **Labels**: epic:phase-1, story:feature, constitutional:identity-preservation
  - **Description**: Create Story issue for model relocation from app/Http/Requests to app/Models
  - **Validation**: Issue includes model relocation checklist
  - **Reference**: YokaKit_Replay specs/002-phase-1-docker/plan.md Week 3 section

- [ ] **T004** [P] Create Story Issue: Week 4 Quality Infrastructure
  - **File**: GitHub Issue in w-pinkietech/YokaKit
  - **Labels**: epic:phase-1, story:feature, constitutional:quality-first
  - **Description**: Create Story issue for quality tools and constitutional compliance
  - **Validation**: Issue linked to quality infrastructure requirements
  - **Reference**: YokaKit_Replay specs/002-phase-1-docker/plan.md Week 4 section

## Week 1: Docker Foundation Setup

### Phase 1.1: Project Structure & Environment Setup
- [ ] **T005** Create docker infrastructure directories
  - **Files**: YokaKit/docker/, YokaKit/docker/php/, YokaKit/docker/apache/, YokaKit/docker/mariadb/
  - **Description**: Create directory structure for Docker configuration files
  - **Validation**: All directories exist with proper permissions
  - **Constitutional**: Use YokaKit naming in all directory structures

- [ ] **T006** Create .env.example for Docker environment
  - **File**: YokaKit/.env.example
  - **Description**: Create environment variable template with YokaKit-specific configuration
  - **Validation**: File contains all required variables (DB_PASSWORD, APP_KEY, etc.)
  - **Reference**: PinkieIt .env.example pattern
  - **Constitutional**: All service names use "yokakit" prefix

### Phase 1.2: Docker Compose Configuration (Tests First)
- [ ] **T007** [P] Validate docker-compose.yml contract compliance test
  - **File**: YokaKit/tests/docker/test_docker_compose_contract.sh
  - **Description**: Create validation script to verify docker-compose.yml follows contract specifications
  - **Validation**: Test script exists and can validate YAML structure
  - **Reference**: specs/002-phase-1-docker/contracts/docker-compose.contract.yml
  - **Must**: This test MUST FAIL before T009 implementation

- [ ] **T008** [P] Validate service naming convention test
  - **File**: YokaKit/tests/docker/test_service_naming.sh
  - **Description**: Create test to ensure all Docker services use YokaKit naming (not PinkieIt)
  - **Validation**: Test checks for "yokakit" in service names, containers, volumes, networks
  - **Constitutional**: CRITICAL - identity preservation validation
  - **Must**: This test MUST FAIL before T009 implementation

- [ ] **T009** Implement docker-compose.yml with YokaKit services
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Create Docker Compose configuration with web-app and database services
  - **Validation**: T007 and T008 tests PASS, services defined per contract
  - **Services**: yokakit-web-app (php:8.2-apache), yokakit-database (mariadb:10.11.4)
  - **Ports**: 18080:80 (web), 3306:3306 (database)
  - **Reference**: PinkieIt commit a5d3b77, specs/002-phase-1-docker/contracts/docker-compose.contract.yml
  - **Constitutional**: All naming uses "yokakit" prefix, commit message references PinkieIt a5d3b77

### Phase 1.3: PHP Dockerfile Configuration
- [ ] **T010** [P] Dockerfile validation test
  - **File**: YokaKit/tests/docker/test_dockerfile_structure.sh
  - **Description**: Create test to validate Dockerfile structure and PHP extensions
  - **Validation**: Test checks for PHP 8.2, Apache, required extensions
  - **Must**: This test MUST FAIL before T011 implementation

- [ ] **T011** Create PHP 8.2 + Apache Dockerfile
  - **File**: YokaKit/docker/php/Dockerfile
  - **Description**: Create Dockerfile with PHP 8.2-apache base, Laravel extensions
  - **Validation**: T010 test PASSES, docker build succeeds
  - **Extensions**: pdo_mysql, gd, mbstring, zip, opcache
  - **Apache**: mod_rewrite enabled, DocumentRoot configured
  - **Reference**: PinkieIt commit a5d3b77 Dockerfile pattern
  - **Constitutional**: Commit message references PinkieIt a5d3b77

### Phase 1.4: Apache Configuration
- [ ] **T012** [P] Create Apache virtual host configuration
  - **File**: YokaKit/docker/apache/sites-available/000-default.conf
  - **Description**: Create Apache VirtualHost configuration for Laravel
  - **Validation**: DocumentRoot points to /var/www/html/public, rewrite rules configured
  - **Reference**: PinkieIt Apache configuration pattern

- [ ] **T013** [P] Create PHP configuration overrides
  - **File**: YokaKit/docker/php/local.ini
  - **Description**: Create PHP configuration for development (upload limits, memory, error reporting)
  - **Validation**: Configuration values appropriate for Laravel development
  - **Reference**: PinkieIt PHP configuration pattern

### Phase 1.5: MariaDB Setup
- [ ] **T014** [P] Create database initialization directory
  - **File**: YokaKit/docker/mariadb/init/
  - **Description**: Create directory for MariaDB initialization scripts
  - **Validation**: Directory exists, README.md explains usage

- [ ] **T015** [P] Create database health check script
  - **File**: YokaKit/tests/docker/test_database_health.sh
  - **Description**: Create script to test MariaDB connectivity and health
  - **Validation**: Script can verify MariaDB is running and accessible
  - **Must**: This test MUST FAIL before docker-compose up

### Phase 1.6: Initial Validation Scripts
- [ ] **T016** [P] Create constitutional compliance validation script
  - **File**: YokaKit/scripts/validation/constitutional-compliance.sh
  - **Description**: Create script to verify YokaKit identity preservation (no PinkieIt references)
  - **Validation**: Script checks all Docker files for YokaKit naming
  - **Reference**: specs/002-phase-1-docker/contracts/validation-scripts.contract.yml
  - **Constitutional**: CRITICAL validation script

- [ ] **T017** [P] Create Docker environment health check script
  - **File**: YokaKit/scripts/validation/docker-environment.sh
  - **Description**: Create script to verify Docker services are running and healthy
  - **Validation**: Script checks service status, network connectivity, volumes
  - **Reference**: specs/002-phase-1-docker/contracts/validation-scripts.contract.yml

- [ ] **T018** Execute initial Docker environment test
  - **Command**: docker-compose up -d && YokaKit/scripts/validation/docker-environment.sh
  - **Description**: First complete Docker environment startup and validation
  - **Validation**: All services healthy, T015 database health test PASSES, no errors
  - **Validation**: T016 constitutional compliance PASSES
  - **Milestone**: Docker Foundation baseline established

## Week 2: Development Environment Setup

### Phase 2.1: DevContainer Configuration (Tests First)
- [ ] **T019** [P] DevContainer validation test
  - **File**: YokaKit/tests/devcontainer/test_devcontainer_structure.sh
  - **Description**: Create test to validate devcontainer.json structure
  - **Validation**: Test checks required extensions, settings, features
  - **Reference**: specs/002-phase-1-docker/contracts/devcontainer.contract.json
  - **Must**: This test MUST FAIL before T020 implementation

- [ ] **T020** Create .devcontainer configuration
  - **File**: YokaKit/.devcontainer/devcontainer.json
  - **Description**: Create VS Code DevContainer configuration with Laravel extensions
  - **Validation**: T019 test PASSES, configuration follows contract
  - **Extensions**: PHP IntelliSense, Laravel extensions, Docker integration
  - **Features**: docker-in-docker, git, gh CLI
  - **Reference**: PinkieIt DevContainer pattern, specs/002-phase-1-docker/contracts/devcontainer.contract.json
  - **Constitutional**: All naming uses YokaKit references

### Phase 2.2: Development Tools Integration
- [ ] **T021** [P] Add Laravel Pint configuration
  - **File**: YokaKit/pint.json
  - **Description**: Create Laravel Pint code formatting configuration
  - **Validation**: pint.json exists, can run ./vendor/bin/pint --test
  - **Reference**: PinkieIt Pint configuration

- [ ] **T022** [P] Add Larastan configuration
  - **File**: YokaKit/phpstan.neon
  - **Description**: Create Larastan static analysis configuration
  - **Validation**: phpstan.neon exists, analysis runs without critical errors
  - **Reference**: PinkieIt Larastan configuration

- [ ] **T023** [P] Add EditorConfig for code consistency
  - **File**: YokaKit/.editorconfig
  - **Description**: Create EditorConfig for consistent coding styles
  - **Validation**: .editorconfig defines indentation, line endings, charset

### Phase 2.3: Development Workflow Documentation
- [ ] **T024** Create developer setup guide (15-minute quickstart)
  - **File**: YokaKit/docs/DEVELOPMENT.md
  - **Description**: Create comprehensive developer onboarding documentation
  - **Validation**: Document covers setup, validation, common issues
  - **Reference**: specs/002-phase-1-docker/quickstart.md
  - **Content**: Docker setup, DevContainer usage, validation commands

- [ ] **T025** [P] Create Docker troubleshooting guide
  - **File**: YokaKit/docs/DOCKER_TROUBLESHOOTING.md
  - **Description**: Document common Docker issues and solutions
  - **Validation**: Covers port conflicts, permission issues, rebuild procedures
  - **Reference**: specs/002-phase-1-docker/quickstart.md troubleshooting section

### Phase 2.4: Hot-Reload & Development Workflow
- [ ] **T026** Configure hot-reload for development
  - **Files**: YokaKit/docker-compose.yml (update volumes), YokaKit/.devcontainer/devcontainer.json (update mounts)
  - **Description**: Ensure code changes reflect immediately without container restart
  - **Validation**: File change reflects in < 5 seconds, hot-reload test scenario PASSES
  - **Reference**: specs/002-phase-1-docker/quickstart.md Scenario 2

- [ ] **T027** Test complete development workflow
  - **Description**: Execute full developer workflow from clone to code change
  - **Validation**: Setup time < 15 minutes, quickstart.md Scenario 1 PASSES
  - **Reference**: specs/002-phase-1-docker/quickstart.md Scenario 1
  - **Milestone**: Development environment operational

## Week 3: Structural Improvements (Model Relocation)

### Phase 3.1: Model Analysis & Planning
- [ ] **T028** Audit models in app/Http/Requests directory
  - **File**: YokaKit/docs/MODEL_RELOCATION_PLAN.md
  - **Description**: Identify all model files incorrectly placed in app/Http/Requests/
  - **Validation**: Complete list of models to relocate (especially AndonConfig.php)
  - **Analysis**: Document dependencies and references for each model
  - **Reference**: specs/002-phase-1-docker/research.md model relocation section

- [ ] **T029** [P] Create Laravel structure validation script
  - **File**: YokaKit/scripts/validation/laravel-structure.sh
  - **Description**: Create script to validate Laravel directory structure compliance
  - **Validation**: Script checks models in app/Models/, no models in app/Http/Requests/
  - **Reference**: specs/002-phase-1-docker/contracts/validation-scripts.contract.yml
  - **Must**: This test MUST FAIL before model relocation

### Phase 3.2: Model Relocation Execution
- [ ] **T030** Create proper models in app/Models/ directory
  - **Files**: YokaKit/app/Models/{AndonConfig,Producer,Sensor,etc}.php
  - **Description**: Create properly structured model files in correct location
  - **Validation**: All identified models recreated in app/Models/ with correct namespaces
  - **Constitutional**: Preserve YokaKit functionality, no breaking changes

- [ ] **T031** Update all model references and imports
  - **Files**: YokaKit/app/Http/Controllers/*, YokaKit/app/Services/*, etc.
  - **Description**: Update all references from old to new model locations
  - **Validation**: Search codebase confirms no references to old locations
  - **Tools**: grep -r "app\\\\Http\\\\Requests.*Config" to find references

- [ ] **T032** Regenerate Composer autoloader
  - **Command**: docker-compose exec web-app composer dump-autoload
  - **Description**: Regenerate autoloader to recognize new model locations
  - **Validation**: composer dump-autoload succeeds, no autoload warnings

- [ ] **T033** Clear Laravel application caches
  - **Commands**: php artisan optimize:clear, config:cache, route:cache
  - **Description**: Clear all Laravel caches to reflect new structure
  - **Validation**: Commands execute successfully, application loads

### Phase 3.3: Model Relocation Validation
- [ ] **T034** Execute Laravel structure validation
  - **Command**: YokaKit/scripts/validation/laravel-structure.sh
  - **Description**: Validate model relocation completion and structure compliance
  - **Validation**: T029 structure validation test PASSES
  - **Validation**: No model files remain in app/Http/Requests/
  - **Reference**: specs/002-phase-1-docker/quickstart.md Scenario 3

- [ ] **T035** Test application functionality post-relocation
  - **Command**: docker-compose exec web-app php artisan route:list
  - **Description**: Verify application routes and functionality preserved
  - **Validation**: All routes load, no class-not-found errors
  - **Validation**: quickstart.md Scenario 3 PASSES

- [ ] **T036** Remove old model files from app/Http/Requests/
  - **Files**: YokaKit/app/Http/Requests/{AndonConfig,etc}.php (models only, keep actual requests)
  - **Description**: Delete incorrectly placed model files after validation
  - **Validation**: Only FormRequest classes remain in app/Http/Requests/
  - **Milestone**: Structural improvements complete

## Week 4: Quality Infrastructure & Phase Completion

### Phase 4.1: PHPUnit Test Framework Setup
- [ ] **T037** [P] Configure PHPUnit for containerized testing
  - **File**: YokaKit/phpunit.xml
  - **Description**: Update PHPUnit configuration for Docker environment
  - **Validation**: phpunit.xml configured for test database, environment variables
  - **Reference**: PinkieIt PHPUnit configuration

- [ ] **T038** [P] Create test database configuration
  - **File**: YokaKit/.env.testing
  - **Description**: Create testing environment configuration
  - **Validation**: Test database uses separate connection, won't affect development data

- [ ] **T039** Execute baseline test suite
  - **Command**: docker-compose exec web-app php artisan test
  - **Description**: Run existing YokaKit test suite in Docker environment
  - **Validation**: Tests execute successfully, establish baseline coverage
  - **Milestone**: Testing framework operational

### Phase 4.2: Quality Tools Validation
- [ ] **T040** [P] Execute Laravel Pint formatting check
  - **Command**: docker-compose exec web-app ./vendor/bin/pint --test
  - **Description**: Run code formatting validation across codebase
  - **Validation**: Pint reports code formatting compliance or issues

- [ ] **T041** [P] Execute Larastan static analysis
  - **Command**: docker-compose exec web-app ./vendor/bin/phpstan analyse
  - **Description**: Run static analysis to identify code quality issues
  - **Validation**: Larastan completes analysis, reports baseline metrics

- [ ] **T042** Create development quality validation script
  - **File**: YokaKit/scripts/validation/development-quality.sh
  - **Description**: Create comprehensive quality validation script
  - **Validation**: Script runs Pint, PHPStan, tests, reports results
  - **Reference**: specs/002-phase-1-docker/contracts/validation-scripts.contract.yml

### Phase 4.3: Constitutional Compliance Automation
- [ ] **T043** [P] Implement pre-commit constitutional validation hook
  - **File**: YokaKit/.git/hooks/pre-commit (example in docs/)
  - **Description**: Create pre-commit hook to run constitutional compliance validation
  - **Validation**: Hook prevents commits with PinkieIt branding or YokaKit violations
  - **Reference**: specs/002-phase-1-docker/quickstart.md Scenario 4

- [ ] **T044** Execute complete validation suite
  - **Command**: YokaKit/scripts/validation/run-all-validations.sh
  - **Description**: Create and execute master validation script
  - **Scripts**: constitutional-compliance, docker-environment, laravel-structure, development-quality
  - **Validation**: All validation scripts PASS
  - **Reference**: specs/002-phase-1-docker/quickstart.md validation scenarios

### Phase 4.4: Documentation & Phase Completion
- [ ] **T045** [P] Update YokaKit README.md with Docker instructions
  - **File**: YokaKit/README.md
  - **Description**: Update main README with Docker setup and usage
  - **Validation**: README includes quickstart, commands, troubleshooting
  - **Constitutional**: All examples use YokaKit naming

- [ ] **T046** [P] Create CHANGELOG.md entry for Phase 1
  - **File**: YokaKit/CHANGELOG.md
  - **Description**: Document Phase 1 changes with PinkieIt commit references
  - **Validation**: Changelog includes Docker foundation, model relocation, quality tools
  - **Constitutional**: References PinkieIt commit a5d3b77 for audit trail

- [ ] **T047** Create Phase 1 completion validation report
  - **File**: YokaKit/docs/PHASE_1_COMPLETION_REPORT.md
  - **Description**: Generate comprehensive Phase 1 completion report
  - **Validation**: All acceptance criteria met, constitutional compliance verified
  - **Content**: Success indicators, validation results, next steps
  - **Reference**: specs/002-phase-1-docker/plan.md completion criteria

- [ ] **T048** Update YokaKit_Replay submodule reference
  - **Command**: cd YokaKit_Replay && git add YokaKit && git commit -m "chore: update YokaKit submodule to Phase 1 completion"
  - **Description**: Update submodule pointer to Phase 1 completion state
  - **Validation**: YokaKit_Replay references updated YokaKit commit
  - **Constitutional**: Submodule synchronization per constitution requirement
  - **Milestone**: Phase 1 Complete! 🎉

## Dependencies

### Critical Paths
1. **GitHub Issues (T001-T004)** → can proceed in parallel with technical work
2. **Docker Foundation**: T005 → T006 → (T007, T008 parallel) → T009 → T010 → T011
3. **Docker Services**: T012, T013 parallel → T014, T015 parallel → T016, T017 parallel → T018
4. **DevContainer**: T018 complete → T019 → T020 → (T021, T022, T023 parallel)
5. **Development Workflow**: T024, T025 parallel → T026 → T027
6. **Model Relocation**: T027 complete → T028 → T029 → T030 → T031 → T032 → T033 → T034 → T035 → T036
7. **Quality Infrastructure**: T036 complete → (T037, T038 parallel) → T039 → (T040, T041, T042 parallel) → T043 → T044
8. **Completion**: T044 → (T045, T046, T047 parallel) → T048

### Blocking Relationships
- T009 blocks T018 (need docker-compose before environment test)
- T018 blocks T020 (Docker must work before DevContainer)
- T027 blocks T028 (development workflow before structural changes)
- T036 blocks T037 (structural changes before quality setup)
- T044 blocks T048 (all validations before phase completion)

## Parallel Execution Examples

### Week 1: Docker Foundation Parallel Tasks
```bash
# Parallel: Contract validation tests
Task T007: "Validate docker-compose.yml contract compliance test"
Task T008: "Validate service naming convention test"

# Parallel: Apache and PHP configuration
Task T012: "Create Apache virtual host configuration"
Task T013: "Create PHP configuration overrides"

# Parallel: Initial validation scripts
Task T016: "Create constitutional compliance validation script"
Task T017: "Create Docker environment health check script"
```

### Week 2: Development Environment Parallel Tasks
```bash
# Parallel: Development tools
Task T021: "Add Laravel Pint configuration"
Task T022: "Add Larastan configuration"
Task T023: "Add EditorConfig for code consistency"

# Parallel: Documentation
Task T024: "Create developer setup guide"
Task T025: "Create Docker troubleshooting guide"
```

### Week 4: Quality Infrastructure Parallel Tasks
```bash
# Parallel: Test configuration
Task T037: "Configure PHPUnit for containerized testing"
Task T038: "Create test database configuration"

# Parallel: Quality validation
Task T040: "Execute Laravel Pint formatting check"
Task T041: "Execute Larastan static analysis"
Task T042: "Create development quality validation script"

# Parallel: Final documentation
Task T045: "Update YokaKit README.md with Docker instructions"
Task T046: "Create CHANGELOG.md entry for Phase 1"
Task T047: "Create Phase 1 completion validation report"
```

## Constitutional Compliance Checklist

Every task must verify:
- [ ] YokaKit naming preserved (no PinkieIt references in YokaKit code)
- [ ] PinkieIt commit hash referenced in relevant commits (audit trail)
- [ ] Quality gates implemented and passing
- [ ] Validation scripts execute successfully
- [ ] Documentation updated with correct naming

## Execution Notes

### TDD Approach for Infrastructure
- Validation scripts created BEFORE implementation
- Contract compliance tests MUST FAIL before configuration created
- All tests MUST PASS before proceeding to next phase

### Commit Strategy
- Commit after each completed task
- Reference PinkieIt commit a5d3b77 in Docker-related commits
- Include task ID in commit messages (e.g., "T009: implement docker-compose.yml")

### Validation Frequency
- Run constitutional compliance after every commit
- Run full validation suite at end of each week
- Document validation results for phase completion report

## Success Metrics

### Performance Targets
- Docker environment startup: < 2 minutes ✓
- Hot-reload response: < 5 seconds ✓
- Developer setup time: < 15 minutes ✓

### Quality Targets
- All validation scripts passing ✓
- Zero PinkieIt branding in YokaKit code ✓
- Models properly located in app/Models/ ✓
- PHPUnit tests execute in Docker environment ✓

### Constitutional Targets
- YokaKit identity preserved throughout ✓
- PinkieIt audit trail maintained ✓
- All issues properly labeled ✓
- Submodule synchronized at completion ✓

---
**Total Tasks**: 48
**Estimated Duration**: 4 weeks
**Parallel Tasks**: 21 tasks marked [P]
**Critical Path**: 27 sequential tasks
**Constitutional Compliance**: Required for all tasks

**Ready for implementation!** Each task is specific, measurable, and immediately executable.