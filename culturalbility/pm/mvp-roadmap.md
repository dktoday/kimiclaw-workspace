# MVP Roadmap
## Culturalbility 文化力 — Product Management Plan

---

## 1. Executive Summary

**MVP Goal:** Deliver a pilot-ready iOS app by Week 9 that can support 20 users with core conversation practice features.

**Key Alignment with GTM Strategy:**
- Week 4: Core flow ready for demo video
- Week 9: Pilot-ready for first customer
- Week 12: Full MVP with analytics and feedback collection

---

## 2. MVP Feature Set

### 2.1 Core Features (Must-Have for B2B Pilot)

| Feature | Description | Priority | User Story |
|---------|-------------|----------|------------|
| **User Auth** | Apple Sign-In, phone OTP | P0 | As a user, I can securely sign up and log in |
| **Persona Selection** | 3 personas: Indian, American, British | P0 | As a user, I can choose which accent to practice with |
| **Scenario Library** | 10 workplace scenarios | P0 | As a user, I can practice in realistic work contexts |
| **AI Conversation** | Real-time voice conversation with AI | P0 | As a user, I can speak and receive responses |
| **Audio Controls** | Replay, slow down, transcript | P0 | As a user, I can understand difficult audio |
| **Feedback System** | Basic pronunciation and grammar feedback | P0 | As a user, I know how I performed |
| **Progress Tracking** | Sessions completed, time spent | P0 | As a user, I can see my progress |
| **Manager Dashboard** | Web dashboard showing usage and progress | P0 | As a manager, I can track my team's engagement |
| **Onboarding Flow** | First-time user tutorial | P1 | As a new user, I understand how to use the app |
| **Feedback Collection** | In-app NPS and qualitative feedback | P1 | As PM, I can collect pilot feedback |

### 2.2 Scenarios for MVP (10 Total)

| # | Scenario | Persona | Workplace Context |
|---|----------|---------|-------------------|
| 1 | Daily Standup | American | Agile team check-in |
| 2 | Code Review Discussion | Indian | Technical feedback |
| 3 | Project Status Update | British | Executive update |
| 4 | Clarifying Requirements | American | Product manager discussion |
| 5 | Escalating a Blocker | Indian | Problem-solving |
| 6 | Sprint Planning | British | Team coordination |
| 7 | One-on-One with Manager | American | Career conversation |
| 8 | Cross-team Collaboration | Indian | Working with other teams |
| 9 | Incident Post-mortem | British | Learning from failures |
| 10 | Offshore Handoff | Mixed | Timezone coordination |

### 2.3 Nice-to-Have Features (Post-MVP)

| Feature | Description | Timeline |
|---------|-------------|----------|
| **Custom Scenarios** | Company-specific scenarios | Month 4+ |
| **WeChat Mini Program** | Companion app for review | Month 4+ |
| **Advanced Analytics** | Sentiment analysis, detailed metrics | Month 4+ |
| **Leaderboards** | Team gamification | Month 4+ |
| **Offline Mode** | Download scenarios for offline practice | Month 5+ |
| **Android App** | Cross-platform support | Month 6+ |
| **Integration APIs** | Slack, Teams, Calendar | Month 6+ |
| **Additional Personas** | Australian, Singaporean, etc. | Month 6+ |

### 2.4 Explicitly NOT in MVP

| Feature | Reason |
|---------|--------|
| Live human tutors | Out of scope, AI-only for MVP |
| Video conversations | Audio-only to reduce complexity |
| Real-time translation | Focus on comprehension, not translation |
| Social features | No sharing, no community |
| Payment in-app | B2B invoicing only |
| Offline mode | Requires complex sync, defer |
| Android | iOS-first strategy |
| Web app for users | Mobile-only for users, web only for managers |

---

## 3. Weekly Sprint Breakdown (Weeks 1-12)

### Sprint Structure
- **Sprint duration:** 1 week
- **Team size:** 2 developers (1 backend, 1 iOS), 1 designer, 1 PM (part-time)
- **Capacity:** 80 hours/week total engineering

### 3.1 Month 1: Foundation (Weeks 1-4)

