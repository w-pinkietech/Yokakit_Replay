# Dockerfile Multi-Stage Build Contract

**Source**: PinkieIt commits f9340aa, fe2acac, 08ac389
**Target**: YokaKit/Dockerfile (root directory)
**Purpose**: Multi-stage build consolidating docker/base and docker/app

## Contract Specification

### Stage 1: base

**PinkieIt Reference** (commit 08ac389, final version):
```dockerfile
FROM php:8.2-apache AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html
```

**YokaKit Contract**: Identical (no naming adaptations required)

**Validation**:
- [ ] PHP 8.2-apache base image
- [ ] All system packages installed
- [ ] All PHP extensions enabled
- [ ] Apache mod_rewrite enabled
- [ ] Working directory set to /var/www/html

---

### Stage 2: build

**PinkieIt Reference** (commit 08ac389, with BuildKit cache mounts):
```dockerfile
FROM base AS build

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Copy dependency files
COPY app/laravel/composer.json app/laravel/composer.lock ./

# Install PHP dependencies with cache mount
RUN --mount=type=cache,target=/root/.composer/cache \
    composer install --no-dev --no-scripts --no-autoloader --prefer-dist

# Copy package files
COPY app/laravel/package*.json ./

# Install Node dependencies with cache mount
RUN --mount=type=cache,target=/root/.npm \
    npm ci --production

# Copy application code
COPY app/laravel .

# Generate optimized autoloader
RUN composer dump-autoload --optimize

# Build frontend assets
RUN npm run production
```

**YokaKit Contract**: Identical (no naming adaptations required)

**Validation**:
- [ ] Composer installed from official image
- [ ] Node.js 18.x installed
- [ ] BuildKit cache mounts functional (composer, npm)
- [ ] Dependencies installed before app code (layer optimization)
- [ ] Frontend assets compiled successfully

---

### Stage 3: production (default)

**PinkieIt Reference** (commit 08ac389):
```dockerfile
FROM base AS production

# Copy vendor from build stage
COPY --from=build /var/www/html/vendor ./vendor

# Copy node_modules from build stage
COPY --from=build /var/www/html/node_modules ./node_modules

# Copy public assets from build stage
COPY --from=build /var/www/html/public ./public

# Copy application code
COPY app/laravel .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
```

**YokaKit Contract**: Identical (no naming adaptations required)

**Validation**:
- [ ] Only runtime dependencies included (no build tools)
- [ ] Compiled assets copied from build stage
- [ ] Application code present
- [ ] Storage permissions set correctly
- [ ] Apache starts successfully on port 80

---

## Constitutional Adaptations

### Comment Header

**PinkieIt Original** (commit f9340aa):
```dockerfile
# Multi-stage Dockerfile for PinkieIt
```

**YokaKit Adapted**:
```dockerfile
# Multi-stage Dockerfile for YokaKit
```

**Location**: Line 1 of Dockerfile
**Validation**: [ ] Comment references "YokaKit" not "PinkieIt"

---

## Build Requirements

### Environment Variables

**Required**:
```bash
export DOCKER_BUILDKIT=1
```

**Reason**: BuildKit cache mounts (--mount=type=cache) introduced in commit fe2acac

**Validation**: [ ] Build fails gracefully without BuildKit, with clear error message

### Build Command

**Development**:
```bash
docker build --target development -t yokakit-web-app:dev .
```

**Production** (default):
```bash
docker build -t yokakit-web-app:latest .
```

**Validation**:
- [ ] Development target builds successfully
- [ ] Production target builds successfully (default)
- [ ] Image tagged as yokakit-web-app (not pinkieit-web-app)

---

## Deprecation Notice

**Files Replaced** by this Dockerfile:
- `docker/base/Dockerfile` - Consolidated into base stage
- `docker/app/apache/sites-available/000-default.conf` - Consolidated into base stage
- `docker/app/php/local.ini` - Consolidated into base stage

**Migration Path**:
1. Verify new Dockerfile contains all docker/base configurations
2. Verify new Dockerfile contains all docker/app configurations
3. Delete docker/base/ directory
4. Delete docker/app/ directory

**Validation**:
- [ ] All Phase 1 docker/base functionality present
- [ ] All Phase 1 docker/app functionality present
- [ ] No references to docker/base or docker/app in YokaKit codebase

---

**Contract Version**: 1.0
**Last Updated**: 2025-10-03
**PinkieIt Reference**: 08ac3897e478078d254e1ca54c8f244216d1862b
