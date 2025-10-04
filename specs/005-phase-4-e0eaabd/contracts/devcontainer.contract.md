# DevContainer Configuration Contract

**Source**: PinkieIt commits 0cc0475, 65eea6a, cdd8d6f (unified implementation)
**Target**: YokaKit `.devcontainer/devcontainer.json`, `.devcontainer/compose.override.yml`

## DevContainer JSON Configuration

**PinkieIt Reference** (commit cdd8d6f - final form):
```json
{
    "name": "PinkieIt Development",
    "dockerComposeFile": [
        "../compose.yml",
        "compose.override.yml"
    ],
    "service": "dev",
    "remoteUser": "www-data",
    "workspaceFolder": "/workspace",
    "forwardPorts": [18081, 6002]
}
```

**YokaKit Contract**:
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
    "forwardPorts": [18081, 6002]
}
```

**Adaptations**:
- `name`: "PinkieIt Development" → "YokaKit Development"

**Validation**:
- [ ] DevContainer name is "YokaKit Development"
- [ ] Service "dev" exists in compose.override.yml
- [ ] Workspace folder /workspace is accessible
- [ ] Ports 18081 and 6002 are forwarded

---

## VS Code Extensions Configuration

**PinkieIt Reference** (commit cdd8d6f):
```json
"extensions": [
    "bmewburn.vscode-intelephense-client",
    "amiralizadeh9480.laravel-extra-intellisense",
    "onecentlin.laravel-blade",
    "ryannaddy.laravel-artisan",
    "codingyu.laravel-goto-view",
    "open-southeners.laravel-pint",
    "recca0120.vscode-phpunit",
    "sanderronde.phpstan-vscode",
    "mtxr.sqltools",
    "mtxr.sqltools-driver-mysql",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "bradlc.vscode-tailwindcss",
    "eamodio.gitlens",
    "GitHub.vscode-pull-request-github",
    "github.vscode-github-actions",
    "ms-azuretools.vscode-docker",
    "ms-vscode-remote.remote-containers",
    "SonarSource.sonarlint-vscode",
    "streetsidesoftware.code-spell-checker",
    "editorconfig.editorconfig",
    "redhat.vscode-yaml",
    "mikestead.dotenv",
    "ms-vscode.vscode-json",
    "anthropic.claude-dev",
    "GitHub.copilot",
    "GitHub.copilot-chat"
]
```

**YokaKit Contract**:
```json
"extensions": [
    // Same extension list (no changes required)
]
```

**Validation**:
- [ ] All 27+ extensions specified in devcontainer.json
- [ ] Extensions install successfully in DevContainer
- [ ] No PinkieIt-specific extensions (all are generic Laravel tools)

---

## VS Code Settings Configuration

**PinkieIt Reference** (commit cdd8d6f):
```json
{
    "intelephense.environment.phpVersion": "8.2.0",
    "laravel_extra_intellisense.baseUrl": "http://localhost:18081",
    "phpstan.enabled": true,
    "phpstan.configFile": "./phpstan.neon",
    "sonarlint.connectedMode.project": {
        "connectionId": "sonarcloud",
        "projectKey": "w-pinkietech_pinkieit"
    },
    "sqltools.connections": [
        {
            "name": "PinkieIt Database",
            "driver": "MySQL",
            "host": "db",
            "database": "pinkieit",
            "username": "y",
            "password": "${localEnv:MYSQL_PASSWORD:P=PdZRSzTP1?}"
        }
    ]
}
```

**YokaKit Contract**:
```json
{
    "intelephense.environment.phpVersion": "8.2.0",
    "laravel_extra_intellisense.baseUrl": "http://localhost:18081",
    "phpstan.enabled": true,
    "phpstan.configFile": "./phpstan.neon",
    "sonarlint.connectedMode.project": {
        "connectionId": "sonarcloud",
        "projectKey": "YOUR_YOKAKIT_SONARCLOUD_KEY"
    },
    "sqltools.connections": [
        {
            "name": "YokaKit Database",
            "driver": "MySQL",
            "host": "db",
            "database": "yokakit",
            "username": "y",
            "password": "${localEnv:MYSQL_PASSWORD:P=PdZRSzTP1?}"
        }
    ]
}
```

**Adaptations**:
- `sonarlint.connectedMode.project.projectKey`: "w-pinkietech_pinkieit" → YokaKit-specific key
- `sqltools.connections[0].name`: "PinkieIt Database" → "YokaKit Database"
- `sqltools.connections[0].database`: "pinkieit" → "yokakit"

**Validation**:
- [ ] PHP version is 8.2.0
- [ ] Laravel base URL is http://localhost:18081
- [ ] SonarLint project key is YokaKit-specific
- [ ] SQL Tools connection name is "YokaKit Database"
- [ ] SQL Tools database is "yokakit"

---

## Lifecycle Commands

**PinkieIt Reference** (commit cdd8d6f):
```json
{
    "initializeCommand": "chmod +x ./setup.sh && yes pinkie-it | ./setup.sh",
    "postCreateCommand": "bash -c ./.devcontainer/post-create.sh",
    "postStartCommand": "php artisan optimize:clear",
    "postAttachCommand": "echo 'DevContainer ready! Application: http://localhost:18081'"
}
```

**YokaKit Contract**:
```json
{
    "initializeCommand": "chmod +x ./setup.sh && yes yokakit | ./setup.sh",
    "postCreateCommand": "bash -c ./.devcontainer/post-create.sh",
    "postStartCommand": "php artisan optimize:clear",
    "postAttachCommand": "echo 'DevContainer ready! Application: http://localhost:18081'"
}
```

**Adaptations**:
- `initializeCommand`: `yes pinkie-it | ./setup.sh` → `yes yokakit | ./setup.sh`

**Validation**:
- [ ] initializeCommand uses "yokakit" input
- [ ] postCreateCommand script exists (.devcontainer/post-create.sh)
- [ ] postStartCommand executes successfully
- [ ] postAttachCommand displays correct URL

---

## DevContainer Features

**PinkieIt Reference** (commit cdd8d6f):
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

**YokaKit Contract**:
```json
{
    // Same features configuration (no changes required)
}
```

**Validation**:
- [ ] GitHub CLI feature installed
- [ ] Docker-outside-of-docker feature enabled
- [ ] Zsh configured as default shell
- [ ] Oh My Zsh installed

---

## GitHub Codespaces Configuration

**PinkieIt Reference** (commit cdd8d6f):
```json
{
    "repositories": {
        "w-pinkietech/pinkieit": {
            "permissions": {
                "contents": "read",
                "metadata": "read"
            }
        }
    },
    "settings": {
        "laravel_extra_intellisense.baseUrl": "https://$CODESPACE_NAME-18081.app.github.dev"
    }
}
```

**YokaKit Contract**:
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
    "settings": {
        "laravel_extra_intellisense.baseUrl": "https://$CODESPACE_NAME-18081.app.github.dev"
    }
}
```

