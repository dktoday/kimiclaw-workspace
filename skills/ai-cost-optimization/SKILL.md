---
description: Optimize AI/LLM API costs, caching strategies, and architecture decisions for AI-powered applications.
---

# AI Cost Optimization

## The Problem

AI APIs (GPT-4, Claude, etc.) can eat 30-50% of your revenue if not managed carefully.

**Example for Culturalbility:**
- 10-minute practice session = ~30 AI interactions
- GPT-4: ~$0.03 per interaction
- Cost per session: ~$0.90
- 1,000 active users = $900/day = $27,000/month
- **Your ¥100K revenue becomes ¥35K after AI costs**

## Cost Optimization Strategies

### 1. Tiered Model Strategy

| Use Case | Model | Cost Savings |
|----------|-------|--------------|
| Simple responses | Claude 3 Haiku / GPT-3.5 | 90% cheaper |
| Standard conversation | Claude 3 Sonnet / GPT-4-turbo | Baseline |
| Complex analysis | Claude 3 Opus / GPT-4 | Only when needed |

**Implementation:**
```javascript
// Route based on complexity
function selectModel(prompt, context) {
  if (isSimpleGreeting(prompt)) return 'claude-3-haiku-20240307';
  if (needsDeepReasoning(context)) return 'claude-3-opus-20240229';
  return 'claude-3-sonnet-20240229'; // default
}
```

### 2. Response Caching

**Cache common responses:**
- Greetings and introductions
- Encouragement messages
- Frequently asked questions
- Error messages

**Implementation:**
```javascript
const cache = new Map();

async function getAIResponse(prompt) {
  const key = hashPrompt(prompt);
  
  if (cache.has(key)) {
    return cache.get(key); // $0 cost
  }
  
  const response = await callAI(prompt);
  cache.set(key, response);
  return response;
}
```

**Expected savings:** 20-30% for repetitive interactions

### 3. Conversation Summarization

**Problem:** Long conversations eat tokens fast

**Solution:** Summarize context periodically

```javascript
// Instead of sending full conversation history
const summary = await ai.summarize(conversation);
const response = await ai.respond(summary + newMessage);
```

**Expected savings:** 40-50% for long sessions

### 4. Pre-computed Content

**Don't generate static content with AI:**

❌ **Bad:**
```javascript
const intro = await ai.generate("Welcome message for Indian colleague scenario");
```

✅ **Good:**
```javascript
const intro = preWrittenIntros.indianColleague; // From database
```

**Pre-write:**
- Scenario introductions
- Cultural tips
- Common corrections
- Encouragement messages

### 5. Batch Processing

**Process non-real-time tasks in batches:**
- End-of-session summaries
- Progress reports
- Analytics

```javascript
// Queue for batch processing
const summaryQueue = [];

// Process every 5 minutes, not per user
setInterval(async () => {
  const batch = summaryQueue.splice(0, 10);
  await processBatch(batch);
}, 300000);
```

### 6. Streaming Responses

**Show typing indicator instead of waiting:**
- Better UX
- User perceives faster response
- Can abort if taking too long

### 7. Token Optimization

**Reduce prompt size:**
- Remove unnecessary whitespace
- Use abbreviations in system prompts
- Shorter conversation history
- Essential context only

**Example:**
```
❌ "You are a helpful AI assistant that helps Chinese professionals..."
✅ "Help Chinese professionals practice workplace English."
```

## Architecture Patterns

### Hybrid AI + Rule-Based

```
User Input
    ↓
Intent Classifier (cheap model)
    ↓
    ├── Greeting → Pre-written response
    ├── Question → Knowledge base
    ├── Practice → AI model
    └── Error → Rule-based handling
```

**Expected savings:** 60-70%

### Progressive Enhancement

**Start simple, add AI only when needed:**
1. Text-based conversation (no AI)
2. Add AI for feedback only
3. Add AI for persona responses
4. Add AI for advanced features

## Cost Monitoring

**Track per-user costs:**
```javascript
async function trackAPICost(userId, promptTokens, completionTokens) {
  const cost = (promptTokens * 0.00003) + (completionTokens * 0.00006);
  await db.increment(`user_costs:${userId}`, cost);
}
```

**Alert thresholds:**
- User exceeds $5/day → Flag for review
- Daily total exceeds budget → Enable stricter caching
- Monthly projection exceeds 30% of revenue → Emergency measures

## For Culturalbility Specifically

**Recommended Architecture:**

```
MVP (Phase 1)
├── GPT-3.5 for standard responses
├── Pre-written introductions
├── Cached encouragement messages
└── Target: $0.20 per session

Scale (Phase 2)
├── Claude 3 Haiku for simple interactions
├── Claude 3 Sonnet for complex feedback
├── Summarized conversation context
└── Target: $0.15 per session

Enterprise (Phase 3)
├── Hybrid rule-based + AI
├── Cached common scenarios
├── Batch analytics processing
└── Target: $0.10 per session
```

## Emergency Cost Reduction

**If costs spiral:**
1. Enable aggressive caching
2. Switch all to cheaper models
3. Limit session length
4. Add daily usage caps per user
5. Require confirmation for expensive operations

## Reference

- OpenAI pricing: https://openai.com/pricing
- Anthropic pricing: https://www.anthropic.com/pricing
- Token calculator: https://platform.openai.com/tokenizer
- Cost monitoring: Implement custom dashboard
