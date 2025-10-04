# Composer Dependencies Contract

**Source**: PinkieIt commits e0eaabd, 4152b54, 862d537
**Target**: YokaKit `app/laravel/composer.json`

## PHP 8.2 Upgrade (e0eaabd)

**PinkieIt Reference**:
```json
{
    "require": {
        "php": "^8.2.0"
    },
    "require-dev": {
        "larastan/larastan": "^2.0"
    }
}
```

**YokaKit Contract**:
```json
{
    "require": {
        "php": "^8.2.0"
    },
    "require-dev": {
        "larastan/larastan": "^2.0"
    }
}
```

**Changes from Current**:
- `"php": "^8.1.0"` → `"php": "^8.2.0"`
- `"nunomaduro/larastan": "^2.0"` → `"larastan/larastan": "^2.0"` (package migration)

**Validation**:
- [ ] PHP requirement is ^8.2.0
- [ ] Larastan package is larastan/larastan (not nunomaduro/larastan)
- [ ] Composer install succeeds with PHP 8.2
- [ ] All dependencies resolve without conflicts

---

## Laravel 10 Framework Upgrade (4152b54)

**PinkieIt Reference**:
```json
{
    "require": {
        "php": "^8.2.0",
        "laravel/framework": "^10.0",
        "laravel/sanctum": "^3.2",
        "laravel/ui": "^4.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "laravel/dusk": "^7.0",
        "nunomaduro/collision": "^7.0",
        "spatie/laravel-ignition": "^2.0"
    }
}
```

**YokaKit Contract**:
```json
{
    "require": {
        "php": "^8.2.0",
        "laravel/framework": "^10.0",
        "laravel/sanctum": "^3.2",
        "laravel/ui": "^4.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "laravel/dusk": "^7.0",
        "nunomaduro/collision": "^7.0",
        "spatie/laravel-ignition": "^2.0"
    }
}
```

**Changes from Current**:
- `"laravel/framework": "^9.19"` → `"laravel/framework": "^10.0"`
- `"laravel/sanctum": "^2.14"` → `"laravel/sanctum": "^3.2"`
- `"laravel/ui": "^3.4"` → `"laravel/ui": "^4.0"`
- `"phpunit/phpunit": "^9.5.10"` → `"phpunit/phpunit": "^10.0"`
- `"laravel/dusk": "^6.25"` → `"laravel/dusk": "^7.0"`
- `"nunomaduro/collision": "^6.1"` → `"nunomaduro/collision": "^7.0"`
- `"spatie/laravel-ignition": "^1.0"` → `"spatie/laravel-ignition": "^2.0"`

**Validation**:
- [ ] Laravel Framework 10.48.29+ installed
- [ ] Laravel Sanctum 3.2+ installed
- [ ] Laravel UI 4.0+ installed
- [ ] PHPUnit 10.0+ installed
- [ ] Laravel Dusk 7.0+ installed
- [ ] Collision 7.0+ installed
- [ ] Spatie Ignition 2.0+ installed
- [ ] All dependencies resolve without conflicts

---

## Laravel 10 Completion (862d537)

**PinkieIt Reference** (AdminLTE update):
```json
{
    "require": {
        "jeroennoten/laravel-adminlte": "^3.15"
    }
}
```

**YokaKit Contract**:
```json
{
    "require": {
        "jeroennoten/laravel-adminlte": "^3.15"
    }
}
```

**Changes from Current**:
- `"jeroennoten/laravel-adminlte": "^3.8"` → `"jeroennoten/laravel-adminlte": "^3.15"`

**Validation**:
- [ ] AdminLTE 3.15+ installed
- [ ] AdminLTE datatable component functional
- [ ] All AdminLTE Blade components compatible

---

## Laravel Reverb Installation (d4db04f)

**PinkieIt Reference**:
```json
{
    "require": {
        "laravel/reverb": "^1.4"
    }
}
```

**YokaKit Contract**:
```json
{
    "require": {
        "laravel/reverb": "^1.4"
    }
}
```

**Changes from Current**:
- Add new dependency: `"laravel/reverb": "^1.4"`

**Validation**:
- [ ] Laravel Reverb 1.4+ installed
- [ ] Reverb config/reverb.php published
- [ ] Reverb broadcasting connection functional

---

