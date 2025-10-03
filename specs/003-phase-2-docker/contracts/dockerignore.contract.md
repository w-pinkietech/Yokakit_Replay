# .dockerignore Configuration Contract

**Source**: PinkieIt commit b980f1e
**Target**: YokaKit/.dockerignore (root directory)
**Purpose**: Optimize Docker build context by excluding unnecessary files

## Contract Specification

**PinkieIt Reference** (commit b980f1e, 124 lines):
```dockerignore
# Git files
.git
.gitignore
.gitattributes
.gitmodules

# Node.js
node_modules
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.npm

# PHP/Composer
vendor/
composer.phar
composer.lock
phpunit.xml

# Development & Testing
tests/
*.test.php
.phpunit.result.cache
coverage/

# IDE & Editor configurations
.vscode/
.idea/
*.swp
*.swo
*~

# OS-specific files
.DS_Store
Thumbs.db
desktop.ini

# Environment & Secrets
.env
.env.*
!.env.example

# Logs
*.log
logs/
storage/logs/

# Cache & Temporary files
.cache/
tmp/
temp/
*.tmp

# Build artifacts
dist/
build/
public/hot
public/storage

# Documentation (non-runtime)
README.md
CHANGELOG.md
CONTRIBUTING.md
LICENSE
docs/

# CI/CD configurations
.github/
.gitlab-ci.yml
.travis.yml
azure-pipelines.yml

# Docker files (don't include in image)
docker-compose.yml
compose.yml
Dockerfile
.dockerignore

# Project management
.specify/
specs/

# (... additional categories totaling 124 lines)
```

**YokaKit Contract**: **Identical** (no constitutional adaptations required)

**Reason**: .dockerignore contains generic file patterns with no PinkieIt/YokaKit-specific naming

---

## Category Breakdown

**124 lines organized into categories**:

1. **Git files** (4 lines): .git, .gitignore, .gitattributes, .gitmodules
2. **Node.js dependencies** (6 lines): node_modules, npm logs, yarn logs, .npm
3. **PHP/Composer** (5 lines): vendor/, composer files, phpunit.xml
4. **Development & Testing** (8 lines): tests/, test files, coverage reports
5. **IDE configurations** (12 lines): .vscode, .idea, Vim swap files, etc.
6. **OS-specific** (4 lines): .DS_Store, Thumbs.db, desktop.ini
7. **Environment files** (4 lines): .env (except .env.example)
8. **Logs** (5 lines): *.log, logs/, storage/logs/
9. **Cache & Temporary** (8 lines): .cache, tmp/, temp/, *.tmp
10. **Build artifacts** (6 lines): dist/, build/, public/hot, public/storage
11. **Documentation** (6 lines): README, CHANGELOG, docs/
12. **CI/CD** (8 lines): .github/, .gitlab-ci.yml, .travis.yml, etc.
13. **Docker files** (5 lines): docker-compose.yml, Dockerfile, .dockerignore
14. **Project management** (4 lines): .specify/, specs/
15. **Miscellaneous** (~49 lines): Additional file types and patterns

---

## Build Context Impact

**Before .dockerignore**:
- Build context: ~500MB (estimated)
- Includes: node_modules (~200MB), vendor (~100MB), Git history (~50MB), IDE configs, logs

**After .dockerignore**:
- Build context: ~50MB (estimated)
- Includes: Only application source code and .env.example

**Performance Improvement**:
- Build context transfer: ~90% reduction
- Build time improvement: 30-50% faster (especially on slow networks)

---

## Constitutional Compliance

**PinkieIt References**: None
**YokaKit Adaptations**: None required

**Validation**:
```bash
# Check for PinkieIt references
grep -i "pinkieit" .dockerignore
# Expected: No results

# Verify .dockerignore syntax
docker build --no-cache -t test . 2>&1 | grep "dockerignore"
# Expected: No syntax errors
```

**Validation Criteria**:
- [ ] File contains 124 lines (exact match to PinkieIt b980f1e)
- [ ] No "pinkieit" or "PinkieIt" references
- [ ] Docker accepts .dockerignore syntax without errors
- [ ] Build context size significantly reduced (verify with `docker build` output)

---

## Validation Commands

**Check build context size**:
```bash
# Without .dockerignore (for comparison)
mv .dockerignore .dockerignore.bak
docker build --no-cache -t test . 2>&1 | grep "Sending build context"
# Output: Sending build context to Docker daemon  500MB (approx)

# With .dockerignore
mv .dockerignore.bak .dockerignore
docker build --no-cache -t test . 2>&1 | grep "Sending build context"
# Output: Sending build context to Docker daemon  50MB (approx)
```

**Verify excluded files**:
```bash
# Build and inspect image layers
docker build -t test .
docker run --rm test ls -la /var/www/html

# Should NOT contain:
# - .git/
# - node_modules/ (only in build stage, not final image)
# - tests/
# - .vscode/
# - .env (only .env.example)
```

**Validation Criteria**:
- [ ] Build context reduced to <100MB
- [ ] Excluded files not present in final image
- [ ] .env.example present (whitelisted with `!.env.example`)

---

## Implementation Notes

**File Location**: Root directory (same level as Dockerfile)

**Direct Copy**: This file can be copied directly from PinkieIt b980f1e without modifications

**No Dependencies**: .dockerignore is independent of other Docker configuration files

**Compatibility**: Works with all Docker versions (Docker 1.7+)

---

**Contract Version**: 1.0
**Last Updated**: 2025-10-03
**PinkieIt Reference**: b980f1eef1c628962186f7e18012c1330a55b579
**Constitutional Status**: No adaptations required (generic patterns)
