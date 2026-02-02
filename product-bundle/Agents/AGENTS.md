# AGENTS.md — Multi-Agent System Documentation

## Overview

The AI Restaurant Manager uses a **multi-agent architecture** inspired by Boris Cherny's system at SiteGPT. Multiple specialized agents work together, each with their own personality, memory, and responsibilities.

## The Agent Squad

| Agent | Role | Wakes | Handles |
|-------|------|-------|---------|
| **Tellus** | Coordinator/GM | 7 AM | Main interface, compiles briefs, escalation |
| **SalesAgent** | Sales Analyst | 2 AM | Revenue, trends, top sellers |
| **LaborAgent** | Labor Monitor | 2:05 AM | Labor %, scheduling, alerts |
| **VendorAgent** | Accounts Payable | 2:10 AM | Bills, due dates, invoices |
| **MenuAgent** | Menu Strategist | 2:15 AM | Profitability, pricing, performance |

## How They Work

### Each Agent Has:
1. **SOUL.md** - Personality and role definition
2. **Memory/** - Persistent memory files
3. **Reports/** - Output directory for findings
4. **Cron schedule** - Staggered wake times

### Coordination Flow

```
2:00 AM — SalesAgent runs
          ↓
          Writes report to /reports/sales/daily.md
          ↓
2:05 AM — LaborAgent runs
          Reads /data/toast/ for sales comparison
          ↓
          Writes report to /reports/labor/daily.md
          ↓
2:10 AM — VendorAgent scans Gmail
          ↓
          Writes report to /reports/expenses/daily.md
          ↓
2:15 AM — MenuAgent analyzes performance
          ↓
          Writes report to /reports/menu/daily.md
          ↓
7:00 AM — Tellus compiles all reports
          ↓
          Sends morning brief to Telegram
```

## Adding New Agents

### Step 1: Create Agent Directory
```bash
mkdir -p Agents/NewAgent
mkdir -p Agents/NewAgent/memory
```

### Step 2: Create SOUL.md
```markdown
# SOUL.md — New Agent Name

**Role:** Brief description

## Personality
...

## What You're Good At
...

## Commands You Handle
- "help me with X"
- "check Y"
```

### Step 3: Add Cron Job
```bash
# Add to CRON_SCHEDULE.md
20 2 * * * agent:newagent:main
```

### Step 4: Update Tellus Coordination
Add the new agent to Tellus's awareness in SOUL.md.

## Session Keys

Each agent maps to a session key in OpenClaw:

| Agent | Session Key |
|-------|-------------|
| Tellus | agent:tellus:main |
| SalesAgent | agent:sales:main |
| LaborAgent | agent:labor:main |
| VendorAgent | agent:vendor:main |
| MenuAgent | agent:menu:main |

## Message Routing

When you message Tellus:
- Direct requests → Tellus handles
- Sales questions → Tellus delegates to SalesAgent
- Labor questions → Tellus delegates to LaborAgent
- etc.

All agents read from shared `/reports/` directory.

## Best Practices

1. **Stagger cron jobs** - Prevent API spikes
2. **Each agent has one job** - Focus produces better results
3. **Shared reporting** - Agents write to /reports/, Tellus reads all
4. **Independent memory** - Each agent has own memory/ directory
5. **Tellus coordinates** - Human talks to Tellus, Tellus manages squad

## Example Conversation

```
Human: "How were sales yesterday?"
Tellus: "Let me check..." → queries SalesAgent → returns result

Human: "Any vendor bills due?"
Tellus: "VendorAgent found 3 bills totaling $2,847..."
       "National Grid: $1,051 due Feb 10"
       "Sysco: $892 due Feb 8"
       "US Foods: $904 due Feb 12"
```

## Performance

| Metric | Value |
|--------|-------|
| Max concurrent agents | 10+ on Pi 5 |
| Typical daily API calls | 15-25 |
| Memory per agent | ~50MB |
| Daily runtime | ~60 seconds total |

The Pi 5 handles this effortlessly. Most agents sleep 23.5 hours/day.
