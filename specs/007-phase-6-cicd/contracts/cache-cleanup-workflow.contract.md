# Cache Cleanup Workflow Contract

**Source**: PinkieIt commit 6bb70e1 (2025-07-04)
**Target**: YokaKit `.github/workflows/cache-cleanup.yml`

## Workflow Configuration

### Triggers

**PinkieIt Reference** (commit 6bb70e1):
```yaml
on:
  schedule:
    # Run weekly on Sundays at 2 AM UTC
    - cron: '0 2 * * 0'
  workflow_dispatch:  # Manual execution
```

**YokaKit Contract**:
```yaml
# Identical configuration
on:
  schedule:
    # Run weekly on Sundays at 2 AM UTC
    - cron: '0 2 * * 0'
  workflow_dispatch:  # Manual execution
```

**Adaptations**:
- None required (generic schedule)

**Validation**:
- [ ] Cron schedule is every Sunday at 2 AM UTC
- [ ] Manual dispatch enabled for on-demand cleanup

---

## Cleanup Job

**PinkieIt Reference** (commit 6bb70e1):
```yaml
jobs:
  cleanup:
    runs-on: ubuntu-latest
    permissions:
      actions: write
      contents: read
```

**YokaKit Contract**:
```yaml
# Identical configuration
jobs:
  cleanup:
    runs-on: ubuntu-latest
    permissions:
      actions: write  # Required for cache deletion
      contents: read
```

**Adaptations**:
- None required

**Validation**:
- [ ] Permissions include actions:write for cache API access
- [ ] Runs on ubuntu-latest

---

## Cleanup Steps

### Step 1: Delete Old Caches

**Contract**:
```yaml
- name: Cleanup old GitHub Actions caches
  run: |
    echo "Starting cache cleanup..."

    # Get all caches older than 7 days (604800 seconds)
    gh api repos/${{ github.repository }}/actions/caches \
      --jq '.actions_caches[] | select(.created_at < (now - 604800 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | .id' \
      > old_cache_ids.txt

    # Delete old caches
    if [ -s old_cache_ids.txt ]; then
      echo "Found $(wc -l < old_cache_ids.txt) old caches to delete"
      while read cache_id; do
        echo "Deleting cache ID: $cache_id"
        gh api repos/${{ github.repository }}/actions/caches/$cache_id -X DELETE || true
      done < old_cache_ids.txt
    else
      echo "No old caches found to delete"
    fi
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Logic**:
1. Query GitHub API for all caches
2. Filter caches created before 7 days ago (604800 seconds)
3. Extract cache IDs to file
4. Loop through IDs and delete each cache
5. Continue on deletion errors (|| true)

**Validation**:
- [ ] Age threshold is exactly 7 days (604800 seconds)
- [ ] Uses jq for JSON parsing
- [ ] GITHUB_TOKEN has actions:write permission
- [ ] Deletion continues on individual cache errors
- [ ] Repository reference uses ${{ github.repository }} (automatic YokaKit)

---

### Step 2: Report Cache Status

**Contract**:
```yaml
- name: Report cache status
  run: |
    echo "Current cache usage:"
    gh api repos/${{ github.repository }}/actions/caches \
      --jq '.actions_caches | length'

    echo "Cache sizes:"
    gh api repos/${{ github.repository }}/actions/caches \
      --jq '.actions_caches[] | "\(.key): \(.size_in_bytes / 1024 / 1024 | floor)MB"'
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Output Format**:
```
Current cache usage:
12

Cache sizes:
Linux-buildx-production-a1b2c3d: 245MB
Linux-buildx-development-a1b2c3d: 198MB
...
```

**Validation**:
- [ ] Reports total cache count
- [ ] Reports individual cache sizes in MB
- [ ] Uses jq for JSON parsing
- [ ] Repository reference automatic via ${{ github.repository }}

---

## Cache Lifecycle Management

### Age Policy

| Cache Age | Action |
|-----------|--------|
| < 7 days | Retained (active builds) |
| ≥ 7 days | Deleted (stale caches) |

**Rationale**:
- Active development typically uses caches within 7 days
- Older caches unlikely to be reused
- Prevents storage quota exhaustion

### Scope Preservation

**Protected Scopes** (from docker-build.yml):
- `production`: Production environment caches
- `development`: Development environment caches

**Cleanup Behavior**:
- Deletes ALL caches older than 7 days (regardless of scope)
- No scope-specific retention policies
- Assumes active builds refresh caches within 7 days

---

## GitHub API Endpoints Used

### 1. List Caches
```bash
gh api repos/${{ github.repository }}/actions/caches
```

**Response Schema**:
```json
{
  "actions_caches": [
    {
      "id": 123,
      "key": "Linux-buildx-production-abc123",
      "created_at": "2025-10-01T00:00:00Z",
      "size_in_bytes": 256000000
    }
  ]
}
```

### 2. Delete Cache
```bash
gh api repos/${{ github.repository }}/actions/caches/{cache_id} -X DELETE
```

**Response**: 204 No Content (success)

**Validation**:
- [ ] API endpoints use correct repository path
- [ ] GITHUB_TOKEN has sufficient permissions
- [ ] JQ queries return expected data format

---

## Error Handling

### Deletion Failures

**Contract**:
```bash
gh api repos/${{ github.repository }}/actions/caches/$cache_id -X DELETE || true
```

**Behavior**:
- Individual deletion failures do not stop cleanup
- `|| true` ensures loop continues
- Errors logged but not fatal

**Common Errors**:
- Cache already deleted (404): Continue
- Permission denied (403): Continue (log warning)
- API rate limit (429): May affect completion

**Validation**:
- [ ] Deletion errors do not stop workflow
- [ ] All cache IDs attempted regardless of failures

---

## Adaptations Summary

**YokaKit-Specific Changes**:
- ✅ Repository reference uses ${{ github.repository }} (automatic YokaKit)
- ✅ No hardcoded "pinkieit" references
- ✅ Generic cache cleanup logic (scope-agnostic)

**Validation Checklist**:
- [ ] Workflow triggers weekly on Sundays at 2 AM UTC
- [ ] Manual dispatch available for on-demand cleanup
- [ ] Deletes caches older than 7 days (604800 seconds)
- [ ] Reports cache usage after cleanup
- [ ] GITHUB_TOKEN has actions:write permission
- [ ] Deletion failures do not stop cleanup process
- [ ] Repository path automatic via GitHub context

---

## Expected Behavior

### Successful Cleanup (with old caches)
```
Starting cache cleanup...
Found 5 old caches to delete
Deleting cache ID: 123
Deleting cache ID: 124
Deleting cache ID: 125
Deleting cache ID: 126
Deleting cache ID: 127
Current cache usage:
8
Cache sizes:
Linux-buildx-production-a1b2c3d: 245MB
Linux-buildx-development-a1b2c3d: 198MB
...
```

### Successful Cleanup (no old caches)
```
Starting cache cleanup...
No old caches found to delete
Current cache usage:
13
Cache sizes:
...
```

**Validation**:
- [ ] Output shows deletion count or "no old caches" message
- [ ] Cache usage report displays after cleanup
- [ ] Workflow completes successfully

---

**Created**: 2025-10-04
**Based on**: PinkieIt commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