## Legacy WebSockets Removal (524c1c3)

**PinkieIt Reference** (package removal):
```json
{
    "require": {
        // REMOVED: "beyondcode/laravel-websockets": "^1.14"
        // REMOVED: "pusher/pusher-php-server": "^7.0"
    }
}
```

**YokaKit Contract**:
```json
{
    "require": {
        // Ensure these packages are NOT present
    }
}
```

**Changes from Current**:
- Remove: `"beyondcode/laravel-websockets"` (if present)
- Remove: `"pusher/pusher-php-server"` (if present)

**Validation**:
- [ ] beyondcode/laravel-websockets package NOT in composer.json
- [ ] pusher/pusher-php-server package NOT in composer.json
- [ ] Composer install does NOT install WebSockets packages

---

## Complete Composer Dependencies Contract

**Final State** (all commits applied):
```json
{
    "name": "yokakit/yokakit",
    "type": "project",
    "description": "YokaKit Application",
    "require": {
        "php": "^8.2.0",
        "laravel/framework": "^10.0",
        "laravel/sanctum": "^3.2",
        "laravel/ui": "^4.0",
        "laravel/reverb": "^1.4",
        "jeroennoten/laravel-adminlte": "^3.15"
        // ... other existing dependencies
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "laravel/dusk": "^7.0",
        "nunomaduro/collision": "^7.0",
        "spatie/laravel-ignition": "^2.0",
        "larastan/larastan": "^2.0"
        // ... other existing dev dependencies
    },
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "Tests\\": "tests/"
        }
    },
    "scripts": {
        "post-autoload-dump": [
            "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
            "@php artisan package:discover --ansi"
        ],
        "post-update-cmd": [
            "@php artisan vendor:publish --tag=laravel-assets --ansi --force"
        ],
        "post-root-package-install": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ],
        "post-create-project-cmd": [
            "@php artisan key:generate --ansi"
        ]
    },
    "config": {
        "optimize-autoloader": true,
        "preferred-install": "dist",
        "sort-packages": true,
        "allow-plugins": {
            "php-http/discovery": true
        }
    },
    "minimum-stability": "stable",
    "prefer-stable": true
}
```

**Key Version Requirements**:
- PHP: ^8.2.0
- Laravel: ^10.0
- Sanctum: ^3.2
- UI: ^4.0
- Reverb: ^1.4
- AdminLTE: ^3.15
- PHPUnit: ^10.0
- Dusk: ^7.0
- Collision: ^7.0
- Ignition: ^2.0
- Larastan: ^2.0

**Removed Packages**:
- nunomaduro/larastan (replaced by larastan/larastan)
- beyondcode/laravel-websockets (replaced by laravel/reverb)
- pusher/pusher-php-server (WebSockets dependency)

---

## Validation Checklist

### PHP & Core Framework
- [ ] PHP requirement: ^8.2.0
- [ ] Laravel Framework: ^10.0 (version 10.48.29+)
- [ ] Laravel Sanctum: ^3.2
- [ ] Laravel UI: ^4.0
- [ ] Laravel Reverb: ^1.4

### Testing Framework
- [ ] PHPUnit: ^10.0
- [ ] Laravel Dusk: ^7.0
- [ ] Collision: ^7.0
- [ ] Spatie Ignition: ^2.0

### UI & Quality Tools
- [ ] AdminLTE: ^3.15
- [ ] Larastan: ^2.0 (package: larastan/larastan)

### Package Removal
- [ ] nunomaduro/larastan NOT present (replaced)
- [ ] beyondcode/laravel-websockets NOT present (removed)
- [ ] pusher/pusher-php-server NOT present (removed)

### Composer Operations
- [ ] `composer install` succeeds with PHP 8.2
- [ ] `composer update` resolves all dependencies
- [ ] No conflicts or version incompatibilities
- [ ] Autoload optimization enabled
- [ ] All post-install scripts execute successfully

### Constitutional Compliance
- [ ] No PinkieIt-specific package names
- [ ] Package name is "yokakit/yokakit" (if specified)
- [ ] No PinkieIt references in package metadata

---

**Created**: 2025-10-04
**Source**: PinkieIt commits e0eaabd, 4152b54, 862d537, d4db04f, 524c1c3
**Target**: YokaKit `app/laravel/composer.json`
