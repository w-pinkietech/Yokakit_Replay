# Laravel Reverb Configuration Contract

**Source**: PinkieIt commits d4db04f (installation), 524c1c3 (legacy removal)
**Target**: YokaKit `app/laravel/config/reverb.php`, `app/laravel/config/broadcasting.php`

## Reverb Server Configuration

**PinkieIt Reference** (commit d4db04f):
```php
// config/reverb.php
return [
    'default' => env('REVERB_SERVER', 'reverb'),

    'servers' => [
        'reverb' => [
            'host' => env('REVERB_SERVER_HOST', '0.0.0.0'),
            'port' => env('REVERB_SERVER_PORT', 8080),
            'path' => env('REVERB_SERVER_PATH', ''),
            'hostname' => env('REVERB_HOST'),
            'options' => [
                'tls' => [],
            ],
            'max_request_size' => env('REVERB_MAX_REQUEST_SIZE', 10_000),
            'scaling' => [
                'enabled' => env('REVERB_SCALING_ENABLED', false),
                'channel' => env('REVERB_SCALING_CHANNEL', 'reverb'),
                'server' => [
                    'url' => env('REDIS_URL'),
                    'host' => env('REDIS_HOST', '127.0.0.1'),
                    'port' => env('REDIS_PORT', '6379'),
                    'username' => env('REDIS_USERNAME'),
                    'password' => env('REDIS_PASSWORD'),
                    'database' => env('REDIS_DB', '0'),
                ],
            ],
            'pulse_ingest_interval' => env('REVERB_PULSE_INGEST_INTERVAL', 15),
            'telescope_ingest_interval' => env('REVERB_TELESCOPE_INGEST_INTERVAL', 15),
        ],
    ],
];
```

**YokaKit Contract**:
```php
// Same configuration (no PinkieIt-specific content)
```

**Validation**:
- [ ] File exists: `app/laravel/config/reverb.php`
- [ ] Default server: 'reverb'
- [ ] Server host: env('REVERB_SERVER_HOST', '0.0.0.0')
- [ ] Server port: env('REVERB_SERVER_PORT', 8080)
- [ ] Max request size: 10,000 bytes default
- [ ] Scaling configuration present (Redis)
- [ ] Pulse and Telescope intervals configured

---

## Reverb Application Configuration

**PinkieIt Reference** (commit d4db04f):
```php
// config/reverb.php
return [
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
                    'useTLS' => env('REVERB_SCHEME', 'https') === 'https',
                ],
                'allowed_origins' => ['*'],
                'ping_interval' => env('REVERB_APP_PING_INTERVAL', 60),
                'activity_timeout' => env('REVERB_APP_ACTIVITY_TIMEOUT', 30),
                'max_message_size' => env('REVERB_APP_MAX_MESSAGE_SIZE', 10_000),
            ],
        ],
    ],
];
```

**YokaKit Contract**:
```php
// Same configuration (no PinkieIt-specific content)
```

**Validation**:
- [ ] Apps provider: 'config'
- [ ] App key from env: REVERB_APP_KEY
- [ ] App secret from env: REVERB_APP_SECRET
- [ ] App ID from env: REVERB_APP_ID
- [ ] Default port: 443 (HTTPS)
- [ ] Allowed origins: ['*'] (all origins)
- [ ] Ping interval: 60 seconds default
- [ ] Activity timeout: 30 seconds default
- [ ] Max message size: 10,000 bytes default

---

## Broadcasting Configuration (Reverb Connection)

**PinkieIt Reference** (commit d4db04f):
```php
// config/broadcasting.php
return [
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
                'useTLS' => env('REVERB_SCHEME', 'http') === 'https',
            ],
            'client_options' => [
                // Guzzle client options: https://docs.guzzlephp.org/en/stable/request-options.html
            ],
        ],
    ],
];
```

**YokaKit Contract**:
```php
// Same configuration (no PinkieIt-specific content)
```

**Validation**:
- [ ] Connection 'reverb' exists in broadcasting.connections
- [ ] Driver: 'reverb'
- [ ] Credentials match reverb.php (key, secret, app_id)
- [ ] Default host: 0.0.0.0
- [ ] Default port: 8080 (HTTP development)
- [ ] Default scheme: 'http' (development)
- [ ] TLS based on scheme

---

## Environment Variables Contract

**Required Variables**:
```env
# Reverb Application Credentials
REVERB_APP_ID=your-app-id
REVERB_APP_KEY=your-app-key
REVERB_APP_SECRET=your-app-secret

# Reverb Server Configuration
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=8080

# Reverb Client Configuration (Broadcasting)
REVERB_HOST=localhost
REVERB_PORT=8080
REVERB_SCHEME=http

# Optional: Reverb Scaling (Redis)
REVERB_SCALING_ENABLED=false
REVERB_SCALING_CHANNEL=reverb

# Optional: Performance Tuning
REVERB_MAX_REQUEST_SIZE=10000
REVERB_APP_PING_INTERVAL=60
REVERB_APP_ACTIVITY_TIMEOUT=30
REVERB_APP_MAX_MESSAGE_SIZE=10000
```

