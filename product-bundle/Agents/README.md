# Multi-Agent System

**Powered by OpenClaw** — Inspired by Boris Cherny's multi-agent architecture.

## Quick Start

1. Copy Agents/ folder to your Pi 5
2. Configure cron jobs (see CRON_SCHEDULE.md)
3. Each agent runs on staggered schedule
4. Tellus coordinates and compiles morning briefs

## What's Included

| File | Purpose |
|------|---------|
| AGENTS.md | Full documentation |
| CRON_SCHEDULE.md | When each agent wakes |
| Tellus/SOUL.md | Coordinator personality |
| SalesAgent/SOUL.md | Sales specialist |
| LaborAgent/SOUL.md | Labor specialist |
| VendorAgent/SOUL.md | Vendor/bills specialist |
| MenuAgent/SOUL.md | Menu/price specialist |

## Add to OpenClaw

```bash
# Create session for each agent in openclaw.yaml
# See AGENTS.md for session key mappings
```

## The Agent Squad

```
Human → Telegram → Tellus (Coordinator)
                    ↓
           SalesAgent | LaborAgent | VendorAgent | MenuAgent
                    ↓
           Reports written to /reports/
                    ↓
           Tellus reads all → Compiles morning brief
```

## Why Multiple Agents?

- **Focus** — Each agent excels at one thing
- **Scalability** — Add agents without slowing down
- **Modularity** — Replace one agent without breaking others
- **Parallelism** — Agents run simultaneously

## Performance

- **Pi 5 handles 10+ agents easily**
- **Total daily runtime: ~60 seconds**
- **API calls: 15-25 per day**
- **Cost: ~$5-10/month**

## Learn More

See AGENTS.md for full documentation.