**Adaptations**:
- `repositories`: "w-pinkietech/pinkieit" → "YOUR_ORG/YokaKit"

**Validation**:
- [ ] Repository URL matches YokaKit GitHub repository
- [ ] Codespaces base URL uses dynamic $CODESPACE_NAME
- [ ] Extensions array matches vscode.extensions

---

## Compose Override Configuration

**PinkieIt Reference** (commit cdd8d6f):
```yaml
services:
  dev:
    build:
      context: .
      dockerfile: Dockerfile
      target: development
      args:
        ENVIRONMENT: development
    image: pinkieit-dev
    container_name: pinkieit-dev
    user: "www-data:www-data"
    working_dir: /var/www/html
    depends_on:
      db:
        condition: service_healthy
      mqtt:
        condition: service_started
    command: ["/usr/local/bin/app-entrypoint.sh"]
    volumes:
      - .:/workspace
      - ./app/laravel:/var/www/html
    ports:
      - 18081:80
      - 6002:6001
    networks:
      - pinkieit
```

**YokaKit Contract**:
```yaml
services:
  dev:
    build:
      context: .
      dockerfile: Dockerfile
      target: development
      args:
        ENVIRONMENT: development
    image: yokakit-dev
    container_name: yokakit-dev
    user: "www-data:www-data"
    working_dir: /var/www/html
    depends_on:
      db:
        condition: service_healthy
      mqtt:
        condition: service_started
    command: ["/usr/local/bin/app-entrypoint.sh"]
    volumes:
      - .:/workspace
      - ./app/laravel:/var/www/html
    ports:
      - 18081:80
      - 6002:6001
    networks:
      - yokakit
```

