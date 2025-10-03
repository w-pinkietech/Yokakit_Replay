# PHPUnit Configuration Contract

**Source**: PinkieIt commit 92dbdab (Phase A)
**Target**: YokaKit `app/laravel/phpunit.xml`
**Purpose**: PHPUnit test runner configuration with coverage reporting

---

## Configuration Structure

### PinkieIt Reference (commit 92dbdab)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="./vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/autoload.php"
         colors="true">
    <testsuites>
        <testsuite name="Unit">
            <directory suffix="Test.php">./tests/Unit</directory>
        </testsuite>
        <testsuite name="Feature">
            <directory suffix="Test.php">./tests/Feature</directory>
        </testsuite>
    </testsuites>
    <coverage processUncoveredFiles="true">
        <include>
            <directory suffix=".php">./app</directory>
        </include>
        <report>
            <clover outputFile="coverage.xml"/>
            <html outputDirectory="coverage-html"/>
        </report>
    </coverage>
    <php>
        <server name="APP_ENV" value="testing"/>
        <server name="DB_CONNECTION" value="mysql"/>
        <server name="DB_DATABASE" value="pinkieit_test"/>
    </php>
</phpunit>
```

---

### YokaKit Contract

```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="./vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/autoload.php"
         colors="true">
    <testsuites>
        <testsuite name="Unit">
            <directory suffix="Test.php">./tests/Unit</directory>
        </testsuite>
        <testsuite name="Feature">
            <directory suffix="Test.php">./tests/Feature</directory>
        </testsuite>
    </testsuites>
    <coverage processUncoveredFiles="true">
        <include>
            <directory suffix=".php">./app</directory>
        </include>
        <report>
            <clover outputFile="coverage.xml"/>
            <html outputDirectory="coverage-html"/>
        </report>
    </coverage>
    <php>
        <server name="APP_ENV" value="testing"/>
        <server name="APP_NAME" value="YokaKit"/>
        <server name="DB_CONNECTION" value="mysql"/>
        <server name="DB_DATABASE" value="yokakit_test"/>
    </php>
</phpunit>
```

---

## Constitutional Adaptations

### Database Configuration
- **PinkieIt**: `<server name="DB_DATABASE" value="pinkieit_test"/>`
- **YokaKit**: `<server name="DB_DATABASE" value="yokakit_test"/>`
- **Reason**: Identity preservation (yokakit database naming)

### Application Name
- **PinkieIt**: (not specified in original)
- **YokaKit**: `<server name="APP_NAME" value="YokaKit"/>`
- **Reason**: Ensure test environment references YokaKit branding

---

## Validation Criteria

- [ ] PHPUnit configuration file exists at `app/laravel/phpunit.xml`
- [ ] Test suites defined: Unit, Feature
- [ ] Coverage reporting enabled (Clover XML + HTML)
- [ ] Test database name is `yokakit_test`
- [ ] APP_NAME environment variable is "YokaKit"
- [ ] `php artisan test` command executes successfully
- [ ] Coverage report generated at `app/laravel/coverage.xml`

---

## Phase F Enhancement (Parallel Execution)

**Added in**: Commit f7b8b01 (2025-06-18)

```xml
<!-- Add after <coverage> section -->
<extensions>
    <extension class="ParaTest\Extension">
        <arguments>
            <integer>4</integer> <!-- process count -->
        </arguments>
    </extension>
</extensions>
```

**Validation**:
- [ ] Parallel execution reduces test time by ~66%
- [ ] All tests pass in parallel mode with same results as sequential

---

**Contract Version**: 1.0
**Last Updated**: 2025-10-04
