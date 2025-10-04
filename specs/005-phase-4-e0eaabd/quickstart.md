# Phase 4: Framework Modernization & DevContainer - Quickstart Guide

## Prerequisites

**From PinkieIt Commits**:
- Phase 0: GitHub repository infrastructure ✅ COMPLETED
- Phase 1: Docker Foundation ✅ COMPLETED
- Phase 2: Docker Architecture Optimization ✅ COMPLETED
- Phase 3: Comprehensive Testing (425/425 tests passing) ✅ COMPLETED

**YokaKit Environment**:
- Docker Engine 20.10+ with BuildKit support
- Docker Compose v2
- VS Code 1.80+ with Remote - Containers extension (for DevContainer)
- Git 2.30+
- PHP 8.2+ (for local development, optional)
- Node.js 16+ with npm (for frontend assets)

**System Requirements**:
- RAM: 8GB minimum (16GB recommended for DevContainer)
- Disk: 10GB free space
- OS: Linux, macOS, or Windows with WSL2

---

## 15-Minute Setup

### Step 1: Clone and Setup (2 min)

**Based on**: YokaKit existing repository

```bash
# Clone YokaKit repository (if not already cloned)
git clone https://github.com/YOUR_ORG/YokaKit.git
cd YokaKit

# Checkout Phase 4 branch (implementation branch)
git checkout feature/phase-4-devcontainer-framework-modernization
```

---

### Step 2: Environment Configuration (3 min)

**Based on**: PinkieIt commits cdd8d6f (DevContainer), d4db04f (Reverb)

```bash
# Copy environment template
cp .env.example .env

# Configure for YokaKit Phase 4
# No constitutional adaptations needed - YokaKit identity already preserved
# Add Reverb credentials (generate random values for development)
```

**Add to .env**:
```env
# Reverb WebSocket Configuration
REVERB_APP_ID=yokakit-dev
REVERB_APP_KEY=$(openssl rand -hex 16)
REVERB_APP_SECRET=$(openssl rand -hex 32)
REVERB_HOST=localhost
REVERB_PORT=8080
REVERB_SCHEME=http
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=8080
```

**Generate Reverb Credentials**:
```bash
# Add Reverb credentials to .env
echo "REVERB_APP_ID=yokakit-dev" >> .env
echo "REVERB_APP_KEY=$(openssl rand -hex 16)" >> .env
echo "REVERB_APP_SECRET=$(openssl rand -hex 32)" >> .env
echo "REVERB_HOST=localhost" >> .env
echo "REVERB_PORT=8080" >> .env
echo "REVERB_SCHEME=http" >> .env
echo "REVERB_SERVER_HOST=0.0.0.0" >> .env
echo "REVERB_SERVER_PORT=8080" >> .env
```

---

### Step 3A: DevContainer Setup (5 min) - RECOMMENDED

**Based on**: PinkieIt commits 0cc0475 + 65eea6a + cdd8d6f (unified implementation)

**Option 1: VS Code Remote - Containers** (Preferred):
```bash
# Open folder in VS Code
code .

# VS Code will detect .devcontainer/devcontainer.json
# Click "Reopen in Container" notification

# Or use Command Palette:
# Ctrl+Shift+P → "Remote-Containers: Reopen in Container"

# Wait for DevContainer build (3-5 minutes first time)
# Extensions install automatically (40+ Laravel development tools)
```

**Option 2: DevContainers CLI**:
```bash
# Install DevContainers CLI (if not installed)
npm install -g @devcontainers/cli

# Build and open DevContainer
devcontainer up --workspace-folder .
devcontainer exec --workspace-folder . bash

# Verify DevContainer
echo "DevContainer ready! Application: http://localhost:18081"
```

**Verify DevContainer**:
```bash
# Inside DevContainer terminal
php --version  # Should show PHP 8.2.0+
php artisan --version  # Should show Laravel 10.x
composer --version
node --version
npm --version
```

---

