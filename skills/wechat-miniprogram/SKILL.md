---
description: Guide for building WeChat Mini Programs (微信小程序) with best practices, constraints, and deployment workflows.
---

# WeChat Mini Program Development

## Overview

WeChat Mini Programs are lightweight apps that run inside WeChat. They offer lower friction than native apps but have significant technical constraints.

## Key Constraints (Critical for Planning)

| Constraint | Limit | Impact on Culturalbility |
|------------|-------|--------------------------|
| **Audio recording** | 60 seconds max | Short practice sessions only |
| **File upload** | 2MB per file | Compressed audio required |
| **Storage** | 10MB local cache | Limited offline capability |
| **WebSocket** | Supported but limited | Real-time features restricted |
| **Package size** | 2MB per package, 20MB total | Keep code lean |

## When to Use Mini Program vs Native App

**Use Mini Program for:**
- Quick reference lookups
- Progress checking / dashboards
- Sharing scores with friends
- User onboarding (lower friction)

**Use Native App for:**
- Full conversation practice (60s limit is too short)
- Complex audio processing
- Offline functionality
- Better performance

## Recommended Hybrid Approach for Culturalbility

```
Native App (iOS/Android)          Mini Program
─────────────────────────         ───────────────────
• Full conversation practice      • Quick stats review
• 10+ minute sessions             • Share progress
• Complex AI processing           • Reference materials
• Rich audio features             • Leaderboard
• Premium features                • Basic flashcards
```

## Mini Program File Structure

```
miniprogram/
├── app.js              # App lifecycle
├── app.json            # Global config
├── app.wxss            # Global styles
├── pages/
│   ├── index/          # Landing page
│   │   ├── index.js
│   │   ├── index.json
│   │   ├── index.wxml  # Template (like HTML)
│   │   └── index.wxss  # Styles (like CSS)
│   ├── stats/          # User progress
│   └── share/          # Score sharing
├── components/         # Reusable components
├── utils/              # Helper functions
└── images/             # Static assets
```

## Audio Handling in Mini Programs

```javascript
// Recording (60 second limit)
const recorderManager = wx.getRecorderManager()

recorderManager.start({
  duration: 60000,  // Max 60 seconds
  sampleRate: 16000,
  numberOfChannels: 1,
  encodeBitRate: 48000,
  format: 'mp3'
})

// Playback
const innerAudioContext = wx.createInnerAudioContext()
innerAudioContext.src = 'cloud://your-bucket/audio.mp3'
innerAudioContext.play()
```

## Cloud Development (Recommended)

Use WeChat Cloud Base (TCB) for:
- User authentication (WeChat login)
- Database (MongoDB-like)
- File storage
- Cloud functions (Node.js)

```javascript
// Initialize cloud
wx.cloud.init({
  env: 'your-env-id'
})

// Call cloud function
wx.cloud.callFunction({
  name: 'getUserProgress',
  data: { userId: 'xxx' }
})
```

## Submission Process

1. **Register** at mp.weixin.qq.com
2. **Develop** using WeChat Developer Tools
3. **Test** thoroughly (iOS and Android behave differently)
4. **Submit** for review (1-3 business days)
5. **Publish** after approval

## Critical Gotchas

1. **iOS vs Android differences** — Test on both
2. **Audio autoplay blocked** — User must trigger first
3. **Background audio** — Must declare in app.json
4. **Data sharing** — Mini program can't directly share data with native app
5. **User retention** — Mini programs have lower retention than native apps

## For Culturalbility Specifically

**Phase 1 (MVP):** Skip Mini Program, focus on iOS native

**Phase 2 (Growth):** Add Mini Program as companion:
- Daily streak checker
- Quick vocabulary review
- Share conversation scores
- Referral program

**Phase 3 (Scale):** Evaluate if Mini Program should have practice features (likely still too limited)

## Reference

- Official docs: https://developers.weixin.qq.com/miniprogram/en/dev/framework/
- WeChat Developer Tools: Download from official site
- Cloud Base: https://developers.weixin.qq.com/miniprogram/dev/wxcloud/basis/getting-started.html
