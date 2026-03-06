---
description: Metrics definition, event tracking, and growth KPIs for data-driven product development.
---

# Analytics Dashboard

## Key Metrics Framework (AARRR)

### 1. Acquisition

**For Culturalbility B2B:**
- Website visitors
- Demo requests
- Sales meetings booked
- Pilot signups

**Target:** 15% demo request rate, 40% meeting conversion

### 2. Activation

**First value moment:**
- User completes first conversation practice
- Time to first practice < 24 hours
- Practice quality score > 6/10

**Target:** 70% activation rate

### 3. Retention

**Engagement metrics:**
- Daily/Weekly Active Users (DAU/WAU)
- Sessions per week
- Average session duration
- Streak maintenance

**Target:** 40% weekly retention, 20% daily retention

### 4. Revenue

**B2B specific:**
- Pilot → Contract conversion
- Average contract value
- Expansion revenue
- Churn rate

**Target:** 70% pilot conversion, < 5% monthly churn

### 5. Referral

- Referral rate
- Viral coefficient
- Share frequency

**Target:** 20% referral rate

## Event Tracking

### Critical Events

```javascript
// User lifecycle
track('user_signup', { source: 'linkedin', company: 'Alibaba' });
track('first_practice_completed', { duration: 600, score: 8 });
track('subscription_started', { plan: 'enterprise', seats: 50 });

// Feature usage
track('practice_started', { scenario: 'standup', persona: 'indian_pm' });
track('practice_completed', { score: 7, duration: 480 });
track('feedback_given', { rating: 5 });

// Business
track('demo_requested', { company_size: 1000 });
track('pilot_started', { company: 'McKinsey', users: 20 });
track('contract_signed', { value: 75000, duration: 12 });
```

## Dashboard Design

### Executive Summary

```
┌─────────────────────────────────────────┐
│  MRR: ¥85,000    ↑ 15% vs last month   │
│  Active Users: 450   ↑ 8%              │
│  Pilot → Contract: 75%                 │
│  Churn: 3.2%  ↓ (target: <5%)          │
└─────────────────────────────────────────┘
```

### User Engagement

```
Week-over-week:
┌──────────┬────────┬────────┬────────┐
│ Metric   │ Week 1 │ Week 2 │ Week 3 │
├──────────┼────────┼────────┼────────┤
│ WAU      │ 400    │ 420    │ 450    │
│ Avg Sessions│ 3.2 │ 3.5    │ 3.8    │
│ Avg Duration│ 8m  │ 9m     │ 10m    │
└──────────┴────────┴────────┴────────┘
```

### Cohort Retention

```
Cohort analysis (weekly):
Week 0: 100%
Week 1: 55%
Week 2: 42%
Week 3: 38%
Week 4: 35%
```

## North Star Metric

**For Culturalbility:**

"Weekly Active Users who completed 3+ practice sessions and rated confidence improvement"

**Why:**
- Measures engagement (weekly active)
- Measures value (3+ sessions)
- Measures outcome (confidence improvement)

## Alert Thresholds

| Metric | Warning | Critical | Action |
|--------|---------|----------|--------|
| Daily signups | < 5 | < 2 | Increase marketing |
| Activation rate | < 60% | < 40% | Fix onboarding |
| Week 1 retention | < 45% | < 30% | Improve UX |
| Support tickets | > 5% | > 10% | Fix bugs |

## Tools

**Analytics platforms:**
- Mixpanel (product analytics)
- Amplitude (user journeys)
- Google Analytics (web)
- Custom dashboard (Metabase/Tableau)

**China-specific:**
- GrowingIO
- TalkingData
- Umeng

## Reference

- Books: "Lean Analytics", "Measure What Matters"
- Frameworks: Pirate Metrics (AARRR), North Star Framework
