# Docker Compose Configuration Contract

**Source**: PinkieIt commit f9340aa (docker-compose.yml → compose.yml rename)
**Target**: YokaKit/compose.yml
**Purpose**: Docker Compose v2 service orchestration with YokaKit naming

## Service Contracts

### web-app Service

**PinkieIt Original** (commit f9340aa):
```yaml
services:
  web-app:
    image: pinkieit-web-app
    container_name: pinkieit-web-app
    build:
      context: .
      dockerfile: Dockerfile
      target: production
    volumes:
      - ./app/laravel:/var/www/html
      - ./storage:/var/www/html/storage
    ports:
      - "18080:80"
    depends_on:
      db:
        condition: service_healthy
      mqtt:
        condition: service_started
    networks:
      - pinkieit
```

**YokaKit Contract**:
```yaml
services:
  web-app:
    image: yokakit-web-app
    container_name: yokakit-web-app
    build:
      context: .
      dockerfile: Dockerfile
      target: production
    volumes:
      - ./app/laravel:/var/www/html
      - ./storage:/var/www/html/storage
    ports:
      - "18080:80"
    depends_on:
      db:
        condition: service_healthy
      mqtt:
        condition: service_started
    networks:
      - yokakit
```

**Constitutional Adaptations**:
- `image`: pinkieit-web-app → **yokakit-web-app**
- `container_name`: pinkieit-web-app → **yokakit-web-app**
- `networks`: pinkieit → **yokakit**

**Validation**:
- [ ] Image name uses "yokakit" prefix
- [ ] Container name uses "yokakit" prefix
- [ ] Network name is "yokakit"
- [ ] Dockerfile reference points to root Dockerfile
- [ ] Depends on db (healthy) and mqtt (started)
- [ ] Port 18080 exposed for HTTP

---

### db Service (Inherited from Phase 1)

**YokaKit Contract** (no changes in Phase 2):
```yaml
  db:
    image: mariadb:10.11.4
    container_name: yokakit-db
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_DATABASE: yokakit
      MYSQL_USER: ${DB_USERNAME}
      MYSQL_PASSWORD: ${DB_PASSWORD}
    volumes:
      - yokakit_db_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - yokakit
```

**Constitutional Compliance**:
- ✅ Container name: yokakit-db (already compliant from Phase 1)
- ✅ Database name: yokakit (identity preserved)
- ✅ Volume name: yokakit_db_data
- ✅ Network: yokakit

**Validation**:
- [ ] MariaDB 10.11.4 image
- [ ] Database name is "yokakit"
- [ ] Healthcheck functional
- [ ] Volume persists data

---

### mqtt Service (Inherited from Phase 1)

**YokaKit Contract** (no changes in Phase 2):
```yaml
  mqtt:
    image: eclipse-mosquitto:latest
    container_name: yokakit-mqtt-broker
    volumes:
      - ./mqtt/mosquitto/config:/mosquitto/config
      - ./mqtt/mosquitto/data:/mosquitto/data
      - ./mqtt/mosquitto/log:/mosquitto/log
    ports:
      - "18830:1883"
      - "9001:9001"
    networks:
      - yokakit
```

**Constitutional Compliance**:
- ✅ Container name: yokakit-mqtt-broker (already compliant from Phase 1)
- ✅ Network: yokakit

**Validation**:
- [ ] Eclipse Mosquitto latest image
- [ ] Configuration mounted from ./mqtt/mosquitto/config
- [ ] Port 18830 (MQTT) and 9001 (WebSocket) exposed

---

## Network Contract

**PinkieIt Original**:
```yaml
networks:
  pinkieit:
    driver: bridge
```

**YokaKit Contract**:
```yaml
networks:
  yokakit:
    driver: bridge
```

**Constitutional Adaptation**:
- Network name: pinkieit → **yokakit**

**Validation**:
- [ ] Network named "yokakit"
- [ ] Bridge driver
- [ ] All services connected to "yokakit" network

---

## Volume Contract

**YokaKit Contract** (inherited from Phase 1):
```yaml
volumes:
  yokakit_db_data:
    driver: local
```

**Constitutional Compliance**:
- ✅ Volume name: yokakit_db_data (already compliant from Phase 1)

**Validation**:
- [ ] Volume named "yokakit_db_data"
- [ ] Local driver
- [ ] Database data persists across container restarts

---

## File Naming Contract

**PinkieIt Original**: `docker-compose.yml`
**YokaKit Target**: `compose.yml`

**Reason**: Docker Compose v2 naming convention (commit f9340aa)

**Validation**:
- [ ] File named `compose.yml` (not `docker-compose.yml`)
- [ ] Works with `docker compose` command (v2)
- [ ] Works with `docker-compose` command (v1 backward compatibility)

---

## Constitutional Compliance Summary

**All Naming Adaptations**:
1. Image: pinkieit-web-app → yokakit-web-app
2. Container (web-app): pinkieit-web-app → yokakit-web-app
3. Network: pinkieit → yokakit
4. Filename: docker-compose.yml → compose.yml

**Inherited YokaKit Naming** (Phase 1):
- Container (db): yokakit-db ✅
- Container (mqtt): yokakit-mqtt-broker ✅
- Database name: yokakit ✅
- Volume: yokakit_db_data ✅

**Verification Command**:
```bash
# Ensure no "pinkieit" references
grep -i "pinkieit" compose.yml
# Expected: No results
```

**Validation**:
- [ ] No "pinkieit" references in compose.yml
- [ ] All services use "yokakit" naming
- [ ] Constitutional identity preserved

---

## Startup Contract

**Startup Command**:
```bash
docker compose up -d
```

**Expected Behavior**:
1. Network "yokakit" created
2. Volume "yokakit_db_data" created
3. Service "db" starts, healthcheck passes
4. Service "mqtt" starts
5. Service "web-app" starts (after db healthy, mqtt started)

**Validation**:
```bash
# Check all services running
docker compose ps

# Expected output:
# NAME                  IMAGE                 STATUS
# yokakit-web-app       yokakit-web-app       Up
# yokakit-db            mariadb:10.11.4       Up (healthy)
# yokakit-mqtt-broker   eclipse-mosquitto     Up
```

**Validation Criteria**:
- [ ] All 3 services in "Up" state
- [ ] db service shows "(healthy)" status
- [ ] HTTP accessible at http://localhost:18080
- [ ] MQTT accessible at localhost:18830

---

**Contract Version**: 1.0
**Last Updated**: 2025-10-03
**PinkieIt Reference**: f9340aabdec7954898386f61c509ed3e6a541e4f
