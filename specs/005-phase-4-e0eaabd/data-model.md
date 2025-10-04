# Phase 4: Framework Modernization & DevContainer - Data Model

## Entities

### DevContainer Configuration

**Introduced in**: Unified implementation (PinkieIt commits 0cc0475, 65eea6a, cdd8d6f)
**Source**: `.devcontainer/devcontainer.json`, `.devcontainer/compose.override.yml`

**Attributes**:
```json
{
    "name": "YokaKit Development",
    "dockerComposeFile": [
        "../compose.yml",
        "compose.override.yml"
    ],
    "service": "dev",
    "remoteUser": "www-data",
    "workspaceFolder": "/workspace",
    "forwardPorts": [18081, 6002],
    "features": {
        "github-cli": true,
        "docker-outside-of-docker": true,
        "common-utils": {
            "zsh": true,
            "oh-my-zsh": true
        }
    }
}
```

**Constitutional Adaptations** (from PinkieIt):
- `name`: "PinkieIt Development" → "YokaKit Development"
- `projectKey`: "w-pinkietech_pinkieit" → YokaKit-specific SonarLint key
- `database`: "pinkieit" → "yokakit" (preserve YokaKit database naming)
- `connectionName`: "PinkieIt Database" → "YokaKit Database"
- `codespaces.repositories`: "w-pinkietech/pinkieit" → YokaKit repository URL
- `image`: "pinkieit-dev" → "yokakit-dev"
- `container_name`: "pinkieit-dev" → "yokakit-dev"
- `network`: "pinkieit" → "yokakit"

**Relationships**:
- Depends on: Docker Compose service "dev" (from compose.override.yml)
- Depends on: Database service "db" (for SQL Tools connection)
- Depends on: MQTT service "mqtt" (for DevContainer startup)

**Validation Rules**:
- Service name "dev" MUST exist in compose.override.yml
- Ports 18081 and 6002 MUST NOT conflict with regular development (18080, 6001)
- Workspace folder `/workspace` MUST be mounted from project root
- Remote user "www-data" MUST have proper permissions

---

### VS Code Extensions Configuration

**Introduced in**: Commit cdd8d6f (final DevContainer configuration)
**Source**: `.devcontainer/devcontainer.json` → `customizations.vscode.extensions`

**Extension Categories**:
```yaml
PHP & Laravel Core:
  - bmewburn.vscode-intelephense-client  # PHP language server
  - amiralizadeh9480.laravel-extra-intellisense  # Laravel IntelliSense
  - onecentlin.laravel-blade  # Blade template syntax
  - ryannaddy.laravel-artisan  # Artisan command runner
  - codingyu.laravel-goto-view  # Navigate to Blade views
  - open-southeners.laravel-pint  # Laravel Pint formatter

PHP Quality & Testing:
  - recca0120.vscode-phpunit  # PHPUnit test runner
  - sanderronde.phpstan-vscode  # PHPStan static analysis

Database:
  - mtxr.sqltools  # SQL client
  - mtxr.sqltools-driver-mysql  # MySQL driver

Frontend & Assets:
  - dbaeumer.vscode-eslint  # JavaScript linter
  - esbenp.prettier-vscode  # Code formatter
  - bradlc.vscode-tailwindcss  # Tailwind CSS IntelliSense

Git & Development:
  - eamodio.gitlens  # Git enhanced features
  - GitHub.vscode-pull-request-github  # GitHub PR integration
  - github.vscode-github-actions  # GitHub Actions workflow

DevOps & Containers:
  - ms-azuretools.vscode-docker  # Docker management
  - ms-vscode-remote.remote-containers  # Remote container support

Code Quality & Documentation:
  - SonarSource.sonarlint-vscode  # SonarLint code quality
  - streetsidesoftware.code-spell-checker  # Spell checker
  - editorconfig.editorconfig  # EditorConfig support
  - redhat.vscode-yaml  # YAML language support

Environment & Configuration:
  - mikestead.dotenv  # .env file syntax
  - ms-vscode.vscode-json  # JSON language support

AI & Development Assistance:
  - anthropic.claude-dev  # Claude Code integration
  - GitHub.copilot  # GitHub Copilot AI
  - GitHub.copilot-chat  # Copilot chat interface
```

