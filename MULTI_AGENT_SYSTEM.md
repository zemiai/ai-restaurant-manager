# Multi-Agent System — Feature Spotlight

## The Innovation

**5 AI agents running on a single $60 Pi 5.** Inspired by Boris Cherny's multi-agent architecture at SiteGPT.

## The Squad

| Agent | Wake Time | Role | Daily Task |
|-------|-----------|------|------------|
| **Tellus** | 7:00 AM | Coordinator | Compiles morning brief |
| **SalesAgent** | 2:00 AM | Sales Analyst | Revenue, trends, top sellers |
| **LaborAgent** | 2:05 AM | Labor Monitor | Labor %, scheduling alerts |
| **VendorAgent** | 2:10 AM | Accounts Payable | Bills, due dates, invoices |
| **MenuAgent** | 2:15 AM | Menu Strategist | Profitability, pricing |

## How It Works

```
2:00 AM — SalesAgent wakes
          Pulls Toast data → writes report
          
2:05 AM — LaborAgent wakes  
          Compares labor % → writes report
          
2:10 AM — VendorAgent wakes
          Scans Gmail for invoices → writes report
          
2:15 AM — MenuAgent wakes
          Analyzes menu performance → writes report
          
7:00 AM — Tellus wakes
          Reads all reports → sends morning brief
```

## What Makes This Powerful

| Feature | Benefit |
|---------|---------|
| **Staggered schedules** | No API spikes, smooth performance |
| **Specialized agents** | Each agent excels at one thing |
| **Shared reports** | Agents write, Tellus reads all |
| **Independent memory** | Each agent remembers its domain |
| **Tellus coordinates** | Human talks to one, not five |

## Performance on Pi 5

| Metric | Value |
|--------|-------|
| Concurrent agents | 10+ |
| Daily runtime | ~60 seconds |
| Monthly API cost | $5-10 |
| Memory usage | ~500MB total |

## Adding New Agents

The architecture is modular. Add an agent in 3 steps:

1. Create `/Agents/NewAgent/SOUL.md`
2. Add cron job to `CRON_SCHEDULE.md`
3. Tell Tellus about the new agent

## Product Tiers

| Tier | Agents Included |
|------|-----------------|
| **Starter ($97)** | Tellus only (manual commands) |
| **Professional ($197)** | Full squad (5 agents) |
| **Enterprise ($497)** | Full squad + custom agents |

## Technical Details

- **Session keys:** `agent:tellus:main`, `agent:sales:main`, etc.
- **Memory:** Each agent has `/Agents/AgentName/memory/`
- **Reports:** All agents write to `/reports/AgentName/`
- **Coordination:** Tellus reads all reports at 7 AM

## Why This Matters

Single-agent systems get overwhelmed. Multi-agent systems:

- Stay focused (one job per agent)
- Scale horizontally (add agents easily)
- Stay fast (parallel execution)
- Stay cheap (Pi 5 handles 10+ easily)

**This is enterprise AI architecture, running on a $60 computer.**
