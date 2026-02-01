#!/bin/bash
# Daily Review Script for Tellus (Restaurant GM Agent)
# Runs after business closes to analyze daily operations
# Called by run-review.sh which spawns an agent for the actual analysis

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE="/home/zemi/clawd"
MEMORY_DIR="${WORKSPACE}/memory"
DATA_DIR="${WORKSPACE}/brickhouse/data"

# Date handling
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)

echo "=== Tellus Daily Review ==="
echo "Date: ${TODAY}"
echo "Analyzing: ${YESTERDAY}"
echo ""

# Ensure memory directory exists
mkdir -p "${MEMORY_DIR}"

# Check for required scripts and data
echo "Checking for Toast sales data..."
TOAST_DATA=""
if [ -f "${DATA_DIR}/toast_sales_${YESTERDAY}.json" ]; then
    TOAST_DATA="${DATA_DIR}/toast_sales_${YESTERDAY}.json"
elif [ -f "${DATA_DIR}/toast_sales_latest.json" ]; then
    TOAST_DATA="${DATA_DIR}/toast_sales_latest.json"
fi

if [ -n "${TOAST_DATA}" ]; then
    echo "  ✓ Found Toast sales data: ${TOAST_DATA}"
else
    echo "  ⚠ No Toast sales data found for ${YESTERDAY}"
fi

# Check vendor email status
echo "Checking vendor emails..."
VENDOR_EMAIL_SCRIPT="${WORKSPACE}/brickhouse/check_gmail_bills.py"
if [ -f "${VENDOR_EMAIL_SCRIPT}" ]; then
    echo "  ✓ Vendor email checker found"
else
    echo "  ⚠ Vendor email checker not found at ${VENDOR_EMAIL_SCRIPT}"
fi

# Check for previous day notes
PREV_NOTES="${MEMORY_DIR}/${YESTERDAY}.md"
if [ -f "${PREV_NOTES}" ]; then
    echo "  ✓ Found notes from ${YESTERDAY}"
else
    echo "  ⚠ No notes found for ${YESTERDAY}"
fi

# Check MEMORY.md exists
MEMORY_FILE="${WORKSPACE}/MEMORY.md"
if [ -f "${MEMORY_FILE}" ]; then
    echo "  ✓ Found MEMORY.md"
else
    echo "  ⚠ MEMORY.md not found (will be created)"
fi

echo ""
echo "=== Review Complete ==="
echo "Now spawning agent for detailed analysis..."
echo ""

# The actual analysis is done by the agent spawned via run-review.sh
# This script just sets up the environment and does preliminary checks