**Settings Configuration**:
```json
{
    "php": {
        "validate.executablePath": "/usr/local/bin/php",
        "intelephense.environment.phpVersion": "8.2.0",
        "intelephense.completion.triggerParameterHints": true,
        "intelephense.diagnostics.enable": true
    },
    "laravel": {
        "laravel-goto-view.folders": ["resources/views"],
        "laravel_extra_intellisense.baseUrl": "http://localhost:18081"
    },
    "quality": {
        "phpstan.enabled": true,
        "phpstan.configFile": "./phpstan.neon",
        "sonarlint.connectedMode.project": {
            "connectionId": "sonarcloud",
            "projectKey": "YokaKit-specific-key"
        }
    },
    "editor": {
        "formatOnSave": true,
        "codeActionsOnSave": {
            "source.fixAll.eslint": "explicit"
        },
        "files.associations": {
            "*.blade.php": "blade"
        }
    },
    "terminal": {
        "integrated.defaultProfile.linux": "zsh"
    },
    "fileWatching": {
        "watcherExclude": {
            "**/storage/logs/**": true,
            "**/bootstrap/cache/**": true,
            "**/coverage/**": true
        }
    }
}
```

**Constitutional Adaptations**:
- `laravel_extra_intellisense.baseUrl`: Use "http://localhost:18081" (DevContainer port)
- `sonarlint.connectedMode.project.projectKey`: YokaKit-specific SonarCloud project key
- Codespaces: `baseUrl` → "https://$CODESPACE_NAME-18081.app.github.dev"

**Validation Rules**:
- All extensions MUST be available in VS Code Marketplace
- PHP version MUST be 8.2.0+ (matches Dockerfile)
- Laravel base URL MUST match forwarded port 18081
- SonarLint project key MUST match YokaKit project configuration

---

### DevContainer Service Configuration

**Introduced in**: Commits 65eea6a, cdd8d6f (separate dev service)
**Source**: `.devcontainer/compose.override.yml`

**Service Definition**:
```yaml
services:
  dev:
    build:
      context: .
      dockerfile: Dockerfile
      target: development  # Multi-stage Dockerfile target
      args:
        ENVIRONMENT: development
    image: yokakit-dev
    container_name: yokakit-dev
    user: "www-data:www-data"
    working_dir: /var/www/html
    environment:
      APACHE_LOG_DIR: /var/log/apache2
    depends_on:
      db:
        condition: service_healthy
      mqtt:
        condition: service_started
    command: ["/usr/local/bin/app-entrypoint.sh"]
    volumes:
      - .:/workspace  # Project root
      - ./app/laravel:/var/www/html  # Laravel application
    ports:
      - 18081:80  # DevContainer port (vs 18080 regular)
      - 6002:6001  # Reverb WebSocket (external:internal)
    extra_hosts:
      - host.docker.internal:host-gateway
    networks:
      - yokakit
```

**Constitutional Adaptations**:
- `image`: pinkieit-dev → yokakit-dev
- `container_name`: pinkieit-dev → yokakit-dev
- `network`: pinkieit → yokakit

**Validation Rules**:
- Dockerfile MUST have "development" target (multi-stage build)
- Port 18081 MUST NOT conflict with regular development (18080)
- Database service MUST be healthy before dev service starts
- Volumes MUST mount to correct workspace paths

---

### SQL Tools Database Connection

**Introduced in**: Commit cdd8d6f (DevContainer finalization)
**Source**: `.devcontainer/devcontainer.json` → `customizations.vscode.settings.sqltools.connections`

**Connection Configuration**:
```json
{
    "name": "YokaKit Database",
    "driver": "MySQL",
    "host": "db",
    "database": "yokakit",
    "username": "y",
    "password": "${localEnv:MYSQL_PASSWORD:P=PdZRSzTP1?}"
}
```

**Constitutional Adaptations**:
- `name`: "PinkieIt Database" → "YokaKit Database"
- `database`: "pinkieit" → "yokakit" (preserve YokaKit database name)

**Validation Rules**:
- Host "db" MUST match Docker Compose database service name
- Database "yokakit" MUST exist in MySQL
- Password MUST be read from MYSQL_PASSWORD environment variable

---