**Validation**:
- [ ] REVERB_APP_ID set in .env
- [ ] REVERB_APP_KEY set in .env
- [ ] REVERB_APP_SECRET set in .env
- [ ] REVERB_HOST set in .env (localhost for development)
- [ ] REVERB_PORT matches DevContainer forwarded port (6002 external → 6001 internal → 8080 Reverb)
- [ ] REVERB_SCHEME is 'http' (development) or 'https' (production)

---

## Reverb Server Startup

**Command**:
```bash
php artisan reverb:start
```

**Options**:
```bash
# Start with custom host/port
php artisan reverb:start --host=0.0.0.0 --port=8080

# Start in debug mode
php artisan reverb:start --debug
```

**Validation**:
- [ ] Reverb server starts without errors
- [ ] Server listens on configured port (8080 default)
- [ ] WebSocket connections accepted
- [ ] Pusher protocol compatibility verified

---

## Legacy WebSockets Removal Contract

**PinkieIt Reference** (commit 524c1c3):
```php
// DELETED: config/websockets.php
// DELETED: database/migrations/*_create_websockets_statistics_entries_table.php
```

**YokaKit Contract**:
```
Files to Remove (if exist):
- app/laravel/config/websockets.php
- app/laravel/database/migrations/*_create_websockets_statistics_entries_table.php
```

**Validation**:
- [ ] config/websockets.php does NOT exist
- [ ] WebSockets statistics migration does NOT exist
- [ ] beyondcode/laravel-websockets package NOT in composer.json
- [ ] pusher/pusher-php-server package NOT in composer.json

---

## Pusher Protocol Compatibility

**Reverb Support**:
```javascript
// Frontend (Laravel Echo) - No changes required
import Echo from 'laravel-echo';
import Pusher from 'pusher-js';

window.Echo = new Echo({
    broadcaster: 'reverb',  // or 'pusher' (Reverb supports Pusher protocol)
    key: import.meta.env.VITE_REVERB_APP_KEY,
    wsHost: import.meta.env.VITE_REVERB_HOST,
    wsPort: import.meta.env.VITE_REVERB_PORT ?? 80,
    wssPort: import.meta.env.VITE_REVERB_PORT ?? 443,
    forceTLS: (import.meta.env.VITE_REVERB_SCHEME ?? 'https') === 'https',
    enabledTransports: ['ws', 'wss'],
});
```

**Validation**:
- [ ] Frontend Echo configuration uses Reverb credentials
- [ ] Pusher.js library compatible with Reverb
- [ ] WebSocket connections established successfully
- [ ] Broadcasting events work with existing frontend code

---

## Complete Validation Checklist

### Configuration Files
- [ ] config/reverb.php exists (93 lines)
- [ ] config/broadcasting.php includes 'reverb' connection
- [ ] config/websockets.php does NOT exist (removed)

### Reverb Server Settings
- [ ] Default server: 'reverb'
- [ ] Server host: 0.0.0.0 (all interfaces)
- [ ] Server port: 8080 (development)
- [ ] Scaling configuration: Redis-based (optional)

### Reverb Application Settings
- [ ] App provider: 'config'
- [ ] Credentials: key, secret, app_id from env
- [ ] Allowed origins: ['*'] (all origins)
- [ ] Ping interval: 60 seconds
- [ ] Activity timeout: 30 seconds

### Broadcasting Connection
- [ ] Connection name: 'reverb'
- [ ] Driver: 'reverb'
- [ ] Credentials match reverb.php config
- [ ] Default scheme: 'http' (development)

### Environment Variables
- [ ] REVERB_APP_ID set
- [ ] REVERB_APP_KEY set
- [ ] REVERB_APP_SECRET set
- [ ] REVERB_HOST set (localhost for dev)
- [ ] REVERB_PORT set (8080 or 6002 for DevContainer)
- [ ] REVERB_SCHEME set (http or https)

### Server Operations
- [ ] `php artisan reverb:start` executes successfully
- [ ] Reverb listens on configured port
- [ ] WebSocket connections accepted
- [ ] Broadcasting events delivered

### Legacy Cleanup
- [ ] config/websockets.php removed
- [ ] WebSockets migration removed
- [ ] beyondcode/laravel-websockets package removed
- [ ] pusher/pusher-php-server package removed

### Frontend Compatibility
- [ ] Laravel Echo configured for Reverb
- [ ] Pusher.js library compatible
- [ ] Existing WebSocket code works without changes

### DevContainer Integration
- [ ] Port 6002 forwarded (maps to 6001 internal → 8080 Reverb)
- [ ] Reverb starts in DevContainer environment
- [ ] WebSocket accessible from host machine

### Constitutional Compliance
- [ ] No PinkieIt-specific configuration
- [ ] All naming uses YokaKit conventions
- [ ] No hardcoded PinkieIt credentials

---

**Created**: 2025-10-04
**Source**: PinkieIt commits d4db04f (installation), 524c1c3 (cleanup)
**Target**: YokaKit Laravel Reverb configuration
