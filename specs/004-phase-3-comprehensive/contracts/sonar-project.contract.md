# SonarQube Configuration Contract

**Source**: PinkieIt commit 33dcda8 (Phase B)
**Target**: YokaKit `sonar-project.properties`
**Purpose**: SonarQube Cloud integration for code quality monitoring

---

## Configuration Structure

### PinkieIt Reference (commit 33dcda8)

```properties
sonar.projectKey=org.pinkieit:pinkieit
sonar.projectName=PinkieIt
sonar.projectVersion=1.0

sonar.sources=app/laravel/app
sonar.tests=app/laravel/tests

sonar.php.coverage.reportPaths=app/laravel/coverage.xml
sonar.php.tests.reportPath=app/laravel/test-results.xml

sonar.sourceEncoding=UTF-8
sonar.exclusions=**/vendor/**,**/node_modules/**
```

---

### YokaKit Contract

```properties
sonar.projectKey=org.yokakit:yokakit
sonar.projectName=YokaKit
sonar.projectVersion=1.0

sonar.sources=app/laravel/app
sonar.tests=app/laravel/tests

sonar.php.coverage.reportPaths=app/laravel/coverage.xml
sonar.php.tests.reportPath=app/laravel/test-results.xml

sonar.sourceEncoding=UTF-8
sonar.exclusions=**/vendor/**,**/node_modules/**
```

---

## Constitutional Adaptations

### Project Key
- **PinkieIt**: `sonar.projectKey=org.pinkieit:pinkieit`
- **YokaKit**: `sonar.projectKey=org.yokakit:yokakit`
- **Reason**: SonarQube Cloud project identity

### Project Name
- **PinkieIt**: `sonar.projectName=PinkieIt`
- **YokaKit**: `sonar.projectName=YokaKit`
- **Reason**: Display name in SonarQube dashboard

---

## Validation Criteria

- [ ] `sonar-project.properties` exists at repository root
- [ ] Project key is `org.yokakit:yokakit`
- [ ] Project name is "YokaKit"
- [ ] Coverage report path points to `app/laravel/coverage.xml`
- [ ] SonarQube Cloud project created with matching key
- [ ] GitHub Actions workflow uploads coverage to SonarQube
- [ ] Quality gate passes (A rating target)

---

## GitHub Actions Integration

**Workflow**: `.github/workflows/sonarqube.yml`

```yaml
name: SonarQube Analysis

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  sonarqube:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: Run Tests with Coverage
        run: |
          cd app/laravel
          php artisan test --coverage-clover=coverage.xml
      
      - name: SonarQube Scan
        uses: SonarSource/sonarqube-scan-action@master
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST_URL: https://sonarcloud.io
```

**Constitutional Adaptations**:
- Workflow references YokaKit paths
- SONAR_TOKEN stored in GitHub Secrets (YokaKit organization)

---

**Contract Version**: 1.0
**Last Updated**: 2025-10-04
