# Multi-Agent Cron Schedule

## Staggered Heartbeats (Prevent API spikes)

| Time | Agent | Task |
|------|-------|------|
| 02:00 | SalesAgent | Daily sales review |
| 02:05 | LaborAgent | Labor analysis |
| 02:10 | VendorAgent | Bill scanning |
| 02:15 | MenuAgent | Menu performance |
| 07:00 | Tellus | Morning brief compilation |
| 07:05 | All | System health check |

## Cron Expressions

```bash
# Sales Agent - Daily at 2 AM
0 2 * * * agent:sales:main

# Labor Agent - Daily at 2:05 AM
5 2 * * * agent:labor:main

# Vendor Agent - Daily at 2:10 AM
10 2 * * * agent:vendor:main

# Menu Agent - Daily at 2:15 AM
15 2 * * * agent:menu:main

# Tellus - Daily morning brief at 7 AM
0 7 * * * agent:tellus:main
```

## Agent Session Keys

| Agent | Session Key |
|-------|-------------|
| Tellus | agent:tellus:main |
| SalesAgent | agent:sales:main |
| LaborAgent | agent:labor:main |
| VendorAgent | agent:vendor:main |
| MenuAgent | agent:menu:main |

## Coordination

Tellus (agent:tellus:main) coordinates other agents:
- Reads reports from /reports/
- Compiles morning brief
- Escalates issues to human
