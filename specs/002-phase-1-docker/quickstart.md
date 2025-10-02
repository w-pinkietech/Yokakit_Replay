# Quickstart Guide: Phase 1 Docker Foundation & Development Environment

**Generated**: 2025-09-28
**Purpose**: Step-by-step setup guide for YokaKit Docker development environment
**Timeline**: 15-minute setup for new developers

## Prerequisites

### Required Software
- **Docker Desktop 20.10.13+** or Docker Engine with Docker Compose v2.17.2+
- **Git** for repository cloning and version control
- **GitHub CLI (gh)** for repository management (optional but recommended)
- **VS Code** for DevContainer development (recommended)

### System Requirements
- **RAM**: Minimum 8GB (16GB recommended)
- **Storage**: 10GB free space for containers and volumes
- **OS**: Windows 10/11, macOS 10.15+, or Linux (Ubuntu 20.04+)
- **Network**: Internet access for Docker image downloads

## Quick Setup (15 minutes)

### Step 1: Repository Setup (3 minutes)

```bash
# Clone YokaKit_Replay repository
git clone https://github.com/YOUR_ORG/YokaKit_Replay.git
cd YokaKit_Replay

# Initialize and update submodules
git submodule init
git submodule update

# Switch to Phase 1 branch
git checkout 002-phase-1-docker
```

### Step 2: GitHub Management Setup (5 minutes)

```bash
# Authenticate with GitHub CLI (if not already done)
gh auth login

# Navigate to YokaKit repository for management setup
cd YokaKit

# Create labels (run these commands in YokaKit repository)
./scripts/github/setup-labels.sh

# Create milestones
./scripts/github/setup-milestones.sh

# Create Phase 1 Epic issue
./scripts/github/create-phase1-epic.sh
```

### Step 3: Docker Environment Setup (5 minutes)

```bash
# Return to YokaKit_Replay directory
cd ..

# Copy environment configuration
cp .env.example .env
# Edit .env file with your database passwords

# Build and start Docker environment
docker-compose up -d --build

# Wait for services to be healthy (may take 2-3 minutes)
./scripts/validation/docker-environment.sh
```

### Step 4: Laravel Application Setup (2 minutes)

```bash
# Install dependencies
docker-compose exec web-app composer install

# Generate application key
docker-compose exec web-app php artisan key:generate

# Run database migrations
docker-compose exec web-app php artisan migrate

# Verify application is running
curl http://localhost:18080/health
```

## Development Workflow

### Daily Development Start

```bash
# Start Docker environment
docker-compose up -d

# Check service health
docker-compose ps

# Access application
open http://localhost:18080
```

### VS Code DevContainer (Recommended)

```bash
# Open in VS Code
code .

# When prompted, select "Reopen in Container"
# Or use Command Palette: "Dev Containers: Reopen in Container"
```

### Making Changes

```bash
# All changes in ./YokaKit directory are automatically synced
# Hot-reload is enabled for development

# Run validation before committing
./scripts/validation/run-all-validations.sh

# Run tests
docker-compose exec web-app php artisan test

# Format code
docker-compose exec web-app ./vendor/bin/pint
```

## Validation Scenarios

### Scenario 1: Fresh Environment Setup

**Given**: New developer with Docker installed
**When**: Following quickstart steps 1-4
**Then**:
- ✅ YokaKit application accessible at http://localhost:18080
- ✅ Database connection working
- ✅ DevContainer configuration loaded in VS Code
- ✅ All validation scripts pass

**Validation Commands**:
```bash
# Test application response
curl -f http://localhost:18080/health

# Test database connectivity
docker-compose exec web-app php artisan migrate:status

# Test development tools
docker-compose exec web-app ./vendor/bin/pint --test
```

### Scenario 2: Code Changes with Hot-Reload

**Given**: Development environment running
**When**: Modifying YokaKit application files
**Then**:
- ✅ Changes reflected immediately without container restart
- ✅ Laravel debugging works properly
- ✅ Quality tools provide immediate feedback

**Validation Commands**:
```bash
# Make a test change
echo "// Test change" >> ./YokaKit/app/Http/Controllers/Controller.php

# Verify hot-reload (should see change immediately)
docker-compose exec web-app cat /var/www/html/app/Http/Controllers/Controller.php

# Revert test change
git checkout -- ./YokaKit/app/Http/Controllers/Controller.php
```

### Scenario 3: Model Relocation Verification

**Given**: Structural improvements completed
**When**: Checking model file locations
**Then**:
- ✅ All models in app/Models directory
- ✅ No model files in app/Http/Requests
- ✅ Application functionality preserved