### PHP Dependencies (Framework Upgrades)

**Introduced in**: Commits e0eaabd, 4152b54, 862d537
**Source**: `app/laravel/composer.json`

**Version Migrations**:
```json
{
    "require": {
        "php": "^8.2.0",  // from ^8.1.0
        "laravel/framework": "^10.0",  // from ^9.19
        "laravel/sanctum": "^3.2",  // from ^2.14
        "laravel/ui": "^4.0",  // from ^3.4
        "laravel/reverb": "^1.4"  // new package
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",  // from ^9.5.10
        "laravel/dusk": "^7.0",  // from ^6.25
        "nunomaduro/collision": "^7.0",  // from ^6.1
        "spatie/laravel-ignition": "^2.0",  // from ^1.0
        "larastan/larastan": "^2.0"  // from nunomaduro/larastan
    }
}
```

**Constitutional Adaptations**:
- NONE (framework packages are version-agnostic)

**Validation Rules**:
- PHP version MUST be 8.2.0+ (compatible with Laravel 10)
- All package versions MUST resolve without conflicts
- PHPUnit schema MUST be updated to 10.5

---

### Laravel Reverb Configuration

**Introduced in**: Commit d4db04f (Reverb installation)
**Source**: `app/laravel/config/reverb.php`

**Server Configuration**:
```php
[
    'default' => 'reverb',
    'servers' => [
        'reverb' => [
            'host' => env('REVERB_SERVER_HOST', '0.0.0.0'),
            'port' => env('REVERB_SERVER_PORT', 8080),
            'path' => env('REVERB_SERVER_PATH', ''),
            'hostname' => env('REVERB_HOST'),
            'max_request_size' => env('REVERB_MAX_REQUEST_SIZE', 10_000),
            'scaling' => [
                'enabled' => env('REVERB_SCALING_ENABLED', false),
                'channel' => 'reverb'
            ]
        ]
    ],
    'apps' => [
        'provider' => 'config',
        'apps' => [
            [
                'key' => env('REVERB_APP_KEY'),
                'secret' => env('REVERB_APP_SECRET'),
                'app_id' => env('REVERB_APP_ID'),
                'options' => [
                    'host' => env('REVERB_HOST'),
                    'port' => env('REVERB_PORT', 443),
                    'scheme' => env('REVERB_SCHEME', 'https'),
                    'useTLS' => env('REVERB_SCHEME', 'https') === 'https'
                ],
                'allowed_origins' => ['*'],
                'ping_interval' => 60,
                'activity_timeout' => 30,
                'max_message_size' => 10_000
            ]
        ]
    ]
]
```

**Environment Variables** (required for Reverb):
```env
REVERB_APP_ID=your-app-id
REVERB_APP_KEY=your-app-key
REVERB_APP_SECRET=your-app-secret
REVERB_HOST=localhost
REVERB_PORT=8080
REVERB_SCHEME=http
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=8080
```

**Constitutional Adaptations**:
- NONE (Reverb configuration is application-agnostic)

**Validation Rules**:
- REVERB_APP_KEY, REVERB_APP_SECRET, REVERB_APP_ID MUST be set
- REVERB_PORT MUST match DevContainer forwarded port 6002 → 6001 mapping
- Pusher protocol compatibility MUST be maintained for frontend

---

### Broadcasting Configuration (Reverb Integration)

**Introduced in**: Commit d4db04f (Reverb installation)
**Source**: `app/laravel/config/broadcasting.php`

**Reverb Connection**:
```php
'connections' => [
    'reverb' => [
        'driver' => 'reverb',
        'key' => env('REVERB_APP_KEY'),
        'secret' => env('REVERB_APP_SECRET'),
        'app_id' => env('REVERB_APP_ID'),
        'options' => [
            'host' => env('REVERB_HOST', '0.0.0.0'),
            'port' => env('REVERB_PORT', 8080),
            'scheme' => env('REVERB_SCHEME', 'http'),
            'useTLS' => env('REVERB_SCHEME', 'http') === 'https'
        ]
    ]
]
```

**Validation Rules**:
- Connection 'reverb' MUST be present in broadcasting.connections
- Environment variables MUST match config/reverb.php
- Pusher protocol compatibility MUST be maintained

