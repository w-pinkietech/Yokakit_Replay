# YokaKit Technical Baseline: Current System Assessment

**Generated**: 2025-09-27
**Repository**: [w-pinkietech/YokaKit](https://github.com/w-pinkietech/YokaKit.git)
**Snapshot ID**: `520b3b67d27f90ed3ecedb5f4ab427affb6d79ff` (2025-09-04)
**Purpose**: Technical baseline documentation for YokaKit system architecture and current state
**Scope**: What IS the current system (technical facts only)

## Executive Summary

YokaKit is a comprehensive **Production Management System (MES)** designed for manufacturing floor monitoring with real-time production tracking, visual management (Andon boards), and IoT device integration. The system contains 93 PHP files and 45 database migrations representing 9 years of manufacturing domain development.

### Technical Profile
- ✅ **Functional Scope**: Complete MES with IoT integration
- ⚠️ **Structural Architecture**: Non-standard Laravel file organization
- 📊 **Framework Version**: Laravel 9.x
- 📊 **Infrastructure**: No containerization present
- 📊 **Testing**: No test framework configured

---

## System Profile

### 🎯 **Basic Information**
| Attribute | Value |
|-----------|-------|
| **Project Name** | YokaKit (生産進捗管理システム) |
| **Repository** | https://github.com/w-pinkietech/YokaKit.git |
| **Current Branch** | `feature/setup_claude.md` |
| **Available Branches** | `main`, `develop`, `feature/setup_claude.md` |
| **Laravel Version** | 9.19+ |
| **PHP Version** | 8.0.2+ |
| **Last Significant Update** | September 4, 2025 (Merge PR #1) |

### 📊 **Codebase Metrics**
- **PHP Files**: 93 files
- **Database Migrations**: 45 migrations
- **Controllers**: 25+ controllers
- **Jobs**: 7 background jobs
- **Enums**: 5 enumeration classes
- **Views**: 100+ Blade templates
- **JavaScript Dependencies**: 20+ frontend packages

---

## Technical Architecture Analysis

### 🏗️ **Framework & Dependencies**

#### **Backend Stack**
```json
{
  "laravel/framework": "^9.19",
  "php": "^8.0.2",
  "beyondcode/laravel-websockets": "^1.13",
  "php-mqtt/laravel-client": "^1.0",
  "jeroennoten/laravel-adminlte": "^3.8",
  "spatie/laravel-data": "^3.6",
  "laravel/sanctum": "^2.14.1"
}
```

#### **Frontend Stack**
```json
{
  "bootstrap": "~4.6.0",
  "jquery": "^3.6.0",
  "chart.js": "^3.9.1",
  "laravel-echo": "^1.13.1",
  "laravel-mix": "^6.0.49",
  "pusher-js": "^7.4.0"
}
```

## Structural Issues Identification

### 🚨 **Critical Architecture Problems**

#### **1. Model Architecture Non-Compliance**
```bash
# Current Issue
app/Http/Requests/AndonConfig.php  # Model incorrectly located
# Controllers reference App\Models\* namespace but files don't exist in app/Models/

# Evidence
Expected: app/Models/
Actual: app/Http/Requests/ (contains model classes)
Namespace: App\Models (correct)
Location: Wrong directory
```

#### **2. Missing Standard Directories**
```bash
# Laravel 9+ Expected Structure vs Actual
Expected:                 Actual:
app/Models/              ❌ Missing
tests/                   ❌ Missing
app/Http/Requests/       ✅ Exists (but contains models)
app/Http/Controllers/    ✅ Exists
```

#### **3. Legacy Structure Patterns**
- **Pre-Laravel 8 organization**: Models not in dedicated directory
- **Mixed concerns**: Request validation and data models combined
- **Autoloading complexity**: Non-standard file placement

### 🎯 **Core Functional Domains**

#### **1. Production Management**
- **Controllers**: `ProcessController`, `ProductionHistoryController`
- **Entities**: Production, Process, Line management
- **Features**: Real-time production tracking, efficiency metrics
- **Database Tables**: 45+ specialized manufacturing tables

#### **2. IoT & Sensor Integration**
- **Controllers**: `SensorController`, `RaspberryPiController`
- **Communication**: MQTT client integration
- **Hardware**: Raspberry Pi device management
- **Real-time**: WebSocket-based sensor data streaming

#### **3. Andon System (Visual Management)**
- **Controllers**: `AndonController`
- **Configuration**: `AndonConfig` model with display customization
- **Features**: Factory floor status visualization
- **UI Components**: Configurable dashboard layouts

#### **4. Quality Management**
- **Entities**: `DefectiveProduction`, quality metrics
- **Analytics**: OEE calculation, cycle time analysis
- **Reporting**: Production history and trend analysis

#### **5. Workforce Management**
- **Controllers**: `WorkerController`, `UserController`
- **Authentication**: Laravel Sanctum integration
- **Authorization**: Role-based access control
- **Scheduling**: Worker assignment and shift management

### 📡 **Real-time & Communication**

#### **WebSocket Implementation**
- **Package**: `beyondcode/laravel-websockets` v1.13
- **Port**: 6001 (configurable)
- **Features**: Multi-tenancy, dashboard monitoring
- **Status**: Legacy package (alternative: Laravel Reverb)

#### **MQTT Integration**
- **Package**: `php-mqtt/laravel-client` v1.0
- **Purpose**: IoT device communication
- **Jobs**: Background processing for sensor data
- **Events**: Real-time notifications and alarms

### 🎨 **User Interface**

#### **UI Framework**
- **Theme**: AdminLTE 3 dashboard
- **CSS Framework**: Bootstrap 4.6
- **Charts**: Chart.js v3.9.1
- **Data Tables**: DataTables with Bootstrap integration
- **Icons**: FontAwesome 6.1.2

#### **Localization**
- **Languages**: Japanese (primary), English
- **Components**: Custom validation messages, enum translations
- **Admin Interface**: Fully localized AdminLTE components

---

## Database Architecture

### 📊 **Migration Timeline**
- **Total Migrations**: 45 files
- **Creation Period**: 2014-2023 (9 years of evolution)
- **Latest Changes**: September 27, 2023
- **Complexity**: Extensive manufacturing domain model

### 🗄️ **Key Database Tables**
```sql
-- Core Production Tables
productions, processes, lines
production_histories, production_lines
defective_productions

-- IoT & Hardware
sensors, sensor_events
raspberry_pis, on_offs, on_off_events
payloads

-- Configuration & Management
andon_configs, andon_layouts
part_numbers, cycle_times
planned_outages, process_planned_outages
workers, users

-- Queue & Communication
jobs, failed_jobs
websockets_statistics_entries
```

### 🔗 **Data Relationships**
- **Complex Production Flow**: Multi-stage manufacturing processes
- **Sensor Integration**: Real-time data collection and event processing
- **Historical Tracking**: Comprehensive audit trails and analytics
- **Configuration Management**: Flexible Andon display customization

---

## Development Environment Status

### 🔧 **Current Tooling**
- **Node.js**: v22.11.0 ✅
- **Package Manager**: npm with package-lock.json
- **Build Tool**: Laravel Mix v6.0.49
- **Asset Compilation**: Sass, PostCSS, webpack

### ❌ **Missing Infrastructure**
```bash
# Critical Missing Components
Docker/                  ❌ No containerization
.devcontainer/           ❌ No development container
tests/                   ❌ No testing framework
.github/workflows/       ❌ No CI/CD pipelines
phpunit.xml             ✅ Exists but no tests/
composer scripts        ❌ Limited automation
```

### 🔍 **Code Quality Status**
- **Static Analysis**: ❌ No PHPStan/Larastan
- **Code Formatting**: ❌ No Laravel Pint
- **Testing Framework**: ❌ No test infrastructure
- **CI/CD**: ❌ No automation pipelines
- **Documentation**: ❌ Minimal documentation

---

## Conclusion

YokaKit represents a **functionally sophisticated MES system** with 9 years of manufacturing domain expertise embedded in its 45 database migrations and comprehensive IoT integration. The system demonstrates advanced capabilities in production tracking, visual management, and real-time communication.

### 📋 **Technical Summary**
- **Domain Expertise**: Comprehensive manufacturing ERP/MES functionality
- **Architecture Maturity**: Feature-complete but structurally non-standard
- **Integration Depth**: Advanced IoT, MQTT, and real-time capabilities
- **Infrastructure Gap**: No modern development or deployment infrastructure

### 🔍 **Key Technical Insights**
- **Model Misplacement**: Primary structural issue requiring reorganization
- **Legacy WebSocket**: Functional but outdated real-time implementation
- **Missing Testing**: No quality assurance infrastructure
- **Framework Currency**: Laravel 9.x base suitable for modernization

**Note**: For implementation strategy and modernization planning, refer to `development-timeline-analysis.md`.

---

**Last Updated**: 2025-09-27
**Analysis Scope**: Technical baseline documentation only