#!/bin/bash
# YokaKit Repository Milestone Setup Script
# Purpose: Create Phase 0-6 milestones in YokaKit repository
# Usage: ./scripts/github/setup-yokakit-milestones.sh

set -e

REPO="w-pinkietech/YokaKit"

echo "📍 YokaKit Repository Milestone Setup"
echo "Repository: $REPO"
echo ""

# Function to create milestone
create_milestone() {
    local title="$1"
    local description="$2"
    local due_date="$3"

    echo "Creating milestone: $title"
    if [ -n "$due_date" ]; then
        gh api repos/"$REPO"/milestones -f title="$title" -f description="$description" -f due_on="$due_date" || echo "  ⚠️  Milestone may already exist: $title"
    else
        gh api repos/"$REPO"/milestones -f title="$title" -f description="$description" || echo "  ⚠️  Milestone may already exist: $title"
    fi
}

echo "Creating Phase Milestones..."
echo ""

# Phase 0: GitHub Repository Infrastructure (Completed)
create_milestone \
    "Phase 0: GitHub Repository Infrastructure" \
    "GitHub repository initialization with proper submodule setup, branch protection, workflows, and constitutional compliance framework. Status: Completed ✅" \
    ""

# Phase 1: Docker Foundation & Development Environment (4 weeks)
create_milestone \
    "Phase 1: Docker Foundation & Development Environment" \
    "Docker infrastructure (PHP 8.2 + Apache + MariaDB), DevContainer integration, model relocation (app/Http/Requests → app/Models), and quality infrastructure foundation. Duration: 4 weeks. Reference: PinkieIt commit a5d3b77" \
    "2025-10-26T23:59:59Z"

# Phase 2: Quality Infrastructure Day (1 day)
create_milestone \
    "Phase 2: Quality Infrastructure Day" \
    "Concentrated 1-day implementation of PHPUnit, PCOV coverage, Larastan static analysis, SonarQube integration, and comprehensive CI/CD quality pipeline. Reference: PinkieIt 2025-06-13 pattern (8 PRs in single day)" \
    ""

# Phase 3: Comprehensive Testing (2 weeks)
create_milestone \
    "Phase 3: Comprehensive Testing" \
    "Complete testing implementation across all layers (models, services, repositories, controllers), parallel execution optimization (66% improvement target), and test cleanup. Duration: 2 weeks. Reference: PinkieIt Jun 14-15, 2025" \
    ""

# Phase 4: Framework Modernization (1 week)
create_milestone \
    "Phase 4: Framework Modernization" \
    "PHP 8.2 upgrade, Laravel 10.x migration, dependency updates, and Laravel Reverb WebSocket modernization. Duration: 1 week. Reference: PinkieIt Jun 16-24, 2025" \
    ""

# Phase 5: Advanced Docker Optimization (1 week)
create_milestone \
    "Phase 5: Advanced Docker Optimization" \
    "Multi-stage Dockerfile consolidation, multi-architecture support (AMD64/ARM64), build time optimization, and DevContainer integration enhancement. Duration: 1 week. Reference: PinkieIt Jun 26 - Jul 2, 2025" \
    ""

# Phase 6: CI/CD Integration & Final Polish (1 week)
create_milestone \
    "Phase 6: CI/CD Integration & Final Polish" \
    "Comprehensive CI/CD pipeline (multi-architecture builds, security scanning), Bootstrap 5 UI migration, and final quality validation for v1.0.0 release. Duration: 1 week. Reference: PinkieIt Jul 3, 2025+" \
    ""

echo ""
echo "✅ Milestone creation complete!"
echo ""
echo "Validation command:"
echo "  gh api repos/$REPO/milestones --jq '.[] | {title, state, number}'"
echo ""
echo "Next steps:"
echo "  1. Verify milestones created: gh api repos/$REPO/milestones"
echo "  2. Create Phase 1 Epic issue and assign to Phase 1 milestone"
echo "  3. Begin Story/Task issue creation for implementation"