---

### Sanctum Personal Access Tokens Schema

**Introduced in**: Commit 862d537 (Laravel 10 completion)
**Source**: Database migration `2025_06_17_add_expires_at_to_personal_access_tokens.php`

**Migration**:
```php
Schema::table('personal_access_tokens', function (Blueprint $table) {
    $table->timestamp('expires_at')->nullable()->after('abilities');
});
```

**Constitutional Adaptations**:
- NONE (Sanctum 3.x requirement, application-agnostic)

**Validation Rules**:
- Migration MUST run successfully on `personal_access_tokens` table
- Column `expires_at` MUST be nullable timestamp
- Sanctum 3.x package MUST be installed

---

### Removed Entities (Cleanup)

#### Legacy WebSockets Configuration

**Removed in**: Commit 524c1c3 (legacy WebSockets removal)
**Deleted Files**:
- `app/laravel/config/websockets.php` (141 lines)
- `database/migrations/*_create_websockets_statistics_entries_table.php` (35 lines)

**Deleted Packages**:
- `beyondcode/laravel-websockets` (archived)
- `pusher/pusher-php-server` (dependency)

**Rationale**: Replaced by Laravel Reverb (commit d4db04f)

---

## Database Schema Changes

### Sanctum Personal Access Tokens Update

**Migration**: `2025_06_17_add_expires_at_to_personal_access_tokens.php`
**Commit**: 862d537 (Laravel 10 completion)

**Schema**:
```php
Schema::table('personal_access_tokens', function (Blueprint $table) {
    $table->timestamp('expires_at')->nullable()->after('abilities');
});
```

**YokaKit Adaptations**:
- NONE (table name and structure are framework-standard)

**Validation Rules**:
- Table `personal_access_tokens` MUST exist (Sanctum prerequisite)
- Migration MUST be reversible (down() method)

---

### Removed: WebSockets Statistics Table

**Migration**: `*_create_websockets_statistics_entries_table.php` (deleted)
**Commit**: 524c1c3 (legacy WebSockets removal)

**Rationale**: Laravel Reverb does not use database statistics tracking

---

## Configuration Entities

### DevContainer Lifecycle Commands

**Commit**: cdd8d6f (DevContainer finalization)
**File**: `.devcontainer/devcontainer.json`

**Lifecycle Hooks**:
```json
{
    "initializeCommand": "chmod +x ./setup.sh && yes yokakit | ./setup.sh",
    "postCreateCommand": "bash -c ./.devcontainer/post-create.sh",
    "postStartCommand": "php artisan optimize:clear",
    "postAttachCommand": "echo 'DevContainer ready! Application: http://localhost:18081'"
}
```

**YokaKit Adapted**:
```json
{
    "initializeCommand": "chmod +x ./setup.sh && yes yokakit | ./setup.sh"
}
```
- `yes pinkie-it | ./setup.sh` → `yes yokakit | ./setup.sh` (project name input)

**Validation Rules**:
- `setup.sh` MUST exist and be executable
- `.devcontainer/post-create.sh` MUST exist for post-create hook
- Commands MUST execute non-interactively (automated setup)

---

### DevContainer Features Configuration

**Commit**: cdd8d6f (DevContainer finalization)
**File**: `.devcontainer/devcontainer.json` → `features`

**Features**:
```json
{
    "ghcr.io/devcontainers/features/github-cli:1": {},
    "ghcr.io/devcontainers/features/docker-outside-of-docker:1": {},
    "ghcr.io/devcontainers/features/common-utils:2": {
        "configureZshAsDefaultShell": true,
        "installOhMyZsh": true,
        "nonFreePackages": true
    }
}
```

**Validation Rules**:
- Features MUST be available in DevContainers feature registry
- Docker-outside-of-docker MUST enable Docker CLI inside DevContainer
- Zsh and Oh My Zsh MUST be installed for terminal

---

### GitHub Codespaces Configuration

**Commit**: cdd8d6f (DevContainer finalization)
**File**: `.devcontainer/devcontainer.json` → `customizations.codespaces`