#### Week 1: Project Setup & Architecture

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Set up iOS project structure | iOS Dev | 8 | None |
| Set up backend (Firebase/AWS) | Backend | 8 | None |
| Design system foundation | Designer | 8 | None |
| Auth system architecture | Backend + iOS | 8 | None |
| AI provider integration research | Backend | 8 | None |
| Project documentation | PM | 4 | None |
| **Deliverable:** Project repo, dev environment ready | | | |

**Week 1 Success Criteria:**
- [ ] Git repo initialized with branch protection
- [ ] CI/CD pipeline running
- [ ] iOS app builds and runs on device
- [ ] Backend API responds to health check
- [ ] AI provider account provisioned (OpenAI/Anthropic)

#### Week 2: Authentication & User Profile

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Apple Sign-In implementation | iOS Dev | 12 | Week 1 |
| Phone OTP implementation | Backend | 10 | Week 1 |
| User profile data model | Backend | 6 | Week 1 |
| Profile UI screens | iOS Dev | 10 | Week 1 |
| App icon, launch screen | Designer | 8 | None |
| Auth flow design | Designer | 6 | None |
| **Deliverable:** Users can sign up and create profiles | | | |

**Week 2 Success Criteria:**
- [ ] Sign up with Apple works end-to-end
- [ ] Phone OTP works (test with Twilio/similar)
- [ ] User profile stored in database
- [ ] Basic UI screens implemented

#### Week 3: AI Integration Foundation

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Speech-to-Text integration | iOS Dev | 12 | Week 2 |
| Text-to-Speech integration | iOS Dev | 10 | Week 2 |
| LLM conversation API | Backend | 12 | Week 1 |
| Basic conversation flow | iOS Dev | 10 | Week 2 |
| Conversation UI design | Designer | 10 | Week 2 |
| AI prompt engineering v1 | Backend | 8 | None |
| **Deliverable:** Basic voice conversation works | | | |

**Week 3 Success Criteria:**
- [ ] User can speak, audio captured
- [ ] STT converts speech to text
- [ ] LLM generates response
- [ ] TTS speaks response
- [ ] Basic conversation UI functional

#### Week 4: Demo-Ready Core Flow (Rick's Dependency)

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Persona selection UI | iOS Dev | 8 | Week 3 |
| 1 full scenario end-to-end | iOS + Backend | 16 | Week 3 |
| Audio controls (replay, slow) | iOS Dev | 8 | Week 3 |
| Transcript display | iOS Dev | 6 | Week 3 |
| Polish UI for demo | Designer + iOS | 12 | Week 3 |
| Demo video recording support | PM + Team | 6 | Week 3 |
| Bug fixes, stabilization | All | 10 | Week 3 |
| **Deliverable:** Demo video can be recorded | | | |

**Week 4 Success Criteria (CRITICAL for GTM):**
- [ ] Demo video successfully recorded
- [ ] 1 complete scenario flows perfectly
- [ ] UI is polished enough for external eyes
- [ ] No crashes during demo
- [ ] Rick has video for sales deck

---

### 3.2 Month 2: Feature Completion (Weeks 5-8)

#### Week 5: All 3 Personas + 5 Scenarios

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Voice tuning for Indian accent | Backend | 10 | Week 4 |
| Voice tuning for British accent | Backend | 10 | Week 4 |
| American accent refinement | Backend | 6 | Week 4 |
| Scenario content creation (5) | PM + Content | 12 | None |
| Scenario integration | Backend | 10 | Week 4 |
| Scenario selection UI | iOS Dev | 10 | Week 4 |
| Basic feedback algorithm | Backend | 12 | Week 4 |
| **Deliverable:** 3 personas, 5 scenarios working | | | |

**Week 5 Success Criteria:**
- [ ] All 3 personas have distinct voices
- [ ] 5 scenarios fully functional
- [ ] Basic feedback provided after sessions

#### Week 6: Full Scenario Library + Feedback

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Remaining 5 scenarios content | PM + Content | 12 | Week 5 |
| Remaining 5 scenarios integration | Backend | 10 | Week 5 |
| Feedback UI in app | iOS Dev | 10 | Week 5 |
| Progress tracking backend | Backend | 10 | Week 5 |
| Progress tracking UI | iOS Dev | 8 | Week 5 |
| Security review prep | Backend | 10 | None |
| **Deliverable:** All 10 scenarios, feedback system | | | |