**Adaptations**:
- `image`: pinkieit-dev → yokakit-dev
- `container_name`: pinkieit-dev → yokakit-dev
- `network`: pinkieit → yokakit

**Validation**:
- [ ] Service name is "dev" (matches devcontainer.json)
- [ ] Dockerfile target "development" exists (multi-stage build)
- [ ] Image name is yokakit-dev
- [ ] Container name is yokakit-dev
- [ ] Port 18081 mapped to container port 80
- [ ] Port 6002 mapped to container port 6001 (Reverb)
- [ ] Network is "yokakit"
- [ ] Database service dependency condition: service_healthy

---

## Post-Create Script

**Expected Content** (.devcontainer/post-create.sh):
```bash
#!/bin/bash
set -e

# Install composer dependencies
cd /var/www/html
composer install --no-interaction

# Run database migrations
php artisan migrate --force

# Generate application key if not exists
if ! grep -q "APP_KEY=" .env; then
    php artisan key:generate
fi

# Set permissions
chown -R www-data:www-data storage bootstrap/cache

echo "✅ DevContainer setup complete!"
```

**Validation**:
- [ ] Script exists at .devcontainer/post-create.sh
- [ ] Script is executable (chmod +x)
- [ ] Composer install completes successfully
- [ ] Database migrations run successfully
- [ ] Application key generated if needed
- [ ] Permissions set correctly for www-data user

---

## Complete Validation Checklist

### DevContainer JSON
- [ ] Name: "YokaKit Development"
- [ ] Service: "dev"
- [ ] Workspace: "/workspace"
- [ ] Ports: [18081, 6002]
- [ ] Extensions: 27+ Laravel development tools
- [ ] Features: GitHub CLI, Docker, Zsh, Oh My Zsh

### Settings
- [ ] PHP version: 8.2.0
- [ ] Laravel base URL: http://localhost:18081
- [ ] SonarLint: YokaKit project key
- [ ] SQL Tools: "YokaKit Database", database "yokakit"
- [ ] Editor: Format on save enabled
- [ ] Terminal: Zsh default

### Lifecycle
- [ ] initializeCommand: Uses "yokakit" input
- [ ] postCreateCommand: Runs .devcontainer/post-create.sh
- [ ] postStartCommand: Clears Laravel cache
- [ ] postAttachCommand: Shows ready message

### Compose Override
- [ ] Service: "dev"
- [ ] Image: yokakit-dev
- [ ] Container: yokakit-dev
- [ ] Network: yokakit
- [ ] Ports: 18081:80, 6002:6001
- [ ] Volumes: workspace + laravel mounts

### Codespaces
- [ ] Repository: YokaKit (not PinkieIt)
- [ ] Base URL: Codespaces dynamic URL
- [ ] Extensions: Same as vscode

### Constitutional Compliance
- [ ] No "pinkieit" references in any DevContainer files
- [ ] All naming uses "yokakit"
- [ ] Database name is "yokakit"
- [ ] SonarLint project key is YokaKit-specific

---

**Created**: 2025-10-04
**Source**: PinkieIt commits 0cc0475, 65eea6a, cdd8d6f
**Target**: YokaKit DevContainer complete implementation