### Step 3B: Regular Docker Setup (5 min) - ALTERNATIVE

**Based on**: YokaKit Phase 2 Docker (if not using DevContainer)

```bash
# Build and start services (regular development, port 18080)
export DOCKER_BUILDKIT=1
docker compose up -d

# Verify services
docker compose ps | grep "Up"
# Expected: web-app, db, mqtt services healthy

# Access application
open http://localhost:18080
```

---

### Step 4: Framework Upgrades (5 min)

**Based on**: PinkieIt commits e0eaabd (PHP 8.2), 4152b54 (Laravel 10), 862d537 (completion), d4db04f (Reverb)

**Inside DevContainer or web-app container**:
```bash
# Update composer dependencies to PHP 8.2 & Laravel 10
cd /var/www/html  # (or app/laravel if in workspace)
composer update

# Run database migrations (Sanctum 3.x)
php artisan migrate --force

# Install frontend dependencies
npm install
npm run build

# Clear caches
php artisan optimize:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
```

**Verify Framework Upgrades**:
```bash
# Check PHP version
php --version
# Expected: PHP 8.2.x

# Check Laravel version
php artisan --version
# Expected: Laravel Framework 10.48.x

# Check installed packages
composer show laravel/framework
composer show laravel/sanctum
composer show laravel/reverb
# Expected: Laravel 10.x, Sanctum 3.x, Reverb 1.4+

# Run test suite
php artisan test
# Expected: 425/425 tests passing (Phase 3 baseline)

# Or parallel execution
php artisan test --parallel --processes=4
# Expected: Faster execution, same results
```

---

### Step 5: Reverb WebSocket Setup (Optional, 2 min)

**Based on**: PinkieIt commit d4db04f (Reverb installation)

**Start Reverb Server** (in separate terminal):
```bash
# Inside DevContainer or web-app container
php artisan reverb:start --debug

# Expected output:
# Reverb server started on 0.0.0.0:8080
```

**Verify Reverb**:
```bash
# In another terminal, test WebSocket connection
curl http://localhost:8080
# Expected: Reverb server response

# Or access from host machine (DevContainer port forwarding)
curl http://localhost:6002
# Expected: Reverb server response (6002 → 6001 → 8080)
```

---

## Validation

### Constitutional Compliance

**Verify YokaKit Identity Preserved**:
```bash
# Check for any pinkieit references
grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=.git
# Expected: No results (all should be yokakit)

# Verify DevContainer naming
grep -i "YokaKit Development" .devcontainer/devcontainer.json
# Expected: Match found

# Verify database naming
grep "yokakit" .env
# Expected: DB_DATABASE=yokakit

# Verify Docker naming
docker ps | grep yokakit
# Expected: yokakit-dev container (if using DevContainer)
```

---

### DevContainer Health (if using DevContainer)

**Verify DevContainer Configuration**:
```bash
# Check DevContainer service
docker ps | grep yokakit-dev
# Expected: yokakit-dev container running

# Check port forwarding
curl http://localhost:18081
# Expected: YokaKit application response

# Check Reverb WebSocket port
curl http://localhost:6002
# Expected: Reverb server response (if Reverb started)
```

**Verify VS Code Extensions** (inside DevContainer):
```bash
# Open VS Code Extensions panel
# Ctrl+Shift+X

# Verify installed:
# - Intelephense (PHP)
# - Laravel Blade
# - Laravel Artisan
# - PHPUnit
# - PHPStan
# - SQL Tools
# - SonarLint
# - GitLens
# - Docker
# - Claude Dev
# - GitHub Copilot
# ... (40+ extensions total)
```

**Verify SQL Tools Connection**:
```bash
# In VS Code:
# Ctrl+Shift+P → "SQLTools: Connect"
# Select "YokaKit Database"
# Expected: Connection successful, database "yokakit" accessible
```

---

### Framework Upgrade Health

**Verify PHP 8.2**:
```bash
php --version
# Expected: PHP 8.2.x

composer show php
# Expected: PHP ^8.2.0 required
```