**Week 6 Success Criteria:**
- [ ] 10 scenarios complete
- [ ] Feedback displays after each session
- [ ] Progress tracking shows in app
- [ ] Security docs started (for procurement)

#### Week 7: Manager Dashboard Foundation

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Manager dashboard web app setup | Backend | 8 | Week 6 |
| Dashboard authentication | Backend | 8 | Week 6 |
| Usage analytics backend | Backend | 12 | Week 6 |
| Dashboard UI design | Designer | 12 | None |
| Dashboard frontend (basic) | Backend/Frontend | 14 | Week 6 |
| Invite system for employees | Backend | 6 | Week 6 |
| **Deliverable:** Manager can view basic team stats | | | |

**Week 7 Success Criteria:**
- [ ] Manager dashboard loads
- [ ] Authentication works for managers
- [ ] Basic usage stats visible
- [ ] Can invite employees by email

#### Week 8: Dashboard Complete + Pilot Prep (CRITICAL)

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Dashboard analytics polish | Backend | 10 | Week 7 |
| Dashboard data exports | Backend | 6 | Week 7 |
| Onboarding flow implementation | iOS Dev | 12 | Week 7 |
| App Store preparation | iOS Dev | 8 | Week 7 |
| TestFlight deployment | iOS Dev | 6 | Week 7 |
| Pilot customer setup scripts | Backend | 8 | Week 7 |
| Documentation for pilot | PM | 8 | Week 7 |
| End-to-end testing | All | 12 | Week 7 |
| **Deliverable:** PILOT-READY VERSION | | | |

**Week 8 Success Criteria (CRITICAL for GTM):**
- [ ] App on TestFlight for distribution
- [ ] Manager dashboard fully functional
- [ ] Onboarding flow complete
- [ ] Pilot customer can be onboarded in <30 minutes
- [ ] Rick can sign first pilot customer

---

### 3.3 Month 3: Polish + Analytics (Weeks 9-12)

#### Week 9: First Pilot Support

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Pilot customer onboarding | PM + Dev | 16 | Week 8 |
| Real-time monitoring setup | Backend | 8 | Week 8 |
| Bug fixes from pilot feedback | iOS + Backend | 20 | Week 8 |
| Quick wins implementation | Team | 16 | Week 8 |
| Daily standup with pilot users | PM | 5 | None |
| **Deliverable:** First pilot live and supported | | | |

**Week 9 Success Criteria:**
- [ ] First pilot customer onboarded
- [ ] Users actively using the app
- [ ] Critical bugs from pilot fixed

#### Week 10: Feedback Collection + NPS

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| In-app NPS survey | iOS Dev | 8 | Week 9 |
| Qualitative feedback form | iOS Dev | 6 | Week 9 |
| Feedback dashboard | Backend | 8 | Week 9 |
| Second pilot customer onboarding | PM + Dev | 12 | Week 9 |
| Performance optimization | iOS Dev | 12 | Week 9 |
| Analytics refinement | Backend | 14 | Week 9 |
| **Deliverable:** Feedback systems operational, 2nd pilot live | | | |

**Week 10 Success Criteria:**
- [ ] NPS survey collects responses
- [ ] Qualitative feedback flowing in
- [ ] Second pilot customer onboarded
- [ ] App performance improved

#### Week 11: Analytics Dashboard v1

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Advanced analytics backend | Backend | 12 | Week 10 |
| Confidence scoring algorithm | Backend | 14 | Week 10 |
| Manager dashboard v2 | Frontend | 14 | Week 10 |
| Data visualization | Designer + Frontend | 10 | Week 10 |
| Third pilot preparation | PM | 10 | Week 10 |
| **Deliverable:** Rich analytics for managers | | | |

**Week 11 Success Criteria:**
- [ ] Confidence scores calculated
- [ ] Dashboard shows trends and insights
- [ ] Ready for third pilot

#### Week 12: MVP Complete

| Task | Owner | Hours | Dependencies |
|------|-------|-------|--------------|
| Final bug fixes | All | 16 | Week 11 |
| Performance optimization | iOS Dev | 12 | Week 11 |
| Documentation completion | PM | 10 | Week 11 |
| App Store submission prep | iOS Dev | 10 | Week 11 |
| Third pilot launch | PM + Dev | 8 | Week 11 |
| Retrospective and planning | Team | 4 | None |
| **Deliverable:** MVP COMPLETE | | | |