**Validation Commands**:
```bash
# Check models are in correct location
find ./YokaKit/app/Models -name '*.php' | wc -l

# Verify no models in wrong location
find ./YokaKit/app/Http/Requests -name '*Config.php' -o -name '*Model.php'

# Test application still works
docker-compose exec web-app php artisan route:list
```

### Scenario 4: Constitutional Compliance

**Given**: Any development activity
**When**: Running constitutional compliance validation
**Then**:
- ✅ YokaKit identity preserved (no PinkieIt references)
- ✅ GitHub issues have constitutional labels
- ✅ PinkieIt commit references maintained

**Validation Commands**:
```bash
# Run constitutional compliance check
./scripts/validation/constitutional-compliance.sh

# Check GitHub labels (requires gh CLI)
gh label list | grep constitutional

# Verify no PinkieIt branding
grep -r "PinkieIt" --exclude-dir=.git --exclude-dir=pinkieit .
```

## Common Issues & Solutions

### Issue: Docker Services Won't Start

**Symptoms**: `docker-compose up` fails or services show "Exited" status

**Solutions**:
```bash
# Check Docker Desktop is running
docker version

# Clear Docker system (nuclear option)
docker system prune -a --volumes

# Rebuild containers
docker-compose down -v
docker-compose up -d --build --force-recreate
```

### Issue: Port 18080 Already in Use

**Symptoms**: "Port 18080 is already allocated" error

**Solutions**:
```bash
# Find process using port
lsof -i :18080  # macOS/Linux
netstat -ano | findstr :18080  # Windows

# Kill process or change port in docker-compose.yml
# Modify ports: "18081:80" instead of "18080:80"
```

### Issue: Database Connection Refused

**Symptoms**: Laravel shows database connection errors

**Solutions**:
```bash
# Check database service health
docker-compose exec database mysqladmin ping -h localhost

# Restart database service
docker-compose restart database

# Check environment variables
docker-compose exec web-app printenv | grep DB_
```

### Issue: VS Code DevContainer Won't Open

**Symptoms**: DevContainer fails to build or start

**Solutions**:
```bash
# Ensure Docker is running and accessible
docker ps

# Rebuild DevContainer
# Command Palette: "Dev Containers: Rebuild Container"

# Check DevContainer configuration
cat .devcontainer/devcontainer.json
```

### Issue: Model Relocation Breaks Application

**Symptoms**: Class not found errors after model relocation

**Solutions**:
```bash
# Clear Laravel caches
docker-compose exec web-app php artisan optimize:clear

# Regenerate autoload files
docker-compose exec web-app composer dump-autoload

# Check namespace declarations
grep -r "namespace App\\Http\\Requests" ./YokaKit/app/Models/
```

## Performance Optimization

### Faster Docker Builds

```bash
# Use BuildKit for faster builds
export DOCKER_BUILDKIT=1

# Enable Docker Compose BuildKit
export COMPOSE_DOCKER_CLI_BUILD=1

# Use build cache
docker-compose build --no-cache web-app  # Only when needed
```

### Development Efficiency

```bash
# Keep containers running between sessions
docker-compose stop  # Instead of down

# Use specific service commands
docker-compose exec web-app php artisan migrate  # Faster than full restart

# Monitor resource usage
docker-compose top
docker stats
```

## Troubleshooting Commands

### Environment Diagnostics

```bash
# Complete system check
./scripts/validation/run-all-validations.sh

# Docker environment health
docker-compose ps
docker-compose logs --tail=50

# Laravel application health
docker-compose exec web-app php artisan about
docker-compose exec web-app php artisan config:show database

# GitHub management status
gh repo view
gh label list | head -10
```

### Reset Environment

```bash
# Soft reset (preserve data)
docker-compose restart

# Hard reset (lose data)
docker-compose down -v
rm -rf ./YokaKit/vendor ./YokaKit/node_modules
docker-compose up -d --build
```

## Next Steps

After successful setup:

1. **Explore Documentation**: Review `docs/` directory for detailed guides
2. **Run Tests**: Execute `docker-compose exec web-app php artisan test`
3. **Check Quality**: Run `./scripts/validation/development-quality.sh`
4. **Create Issues**: Use GitHub templates with constitutional compliance
5. **Start Development**: Begin working on Phase 1 tasks

## Support

- **Documentation**: See `docs/` directory for comprehensive guides
- **Issues**: Create GitHub issues with constitutional compliance labels
- **Validation**: Run validation scripts for immediate feedback
- **Community**: Follow constitutional principles for all contributions

---

**Quick Setup Complete**: YokaKit development environment ready for Phase 1 Docker Foundation implementation!