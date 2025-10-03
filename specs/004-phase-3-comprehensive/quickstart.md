# Phase 3: Comprehensive Testing - Quickstart Guide

## Prerequisites

**From PinkieIt Commits**:
- Docker environment operational (Phase 1)
- YokaKit application running (Phase 2)
- PHP 8.2 + Laravel 9 environment
- MariaDB 10.11.4 database
- Composer and npm installed

---

## 15-Minute Setup

### Step 1: Clone and Checkout (2 min)

```bash
cd /mnt/shared_data/YokaKit_Replay/YokaKit
git checkout 004-phase-3-comprehensive  # After implementation
```

### Step 2: Configure Test Environment (3 min)

**Based on**: PinkieIt commit 1b98e44

```bash
cd app/laravel

# Copy test environment template
cp .env.example .env.test

# Edit .env.test with YokaKit settings
# Change:
# APP_NAME=YokaKit
# DB_DATABASE=yokakit_test
```

### Step 3: Create Test Database (2 min)

```bash
# Enter database container
docker compose exec db mysql -u root -p

# Create test database
CREATE DATABASE yokakit_test;
GRANT ALL PRIVILEGES ON yokakit_test.* TO 'yokakit'@'%';
FLUSH PRIVILEGES;
EXIT;
```

### Step 4: Install Test Dependencies (5 min)

**Based on**: PinkieIt Phase A-B commits

```bash
# Install PHP dependencies (includes PHPUnit, PCOV, Larastan)
composer install --dev

# Generate application key for testing
php artisan key:generate --env=testing
```

### Step 5: Run Tests (3 min)

```bash
# Run all tests
php artisan test

# Expected output:
# Tests:  XX passed
# Time:   XX.XXs
```

---

## Validation

### Constitutional Compliance

```bash
# Verify YokaKit identity preserved
grep -r "pinkieit" tests/ --exclude-dir=vendor
# Expected: No results

# Verify APP_NAME in .env.test
grep "APP_NAME" .env.test
# Expected: APP_NAME=YokaKit

# Verify test database name
grep "DB_DATABASE" .env.test
# Expected: DB_DATABASE=yokakit_test
```

### Test Execution

```bash
# Run unit tests only
php artisan test --testsuite=Unit

# Run feature tests only
php artisan test --testsuite=Feature

# Run tests with coverage
php artisan test --coverage

# Expected: Coverage report generated at coverage.xml
```

---

## Troubleshooting

**Issue**: `Database 'yokakit_test' doesn't exist`
**Solution**: Create test database (Step 3)

**Issue**: `Class 'Tests\TestCase' not found`
**Solution**: Run `composer dump-autoload`

**Issue**: Tests fail with foreign key constraints
**Solution**: Ensure `RefreshDatabase` trait is used in test classes

**Issue**: Parallel execution crashes
**Solution**: Reduce process count in `phpunit.xml` (Phase F)

---

## Next Steps

1. Review implementation plan in `plan.md`
2. Execute Phase A (Test Infrastructure) tasks
3. Validate each phase before proceeding to next

---

**Quickstart Guide Version**: 1.0
**Last Updated**: 2025-10-04
**Estimated Setup Time**: 15 minutes