**Week 12 Success Criteria (MVP COMPLETE):**
- [ ] All 10 scenarios polished
- [ ] 3 pilots running successfully
- [ ] Manager dashboard comprehensive
- [ ] App Store ready for submission
- [ ] Documentation complete

---

## 4. Dependencies Between Tasks

### 4.1 Technical Dependencies

```
Week 1 (Setup)
    ↓
Week 2 (Auth)
    ↓
Week 3 (AI Foundation) ←→ Week 4 (Demo)
    ↓
Week 5 (Personas) ←→ Week 6 (Scenarios)
    ↓
Week 7 (Dashboard Backend) ←→ Week 8 (Dashboard Frontend)
    ↓
Week 9-12 (Pilots + Polish)
```

### 4.2 Business Dependencies

| Dependency | Task | Unblocks | Contingency |
|------------|------|----------|-------------|
| ICP License | App Store submission | Public launch | Already acquired |
| Business Entity | B2B contracts | Pilot contracts | Already established |
| AI Provider | Week 1 | All AI features | Have backup provider ready |
| TestFlight Review | Week 8 | Pilot distribution | Enterprise distribution fallback |
| Security Review | Week 8 | Enterprise pilots | Prepare docs early |

### 4.3 External Dependencies

| Dependency | Owner | Due Date | Risk Level |
|------------|-------|----------|------------|
| AI API access | Backend | Week 1 | Low |
| Apple Developer Account | PM | Week 1 | Low |
| Twilio/similar for SMS | Backend | Week 2 | Low |
| Content reviewer (cultural) | PM | Week 5 | Medium |
| Pilot customer commitment | CEO | Week 8 | High |

---

## 5. Risk Mitigation for Timeline

### 5.1 Top 5 Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| **AI voice quality issues** | Medium | Critical | Start with best TTS provider (ElevenLabs), have fallbacks |
| **App Store rejection** | Low | High | Submit early, use TestFlight, have enterprise fallback |
| **Pilot customer delays** | High | High | Have 3 backup prospects, start conversations Week 4 |
| **Key person unavailable** | Medium | High | Cross-train, document everything, hire contractor backup |
| **AI API latency/cost** | Medium | Medium | Cache responses, optimize prompts, set usage limits |

### 5.2 Buffer Time Strategy

| Phase | Planned | Buffer | Contingency |
|-------|---------|--------|-------------|
| Month 1 | 4 weeks | Week 4 is demo buffer | Can ship demo with 1 scenario |
| Month 2 | 4 weeks | Week 8 is pilot buffer | Can pilot with 5 scenarios |
| Month 3 | 4 weeks | Week 12 is polish buffer | Can delay non-critical features |

### 5.3 Feature Cutting Triggers

**If Week 4 Demo at risk:**
- Cut to 1 scenario only
- Cut transcript feature temporarily
- Use pre-recorded responses for demo

**If Week 8 Pilot at risk:**
- Cut to 5 scenarios
- Cut advanced analytics
- Manual onboarding instead of automated

**If Week 12 MVP at risk:**
- Cut NPS to post-pilot only
- Cut advanced feedback algorithms
- Use simple heuristics for scoring

---

## 6. Success Metrics for Each Phase

### 6.1 Week 4 Checkpoint (Demo Ready)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Core flow completion | 100% | Demo runs without crashes |
| Scenario count | ≥1 | Functional in app |
| Crash rate | <5% | Crashlytics |
| Demo video quality | Professional | CEO approval |

### 6.2 Week 8 Checkpoint (Pilot Ready)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Scenario count | ≥5 | Functional in app |
| Persona count | 3 | All voices working |
| Auth completion rate | >90% | Analytics |
| Onboarding completion | >80% | Analytics |
| Session success rate | >90% | No errors during conversation |
| App availability | 99% | Uptime monitoring |
| Dashboard functionality | 100% | All core features work |

### 6.3 Week 12 Checkpoint (MVP Complete)

