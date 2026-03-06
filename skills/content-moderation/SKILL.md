---
description: AI content safety, cultural sensitivity checks, and compliance guidelines for global applications.
---

# Content Moderation

## Why It Matters for Culturalbility

**Risk:** AI-generated content about cultures, accents, and nationalities can:
- Perpetuate stereotypes
- Cause offense
- Violate regulations (especially in China)
- Damage brand reputation

## Moderation Layers

### Layer 1: Input Filtering

**Check user inputs for:**
- Hate speech
- Discriminatory language
- Inappropriate requests

**Implementation:**
```javascript
const blockedTerms = [
  'racist slur',
  'stereotype accusation',
  // ...
];

function checkInput(text) {
  if (blockedTerms.some(term => text.includes(term))) {
    return { blocked: true, reason: 'Inappropriate content' };
  }
  return { blocked: false };
}
```

### Layer 2: AI Output Review

**System prompt safeguards:**
```
You are a professional communication coach. 
- NEVER mock or stereotype any culture or accent
- Focus on workplace professionalism only
- Avoid casual/cultural topics outside work context
- If asked about sensitive topics, redirect to professional communication
```

### Layer 3: Cultural Sensitivity Review

**For Culturalbility specifically:**

| Element | Check | Example |
|---------|-------|---------|
| **Accents** | Are we teaching understanding, not mockery? | ✅ "Listen for the intonation pattern" ❌ "Indians speak like this" |
| **Scenarios** | Are they workplace-appropriate? | ✅ "Technical stand-up meeting" ❌ "Casual dinner conversation" |
| **Cultural tips** | Are they accurate and respectful? | ✅ "In Indian business culture, building rapport is important" ❌ "Indians are always late" |
| **Personas** | Do they represent diversity within cultures? | ✅ Multiple Indian personas (different regions, roles) ❌ Single stereotypical character |

### Layer 4: Human Review

**Before launch:**
- Native speakers review all personas
- Cultural consultants vet content
- Legal review for compliance

**Ongoing:**
- User reporting system
- Regular content audits
- A/B test sensitive content

## China-Specific Compliance

**Audio/AI regulations:**
- Content must comply with Chinese laws
- No politically sensitive topics
- Data must stay in China
- ICP license required (✅ you have this)

**Implementation:**
```javascript
const sensitiveTopics = [
  'politics',
  'religion',
  // ...
];

function chinaComplianceCheck(content) {
  if (sensitiveTopics.some(topic => content.includes(topic))) {
    return { approved: false, flag: 'Sensitive topic' };
  }
  return { approved: true };
}
```

## User Reporting System

**In-app reporting:**
"Was this content inappropriate?"
- Yes, stereotyping
- Yes, inaccurate
- Yes, offensive
- Other: _______

**Response workflow:**
1. Auto-flag reported content
2. Human review within 24 hours
3. Remove or modify content
4. Notify user of action
5. Update moderation rules

## Escalation Process

**Level 1: Automated** - Keyword filtering
**Level 2: AI review** - Context analysis
**Level 3: Human review** - Cultural expert
**Level 4: Legal review** - If regulatory issue

## Training Data Guidelines

**DO:**
- Use diverse, real workplace scenarios
- Include multiple accents per country
- Focus on professional contexts
- Get consent for voice samples

**DON'T:**
- Use stereotypes as "shorthand"
- Include casual/cultural jokes
- Assume homogeneity within cultures
- Ignore user feedback about accuracy

## Reference

- China's AI regulations: CAC guidelines
- General: Platform Safety guidelines
- Cultural: Hire cultural consultants for each target market