**Verify Laravel 10**:
```bash
php artisan --version
# Expected: Laravel Framework 10.48.x or later

composer show laravel/framework
# Expected: 10.x version

composer show laravel/sanctum
# Expected: 3.x version (Sanctum 3.x for Laravel 10)

composer show laravel/ui
# Expected: 4.x version
```

**Verify PHPUnit 10**:
```bash
vendor/bin/phpunit --version
# Expected: PHPUnit 10.x

# Check phpunit.xml schema
grep "phpunit.xsd" app/laravel/phpunit.xml
# Expected: vendor/phpunit/phpunit/phpunit.xsd (PHPUnit 10 schema)
```

**Verify AdminLTE 3.15**:
```bash
composer show jeroennoten/laravel-adminlte
# Expected: 3.15.x or later

# Test AdminLTE components
php artisan vendor:publish --provider="JeroenNoten\LaravelAdminLte\AdminLteServiceProvider" --tag=config
# Expected: AdminLTE config published successfully
```

---

### Laravel Reverb Health

**Verify Reverb Installation**:
```bash
composer show laravel/reverb
# Expected: 1.4.x or later

# Check Reverb config
ls -la app/laravel/config/reverb.php
# Expected: File exists (93 lines)

# Check broadcasting config
grep "reverb" app/laravel/config/broadcasting.php
# Expected: 'reverb' connection found
```

**Verify Legacy WebSockets Removal**:
```bash
# Check WebSockets config does NOT exist
ls -la app/laravel/config/websockets.php
# Expected: No such file

# Check WebSockets packages NOT installed
composer show beyondcode/laravel-websockets
# Expected: Package not found

composer show pusher/pusher-php-server
# Expected: Package not found

# Check WebSockets migration does NOT exist
ls app/laravel/database/migrations/*websockets_statistics*
# Expected: No such file
```

**Test Reverb Server**:
```bash
# Start Reverb (if not already started)
php artisan reverb:start --debug &

# Wait 2 seconds for server startup
sleep 2

# Test WebSocket connection
curl -i -N -H "Connection: Upgrade" \
  -H "Upgrade: websocket" \
  -H "Sec-WebSocket-Version: 13" \
  -H "Sec-WebSocket-Key: $(openssl rand -base64 16)" \
  http://localhost:8080/

# Expected: HTTP/1.1 101 Switching Protocols
```

---

### Test Suite Validation

**Run Full Test Suite**:
```bash
cd app/laravel
php artisan test

# Expected output:
#   PASS  Tests\Unit\... (XX tests)
#   PASS  Tests\Feature\... (XX tests)
#
#   Tests:    425 passed (XX assertions)
#   Duration: XX.XXs

# Or parallel execution
php artisan test --parallel --processes=4
# Expected: Same results, faster execution (~66% time reduction)
```

**Verify Test Configuration**:
```bash
# Check PHPUnit schema
head -5 app/laravel/phpunit.xml
# Expected: PHPUnit 10.5 schema

# Check test environment
grep "APP_ENV" app/laravel/phpunit.xml
# Expected: <env name="APP_ENV" value="testing"/>

# Check database connection
grep "DB_CONNECTION" app/laravel/phpunit.xml
# Expected: <env name="DB_CONNECTION" value="sqlite"/> or mysql
```

---

## Troubleshooting

**Common Issues**:

### DevContainer: Extensions Not Installing
```bash
# Solution 1: Rebuild DevContainer
# Ctrl+Shift+P → "Remote-Containers: Rebuild Container"

# Solution 2: Check extension marketplace availability
# Some extensions may require manual installation if marketplace is restricted
```

### Framework Upgrade: Composer Dependency Conflicts
```bash
# Solution: Clear composer cache and retry
rm -rf vendor composer.lock
composer clear-cache
composer install

# If conflicts persist, check PHP version
php --version  # Must be 8.2.0+

# Check Docker base image
docker exec yokakit-dev php --version
```