**Codespaces Settings**:
```json
{
    "repositories": {
        "YOUR_ORG/YokaKit": {
            "permissions": {
                "contents": "read",
                "metadata": "read"
            }
        }
    },
    "extensions": [/* same as vscode.extensions */],
    "settings": {
        "laravel_extra_intellisense.baseUrl": "https://$CODESPACE_NAME-18081.app.github.dev"
    }
}
```

**YokaKit Adapted**:
- `repositories`: "w-pinkietech/pinkieit" → "YOUR_ORG/YokaKit"
- `baseUrl`: Use Codespaces dynamic URL pattern

**Validation Rules**:
- Repository URL MUST match YokaKit GitHub repository
- Base URL MUST use Codespaces environment variable $CODESPACE_NAME
- Extensions MUST be compatible with Codespaces

---

### PHPUnit Configuration (PHPUnit 10 Schema)

**Commit**: 4152b54 (Laravel 10 initial upgrade)
**File**: `app/laravel/phpunit.xml`

**Schema Migration**:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/autoload.php"
         colors="true">
    <!-- PHPUnit 10.5 schema -->
    <testsuites>
        <testsuite name="Unit">
            <directory>tests/Unit</directory>
        </testsuite>
        <testsuite name="Feature">
            <directory>tests/Feature</directory>
        </testsuite>
    </testsuites>
    <source>
        <include>
            <directory>app</directory>
        </include>
    </source>
    <php>
        <env name="APP_ENV" value="testing"/>
        <env name="DB_CONNECTION" value="sqlite"/>
        <env name="DB_DATABASE" value=":memory:"/>
    </php>
</phpunit>
```

**YokaKit Adaptations**:
- NONE (PHPUnit schema is framework-standard)

**Validation Rules**:
- Schema MUST be PHPUnit 10.5 (xsi:noNamespaceSchemaLocation)
- Test suites MUST reference existing test directories
- Environment variables MUST configure testing environment

---

### Monolog 3.x Formatter Compatibility

**Commit**: 4152b54 (Laravel 10 initial upgrade)
**File**: `app/laravel/app/Logging/CustomizeFormatter.php`

**Code Changes**:
```php
// OLD (Monolog 2.x):
public function format(LogRecord $record): string
{
    // ...
}

// NEW (Monolog 3.x):
public function format(LogRecord $record): string
{
    // Compatible with Monolog 3.x method signatures
}
```

**YokaKit Adaptations**:
- NONE (framework upgrade, no naming dependencies)

**Validation Rules**:
- Formatter MUST be compatible with Monolog 3.x
- Log format MUST match YokaKit logging requirements

---

## Validation Checklist

### DevContainer (Phase 4A)
- [ ] `.devcontainer/devcontainer.json` exists with YokaKit naming
- [ ] `.devcontainer/compose.override.yml` exists with yokakit-dev service
- [ ] All 40+ VS Code extensions specified
- [ ] Port 18081 and 6002 forwarded
- [ ] SQL Tools connection configured for yokakit database
- [ ] SonarLint project key is YokaKit-specific
- [ ] Lifecycle commands reference yokakit (not pinkieit)
- [ ] GitHub Codespaces configuration references YokaKit repository

### Framework Upgrades (Phase 4B)
- [ ] `composer.json` requires PHP ^8.2.0
- [ ] `composer.json` requires Laravel ^10.0
- [ ] `composer.json` includes laravel/reverb ^1.4
- [ ] PHPUnit XML schema is 10.5
- [ ] Monolog formatter compatible with 3.x
- [ ] Sanctum migration adds expires_at column
- [ ] `config/reverb.php` exists with 93 lines
- [ ] `config/broadcasting.php` includes 'reverb' connection
- [ ] Legacy `config/websockets.php` deleted
- [ ] Legacy WebSockets migration deleted

### Constitutional Compliance
- [ ] All pinkieit references replaced with yokakit
- [ ] Database name is "yokakit" (preserved)
- [ ] Container names use yokakit prefix
- [ ] Network name is "yokakit"
- [ ] SonarLint project key is YokaKit-specific
- [ ] No PinkieIt branding in any configuration files

---

**Created**: 2025-10-04
**Source Commits**: 0cc0475, 65eea6a, cdd8d6f, e0eaabd, 4152b54, 862d537, d4db04f, 524c1c3
**Entity Count**: 13 configuration entities + 2 database schema changes
