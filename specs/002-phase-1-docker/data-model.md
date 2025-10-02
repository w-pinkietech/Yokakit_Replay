# Data Model: Phase 1 Docker Foundation & Development Environment

**Generated**: 2025-09-28
**Feature**: Phase 1 Docker Foundation & Development Environment
**Purpose**: Entity definitions and relationships for Docker development environment

## Entity Overview

This data model defines the key entities involved in establishing Docker-based development environment for YokaKit with GitHub management integration and structural improvements.

## 1. Docker Environment Configuration

### DockerEnvironment
**Purpose**: Represents the complete containerized development stack
**Lifecycle**: Created during setup, persists throughout development

```yaml
DockerEnvironment:
  properties:
    - environment_name: string (e.g., "yokakit-dev")
    - network_name: string (e.g., "yokakit-network")
    - project_name: string ("yokakit")
    - compose_file_path: string ("docker-compose.yml")
    - status: enum [stopped, starting, running, error]
    - created_at: timestamp
    - last_started: timestamp

  relationships:
    - has_many: DockerServices
    - has_many: DockerVolumes
    - has_one: DatabaseConfig
```

### DockerService
**Purpose**: Individual containerized services (web, database, cache)
**Lifecycle**: Defined in compose, managed by Docker orchestration

```yaml
DockerService:
  properties:
    - service_name: string (e.g., "web-app", "database", "redis")
    - image: string (e.g., "php:8.2-apache", "mariadb:10.11.4")
    - container_name: string
    - ports: array<string> (e.g., ["18080:80", "3306:3306"])
    - status: enum [stopped, starting, running, error, exited]
    - restart_policy: enum [no, always, on-failure, unless-stopped]
    - health_check: object

  relationships:
    - belongs_to: DockerEnvironment
    - has_many: EnvironmentVariables
    - has_many: VolumeMount
```

### DockerVolume
**Purpose**: Persistent data storage for containers
**Lifecycle**: Created with environment, persists data across container restarts

```yaml
DockerVolume:
  properties:
    - volume_name: string (e.g., "yokakit-db-data", "yokakit-app-storage")
    - driver: string ("local")
    - mount_point: string (container path)
    - host_path: string (optional, for bind mounts)
    - volume_type: enum [named, bind, tmpfs]
    - size_limit: string (optional)

  relationships:
    - belongs_to: DockerEnvironment
    - has_many: VolumeMount
```

## 2. YokaKit Application Structure

### ApplicationStructure
**Purpose**: Represents current and target YokaKit application organization
**Lifecycle**: Analyzed during setup, modified during structural improvements

```yaml
ApplicationStructure:
  properties:
    - root_path: string ("/app/yokakit")
    - laravel_version: string ("9.19" -> "10.x")
    - php_version: string ("8.0.2" -> "8.2")
    - framework: string ("Laravel")
    - structure_valid: boolean
    - last_validated: timestamp

  relationships:
    - has_many: DirectoryStructure
    - has_many: ModelFileLocation
    - has_one: ComposerConfiguration
```

### ModelFileLocation
**Purpose**: Tracks model files requiring relocation from incorrect locations
**Lifecycle**: Identified during analysis, relocated during structural improvements

```yaml
ModelFileLocation:
  properties:
    - file_name: string (e.g., "AndonConfig.php")
    - current_path: string ("app/Http/Requests/AndonConfig.php")
    - target_path: string ("app/Models/AndonConfig.php")
    - file_type: enum [model, request, controller, other]
    - relocation_status: enum [pending, in_progress, completed, failed]
    - validation_passed: boolean
    - dependencies: array<string> (files that reference this model)

  relationships:
    - belongs_to: ApplicationStructure
    - has_many: FileReference
```

### DirectoryStructure
**Purpose**: Laravel application directory organization
**Lifecycle**: Validated during setup, maintained throughout development

```yaml
DirectoryStructure:
  properties:
    - path: string (e.g., "app/Models", "app/Http/Controllers")
    - directory_type: enum [models, controllers, requests, views, config]
    - is_standard: boolean (follows Laravel conventions)
    - file_count: integer
    - last_modified: timestamp

  relationships:
    - belongs_to: ApplicationStructure
    - contains_many: ModelFileLocation
```

## 3. GitHub Management Structure

### GitHubRepository
**Purpose**: Represents YokaKit repository with management configuration
**Lifecycle**: Configured during GitHub preparation phase

```yaml
GitHubRepository:
  properties:
    - repository_name: string ("YokaKit")
    - owner: string
    - clone_url: string
    - management_setup_complete: boolean
    - default_branch: string ("main")
    - protection_rules_enabled: boolean

  relationships:
    - has_many: GitHubLabel
    - has_many: GitHubMilestone
    - has_many: IssueTemplate
    - has_many: GitHubIssue
```

### GitHubLabel
**Purpose**: 4-tier label hierarchy for issue management
**Lifecycle**: Migrated from YokaKit_Replay during GitHub preparation

```yaml
GitHubLabel:
  properties:
    - name: string (e.g., "epic:phase-1", "constitutional:identity-preservation")
    - color: string (hex color code)
    - description: string
    - label_tier: enum [epic, story, task, constitutional]
    - is_constitutional: boolean
    - is_required: boolean (for constitutional:identity-preservation)

  relationships:
    - belongs_to: GitHubRepository
    - applied_to_many: GitHubIssue
```

### GitHubMilestone
**Purpose**: Phase-based milestone tracking
**Lifecycle**: Created during GitHub setup, updated throughout phases

