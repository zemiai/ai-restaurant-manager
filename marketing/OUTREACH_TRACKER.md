# Outreach Tracker Guide

## How to Track Sends, Replies, and Conversions

### Setting Up Your Tracking System

Use the `lead_list.csv` file to track every outreach attempt. Update it consistently after each interaction.

---

### Status Definitions

| Status | Definition | Next Action |
|--------|------------|-------------|
| **New** | Lead added, no outreach yet | Send initial message |
| **Contacted** | Initial message sent | Wait 48-72 hours for reply |
| **Replied** | Lead responded (positive or neutral) | Move to sales conversation |
| **Converted** | Lead became customer | Move to onboarding |
| **Lost** | Lead said no or went silent | Archive (may revisit in 6 months) |
| **Do Not Contact** | Explicit opt-out | Remove from active outreach |

---

### Tracking Sends

**For each outreach:**
1. Add lead to `lead_list.csv` with "New" status
2. Record channel (Email/Instagram/LinkedIn)
3. Add notes about personalization or context
4. Set FollowUpDate based on sequence:
   - Initial: +3 days
   - Day 3 follow-up: +4 days
   - Day 7 follow-up: +4 days
   - Day 14 follow-up: End of sequence

**Record:**
```
Date Sent | Channel | Template Used | Notes
----------|---------|---------------|-------
2026-02-01 | Email | Template 1 | Mentioned their new menu
2026-02-01 | Instagram | IG Initial | Engaged with 3 posts first
```

---

### Tracking Replies

**Quick replies (positive):**
- Move to "Replied" status
- Add notes about conversation direction
- Schedule follow-up call/discovery meeting

**Quick replies (negative):**
- Move to "Lost" or keep at "Contacted" for longer follow-up
- Record reason for declining
- Thank them for response

**No reply:**
- Follow the Day 3 → Day 7 → Day 14 sequence
- Update FollowUpDate each time
- Mark as "Lost" after Day 14 if no response

---

### Tracking Conversions

**Conversion points:**
1. Demo scheduled
2. Trial started
3. Paid conversion
4. Monthly active user

**Record in Notes column:**
```
Conversion Date | Plan Type | Source (which template worked?)
---------------|-----------|-------------------------------
2026-02-15 | Pro Annual | Template 1 (warm outreach)
```

---

## Weekly Review Checklist

### Every Monday (15 minutes)

- [ ] Review leads that moved to "Replied" status last week
- [ ] Identify leads that need Day 3 follow-up
- [ ] Update FollowUpDate for all active leads
- [ ] Check no-response leads from previous week

### Every Friday (20 minutes)

- [ ] Send all pending follow-ups (Day 3, Day 7, Day 14)
- [ ] Update lead statuses for the week
- [ ] Log new leads from referrals or research
- [ ] Calculate weekly metrics (see below)

### Monthly (1 hour)

- [ ] Review conversion funnel by channel
- [ ] Identify best-performing templates
- [ ] Update templates based on feedback
- [ ] Plan outreach focus for next month
- [ ] Archive "Lost" leads older than 3 months

---

## Metrics to Track

### Volume Metrics

| Metric | Definition | Target |
|--------|------------|--------|
| **Total Outreach** | Number of messages sent per week | 20-30 |
| **By Channel** | Breakdown of Email/IG/LinkedIn | Mix based on target list |
| **New Leads Added** | Fresh prospects researched | 10-15/week |

### Engagement Metrics

| Metric | Definition | Target |
|--------|------------|--------|
| **Reply Rate** | Replies / Outreach sent | 15-25% |
| **Positive Reply Rate** | Interested replies / Total replies | 50%+ |
| **Conversion Rate** | Customers / Replied leads | 20-30% |

### Efficiency Metrics

| Metric | Definition | Target |
|--------|------------|--------|
| **Time to First Reply** | Days from send to reply | 2-4 days |
| **Time to Close** | Days from first contact to sale | 7-14 days |
| **Best Template** | Highest converting template | Identify & repeat |

### Weekly Tracker Template

```
WEEK OF: _______________

OUTREACH:
- Email sent: __
- Instagram sent: __
- LinkedIn sent: __
- Total sent: __

REPLIES:
- Total replies: __
- Interested: __
- Not interested: __
- No response: __

CONVERSIONS:
- Demos scheduled: __
- Trials started: __
- Paid conversions: __

RATES:
- Reply rate: __%
- Conversion rate: __%

TOP PERFORMERS:
- Best template: __
- Best channel: __
```

---

## Common Tracking Mistakes to Avoid

1. **Not updating the CSV consistently** → Set a calendar reminder
2. **Forgetting follow-up dates** → Use the FollowUpDate column
3. **Marking "Lost" too early** → Give each lead the full 14-day sequence
4. **Not recording why leads convert or churn** → Notes matter for optimization
5. **Mixing up channels** → Track separately to see what's working
