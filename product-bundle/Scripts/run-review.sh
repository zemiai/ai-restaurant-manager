#!/bin/bash
# Wrapper script to spawn an agent for daily review
# This is the main entry point called by cron

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE="/home/zemi/clawd"
MEMORY_DIR="${WORKSPACE}/memory"

TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
LOG_FILE="${SCRIPT_DIR}/review-${YESTERDAY}.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "${LOG_FILE}"
}

log "=== Starting Daily Review for ${YESTERDAY} ==="

# Read previous day notes if available
PREV_NOTES=""
if [ -f "${MEMORY_DIR}/${YESTERDAY}.md" ]; then
    PREV_NOTES=$(cat "${MEMORY_DIR}/${YESTERDAY}.md")
fi

# Read memory for context
MEMORY_CONTENT=""
if [ -f "${WORKSPACE}/MEMORY.md" ]; then
    MEMORY_CONTENT=$(cat "${WORKSPACE}/MEMORY.md")
fi

# Check Toast sales data
TOAST_DATA=""
TOAST_SUMMARY=""
if [ -f "${WORKSPACE}/brickhouse/data/toast_sales_${YESTERDAY}.json" ]; then
    TOAST_DATA=$(cat "${WORKSPACE}/brickhouse/data/toast_sales_${YESTERDAY}.json")
    TOAST_SUMMARY="Found Toast sales data for ${YESTERDAY}"
elif [ -f "${WORKSPACE}/brickhouse/data/toast_sales_latest.json" ]; then
    TOAST_DATA=$(cat "${WORKSPACE}/brickhouse/data/toast_sales_latest.json")
    TOAST_SUMMARY="Using latest Toast sales data"
else
    TOAST_SUMMARY="No Toast sales data available"
fi

# Check for vendor emails
VENDOR_ALERTS=""
if [ -f "${WORKSPACE}/brickhouse/data/vendors/pending_alerts.md" ]; then
    VENDOR_ALERTS=$(cat "${WORKSPACE}/brickhouse/data/vendors/pending_alerts.md")
fi

# Build the prompt for the agent
PROMPT="You are Tellus, a restaurant GM agent. Perform a daily review for ${YESTERDAY}.

## Task
Analyze operations data and create a comprehensive review that updates institutional memory.

## Available Data

### Toast Sales Data:
${TOAST_SUMMARY}
${TOAST_DATA:0:3000}

### Vendor Email Alerts:
${VENDOR_ALERTS:-None}

### Previous Day Notes:
${PREV_NOTES:-No notes available for ${YESTERDAY}}

### Long-term Memory:
${MEMORY_CONTENT:0:4000}

## Required Actions

1. **Analyze Toast Sales** (if data available):
   - Total revenue vs targets
   - Top selling items
   - Slow periods or issues
   - Any anomalies

2. **Review Vendor Emails**:
   - Check for invoices, price changes, delivery issues
   - Flag urgent items needing attention

3. **Update Today's Notes** (${MEMORY_DIR}/${TODAY}.md):
   - Document key learnings from ${YESTERDAY}
   - Note any operational issues
   - Record sales performance metrics

4. **Update MEMORY.md** with:
   - Recurring patterns observed
   - Seasonal trends
   - Staff performance notes
   - Vendor reliability patterns

5. **Create Tomorrow's Brief**:
   - Key items to focus on
   - Anticipated busy periods
   - Any prep needed based on patterns

## Output Requirements

Write output to these files:
- ${MEMORY_DIR}/${TODAY}.md (today's notes with yesterday's learnings)
- ${WORKSPACE}/MEMORY.md (updated with recurring patterns)
- ${SCRIPT_DIR}/brief-${TODAY}.md (tomorrow's briefing)

## Rules
- Do NOT modify any critical configs
- Flag items needing your attention with [ATTENTION]
- Be concise but thorough
- Focus on actionable insights

Return a summary of what you found and updated."

log "Spawning agent for review..."

# Use sessions_spawn to run the review
# The actual implementation depends on how sessions_spawn is available
if command -v sessions_spawn &> /dev/null; then
    echo "${PROMPT}" | sessions_spawn --model mini --prompt "You are a restaurant GM agent performing daily review." 2>&1 | tee -a "${LOG_FILE}"
elif [ -f "${WORKSPACE}/bin/sessions_spawn" ]; then
    echo "${PROMPT}" | "${WORKSPACE}/bin/sessions_spawn" --model mini 2>&1 | tee -a "${LOG_FILE}"
else
    # Fallback: create a detailed prompt file for manual review
    log "sessions_spawn not available, creating prompt file for manual review"
    echo "${PROMPT}" > "${SCRIPT_DIR}/pending-review-${TODAY}.prompt"
    log "Created pending review prompt at ${SCRIPT_DIR}/pending-review-${TODAY}.prompt"
fi

log "=== Daily Review Complete ==="
log "Check ${MEMORY_DIR}/${TODAY}.md and ${WORKSPACE}/MEMORY.md for updates"