```yaml
GitHubMilestone:
  properties:
    - title: string (e.g., "Phase 1: Docker Foundation")
    - description: string
    - due_date: date
    - phase_number: integer (0-6)
    - state: enum [open, closed]
    - completion_percentage: float (0.0-1.0)

  relationships:
    - belongs_to: GitHubRepository
    - has_many: GitHubIssue
```

### GitHubIssue
**Purpose**: Epic/Story/Task issues with constitutional compliance
**Lifecycle**: Created throughout development following hierarchy

```yaml
GitHubIssue:
  properties:
    - number: integer
    - title: string
    - body: text
    - issue_type: enum [epic, story, task]
    - state: enum [open, closed]
    - constitutional_labels_applied: boolean
    - pinkieit_commit_references: array<string>
    - phase_alignment: integer (0-6)

  relationships:
    - belongs_to: GitHubRepository
    - belongs_to: GitHubMilestone
    - has_many: GitHubLabel (through labels)
    - references_many: PinkieItCommit
```

## 4. Development Workflow Configuration

### DevContainerConfig
**Purpose**: VS Code development container configuration
**Lifecycle**: Created during development environment setup

```yaml
DevContainerConfig:
  properties:
    - name: string ("YokaKit Development")
    - dockerfile_path: string ("./Dockerfile")
    - compose_file: string ("docker-compose.yml")
    - service: string ("web-app")
    - workspace_folder: string ("/workspace")
    - shutdown_action: enum [none, stopCompose]

  relationships:
    - has_many: VSCodeExtension
    - has_many: DevContainerSetting
    - connects_to: DockerService
```

### VSCodeExtension
**Purpose**: Required VS Code extensions for Laravel development
**Lifecycle**: Installed automatically during DevContainer setup

```yaml
VSCodeExtension:
  properties:
    - extension_id: string (e.g., "bmewburn.vscode-intelephense-client")
    - name: string
    - category: enum [php, laravel, git, debugging, formatting]
    - required: boolean
    - version_constraint: string (optional)

  relationships:
    - belongs_to: DevContainerConfig
```

### ValidationScript
**Purpose**: Automated validation and compliance checking
**Lifecycle**: Executed during setup and development workflow

```yaml
ValidationScript:
  properties:
    - script_name: string (e.g., "validate-structure", "check-constitutional-compliance")
    - script_path: string
    - execution_type: enum [manual, pre_commit, ci_cd, periodic]
    - expected_exit_code: integer (0 for success)
    - timeout_seconds: integer
    - last_execution: timestamp
    - last_result: enum [success, failure, timeout, error]

  relationships:
    - validates: ApplicationStructure
    - validates: DockerEnvironment
    - produces: ValidationResult
```

## 5. Historical Reference Integration

### PinkieItCommit
**Purpose**: Reference commits from PinkieIt for audit trail
**Lifecycle**: Referenced throughout implementation for constitutional compliance

```yaml
PinkieItCommit:
  properties:
    - commit_hash: string (e.g., "a5d3b77ad98f34afae9ac7c6cd6be55770a4309c")
    - commit_date: timestamp
    - description: string
    - phase_relevance: integer (which phase this commit relates to)
    - implementation_status: enum [referenced, implemented, adapted, skipped]

  relationships:
    - referenced_by_many: GitHubIssue
    - influences_many: DockerService
    - guides: ApplicationStructure
```

### ConstitutionalCompliance
**Purpose**: Tracks compliance with constitutional requirements
**Lifecycle**: Monitored throughout all development activities

```yaml
ConstitutionalCompliance:
  properties:
    - requirement_name: string (e.g., "Identity Preservation", "Historical Fidelity")
    - compliance_status: enum [compliant, violation, needs_review]
    - last_checked: timestamp
    - automated_check: boolean
    - violation_details: text (if applicable)

  relationships:
    - applies_to: ApplicationStructure
    - applies_to: GitHubRepository
    - applies_to: DockerEnvironment
    - validated_by: ValidationScript
```

## Entity Relationships Summary

### Primary Data Flow
1. **GitHubRepository** → configured with labels, milestones, templates
2. **DockerEnvironment** → orchestrates services, volumes, networking
3. **ApplicationStructure** → improved through model relocation
4. **DevContainerConfig** → provides development environment integration
5. **ValidationScript** → ensures constitutional compliance throughout

### Critical Dependencies
- GitHubRepository must be configured before technical implementation
- DockerEnvironment depends on ApplicationStructure analysis
- ModelFileLocation relocation requires validation against dependencies
- ConstitutionalCompliance monitoring affects all entity modifications

### Validation Rules
- All GitHubIssue entities must have constitutional:identity-preservation label
- ModelFileLocation relocation must preserve functionality
- DockerService configurations must maintain YokaKit naming conventions
- PinkieItCommit references must be maintained for audit trail

## Implementation Priority

### Phase 0: Analysis & Planning
- ApplicationStructure analysis
- ModelFileLocation identification
- PinkieItCommit reference collection

### Phase 1: Foundation Setup
- GitHubRepository configuration
- DockerEnvironment establishment
- DevContainerConfig creation

### Phase 2: Structural Improvements
- ModelFileLocation relocation
- ApplicationStructure validation
- ConstitutionalCompliance verification

### Phase 3: Integration & Validation
- ValidationScript execution
- End-to-end workflow testing
- Documentation completion

---

**Data Model Complete**: All entities defined with properties, relationships, and validation rules for Phase 1 Docker Foundation implementation.