| Metric | Target | Measurement |
|--------|--------|-------------|
| Scenario count | 10 | All complete |
| Active pilot users | 60 (3×20) | Analytics |
| Weekly active rate | >70% | Analytics |
| Avg sessions per user/week | >3 | Analytics |
| NPS response rate | >50% | Survey |
| Crash rate | <1% | Crashlytics |
| App Store readiness | Yes | Submission checklist |

### 6.4 Pilot Readiness Criteria

**Technical Readiness:**
- [ ] App deployable via TestFlight
- [ ] Backend handles 50 concurrent users
- [ ] Monitoring and alerting operational
- [ ] Rollback plan documented

**Product Readiness:**
- [ ] 5+ scenarios functional
- [ ] All 3 personas working
- [ ] Feedback system operational
- [ ] Manager dashboard functional

**Operational Readiness:**
- [ ] Onboarding documentation
- [ ] Support channel established
- [ ] Bug triage process defined
- [ ] Escalation plan documented

---

## 7. Resource Requirements

### 7.1 Team Capacity

| Role | Allocation | Hours/Week | Weeks |
|------|------------|------------|-------|
| iOS Developer | Full-time | 40 | 12 |
| Backend Developer | Full-time | 40 | 12 |
| Designer | 75% | 30 | 12 |
| PM (You) | 50% | 20 | 12 |
| **Total** | | **130** | |

### 7.2 Budget Estimate

| Category | Cost | Notes |
|----------|------|-------|
| AI APIs (OpenAI + TTS) | ¥10,000/month | Scales with usage |
| Cloud infrastructure | ¥3,000/month | Firebase/AWS |
| Apple Developer | ¥700/year | One-time |
| SMS service | ¥1,000/month | OTP delivery |
| Analytics tools | ¥2,000/month | Mixpanel/Amplitude |
| Contingency | ¥5,000/month | Buffer |
| **Total Monthly** | **¥21,700** | |

### 7.3 External Resources

| Resource | Purpose | When Needed |
|----------|---------|-------------|
| Cultural consultant | Review scenario content | Week 3, Week 6 |
| Voice actor samples | Train TTS voice profiles | Week 3 |
| Legal review | Terms of service, privacy | Week 6 |
| Security audit | Enterprise readiness | Week 8 |

---

## 8. Coordination Notes

### 8.1 Alignment with Rick's GTM Strategy

| GTM Milestone | PM Dependency | Status |
|---------------|---------------|--------|
| Demo Video (Week 4) | Core flow working | On track |
| Pilot Proposal (Week 8) | Pilot-ready app | On track |
| First Pilot (Week 9) | App deployable | On track |
| Security Review | Security docs | Week 6 start |
| Analytics Dashboard | Manager dashboard | Week 7-8 |

### 8.2 Dependencies on CEO (Rick)

| Need | When | Purpose |
|------|------|---------|
| Pilot customer commitment | Week 4 | Validate timeline |
| Content feedback | Week 5 | Scenario approval |
| Pricing confirmation | Week 6 | Dashboard features |
| Sales materials review | Week 8 | Alignment |

### 8.3 Handoffs to Lucipher (Devil's Advocate)

This roadmap assumes:
- 2 full-time developers available immediately
- No major technical blockers with AI APIs
- Pilot customer committed by Week 8
- Content creation keeps pace with development

If any assumption is wrong, timeline extends.

---

## 9. Appendix

### 9.1 Technology Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| Mobile | Swift + SwiftUI | Native iOS performance |
| Backend | Firebase + Cloud Functions | Rapid development |
| AI | OpenAI GPT-4 + ElevenLabs TTS | Best-in-class quality |
| Auth | Firebase Auth + Apple Sign-In | Enterprise-ready |
| Database | Firestore | Real-time sync |
| Analytics | Mixpanel | Product analytics |
| Monitoring | Firebase Crashlytics | Stability tracking |

### 9.2 Definition of Done

- [ ] Code reviewed and merged
- [ ] Unit tests passing (>70% coverage)
- [ ] Manual QA completed
- [ ] Documentation updated
- [ ] Designer review passed
- [ ] PM acceptance criteria met

---

*Document Version: 1.0*
*Created: March 2026*
*Owner: Wei (PM)*
*Aligned with: Rick's GTM Strategy v1.0*