### Laravel 10: Test Failures (CSRF Token Issues)
```bash
# Expected behavior: Commit 862d537 includes test fixes
# Solution: Ensure all test fixes from commit 862d537 are applied

# Check BaseControllerTest.php
grep "withoutMiddleware" app/laravel/tests/Feature/Controllers/BaseControllerTest.php
# Expected: Found (CSRF bypass for tests)
```

### Reverb: Server Won't Start
```bash
# Check port availability
netstat -tuln | grep 8080
# Expected: No process using port 8080

# Check environment variables
grep "REVERB_" .env
# Expected: All required REVERB_* variables set

# Start with explicit config
php artisan reverb:start --host=0.0.0.0 --port=8080 --debug
# Expected: Server starts with debug output
```

### DevContainer: Port 18081 Not Accessible
```bash
# Check DevContainer service running
docker ps | grep yokakit-dev
# Expected: Container running

# Check port mapping
docker port yokakit-dev
# Expected: 80/tcp -> 0.0.0.0:18081

# Check Apache inside container
docker exec yokakit-dev service apache2 status
# Expected: Apache running

# Restart DevContainer
# Ctrl+Shift+P → "Remote-Containers: Rebuild and Reopen in Container"
```

### PHPUnit 10: Schema Validation Errors
```bash
# Solution: Ensure phpunit.xml uses PHPUnit 10 schema
# Check schema declaration
head -3 app/laravel/phpunit.xml
# Expected: xsi:noNamespaceSchemaLocation="vendor/phpunit/phpunit/phpunit.xsd"

# If old schema (9.x), update to 10.x format
# Reference: PinkieIt commit 4152b54 for correct schema
```

---

## Next Steps

### After DevContainer Setup (Phase 4A Complete)
1. **Verify All Extensions Installed**:
   - Check VS Code Extensions panel (Ctrl+Shift+X)
   - Verify PHP IntelliSense working (open PHP file, check autocomplete)
   - Verify SQL Tools connection (connect to YokaKit Database)

2. **Configure SonarLint** (optional):
   - Set SonarCloud project key for YokaKit
   - Ctrl+Shift+P → "SonarLint: Connect to SonarCloud"

3. **Test Development Workflow**:
   - Make a code change in PHP file
   - Verify hot-reload (refresh browser at http://localhost:18081)
   - Run tests: `php artisan test`

### After Framework Upgrades (Phase 4B Complete)
1. **Validate All Tests Passing**:
   - `php artisan test` → 425/425 passed
   - `php artisan test --parallel` → Same results, faster

2. **Test Reverb WebSocket**:
   - Start Reverb: `php artisan reverb:start --debug`
   - Test connection: `curl http://localhost:6002`
   - Verify broadcasting events (if application uses WebSockets)

3. **Performance Validation**:
   - Check Laravel cache optimization: `php artisan optimize`
   - Verify frontend assets built: `npm run build`
   - Test page load times: http://localhost:18081

4. **Review commit replay tasks** in `tasks.md` (generated by `/tasks` command)
5. **Execute Phase 4A implementation** (DevContainer unified)
6. **Execute Phase 4B implementation** (Framework upgrades in DevContainer)
7. **Validate constitutional compliance** after each commit replay

---

**Quickstart Complete**: YokaKit Phase 4 environment ready!

**DevContainer**: VS Code development environment with 40+ Laravel extensions
**Framework**: PHP 8.2 + Laravel 10.x + Laravel Reverb
**Tests**: 425/425 passing (100%)
**WebSocket**: Laravel Reverb operational
**Next**: Begin implementation or run `/plan` → `/tasks` for detailed breakdown

---

**Created**: 2025-10-04
**Based on**: PinkieIt commits 0cc0475, 65eea6a, cdd8d6f, e0eaabd, 4152b54, 862d537, d4db04f, 524c1c3
**Total Time**: ~15 minutes (2 + 3 + 5 + 5 minutes, Reverb optional +2)
