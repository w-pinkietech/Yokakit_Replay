#!/bin/bash
# YokaKit Repository Label Migration Script
# Purpose: Create 4-tier label hierarchy in YokaKit repository
# Usage: ./scripts/github/setup-yokakit-labels.sh

set -e

REPO="w-pinkietech/YokaKit"

echo "🏷️  YokaKit Repository Label Migration"
echo "Repository: $REPO"
echo ""

# Epic Level Labels (Phase Tracking)
echo "Creating Epic Level Labels (Phase Tracking)..."
gh label create "epic:phase-0" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 0 repository setup" || echo "  ⚠️  Label already exists: epic:phase-0"
gh label create "epic:phase-1" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 1 Docker + Laravel" || echo "  ⚠️  Label already exists: epic:phase-1"
gh label create "epic:phase-2" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 2 CI/CD Pipeline" || echo "  ⚠️  Label already exists: epic:phase-2"
gh label create "epic:phase-3" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 3 Testing & Quality" || echo "  ⚠️  Label already exists: epic:phase-3"
gh label create "epic:phase-4" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 4 WebSocket & MQTT" || echo "  ⚠️  Label already exists: epic:phase-4"
gh label create "epic:phase-5" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 5 Security & Performance" || echo "  ⚠️  Label already exists: epic:phase-5"
gh label create "epic:phase-6" --repo "$REPO" --color "0052cc" --description "Epic-level tracking for Phase 6 CI/CD Integration" || echo "  ⚠️  Label already exists: epic:phase-6"
echo "✅ Epic level labels created (7 labels)"
echo ""

# Story Level Labels (Feature Grouping)
echo "Creating Story Level Labels (Feature Grouping)..."
gh label create "story:feature" --repo "$REPO" --color "0e8a16" --description "Story-level feature development tracking" || echo "  ⚠️  Label already exists: story:feature"
gh label create "story:security" --repo "$REPO" --color "0e8a16" --description "Story-level security implementation tracking" || echo "  ⚠️  Label already exists: story:security"
gh label create "story:ci-cd" --repo "$REPO" --color "0e8a16" --description "Story-level CI/CD automation tracking" || echo "  ⚠️  Label already exists: story:ci-cd"
gh label create "story:integration" --repo "$REPO" --color "0e8a16" --description "Story-level integration development tracking" || echo "  ⚠️  Label already exists: story:integration"
gh label create "story:documentation" --repo "$REPO" --color "0e8a16" --description "Story-level documentation development tracking" || echo "  ⚠️  Label already exists: story:documentation"
echo "✅ Story level labels created (5 labels)"
echo ""

# Task Level Labels (Work Units)
echo "Creating Task Level Labels (Work Units)..."
gh label create "task:implementation" --repo "$REPO" --color "fbca04" --description "Task-level implementation work tracking" || echo "  ⚠️  Label already exists: task:implementation"
gh label create "task:validation" --repo "$REPO" --color "fbca04" --description "Task-level validation and verification work" || echo "  ⚠️  Label already exists: task:validation"
gh label create "task:testing" --repo "$REPO" --color "fbca04" --description "Task-level testing and QA work" || echo "  ⚠️  Label already exists: task:testing"
echo "✅ Task level labels created (3 labels)"
echo ""

# Constitutional Level Labels (Compliance Tracking)
echo "Creating Constitutional Level Labels (Compliance Tracking)..."
gh label create "constitutional:identity-preservation" --repo "$REPO" --color "5319e7" --description "YokaKit identity preservation requirement (NON-NEGOTIABLE)" || echo "  ⚠️  Label already exists: constitutional:identity-preservation"
gh label create "constitutional:historical-fidelity" --repo "$REPO" --color "5319e7" --description "PinkieIt historical fidelity replay requirement" || echo "  ⚠️  Label already exists: constitutional:historical-fidelity"
gh label create "constitutional:quality-first" --repo "$REPO" --color "5319e7" --description "Quality-first implementation requirement" || echo "  ⚠️  Label already exists: constitutional:quality-first"
gh label create "constitutional:compliance" --repo "$REPO" --color "5319e7" --description "General constitutional compliance requirement" || echo "  ⚠️  Label already exists: constitutional:compliance"
echo "✅ Constitutional level labels created (4 labels)"
echo ""

# Status Management Labels
echo "Creating Status Management Labels..."
gh label create "status:needs-triage" --repo "$REPO" --color "d93f0b" --description "Issue requires initial evaluation and assignment" || echo "  ⚠️  Label already exists: status:needs-triage"
gh label create "status:in-progress" --repo "$REPO" --color "1d76db" --description "Issue is actively being worked on" || echo "  ⚠️  Label already exists: status:in-progress"
gh label create "status:blocked" --repo "$REPO" --color "b60205" --description "Issue blocked by dependencies or external factors" || echo "  ⚠️  Label already exists: status:blocked"
echo "✅ Status management labels created (3 labels)"
echo ""

echo "🎉 Label migration complete!"
echo "Total labels created: 22 (Epic: 7, Story: 5, Task: 3, Constitutional: 4, Status: 3)"
echo ""
echo "Validation command:"
echo "  gh label list --repo $REPO | wc -l"
echo ""
echo "Next steps:"
echo "  1. Create milestones: ./scripts/github/setup-yokakit-milestones.sh"
echo "  2. Create Phase 1 Epic issue in YokaKit repository"
echo "  3. Begin implementation following specs/002-phase-1-docker/plan.md"
