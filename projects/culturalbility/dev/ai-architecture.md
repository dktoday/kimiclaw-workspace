# Culturalbility AI Architecture Design

> **Version:** 1.0  
> **Date:** March 2025  
> **Agent:** Yang (Developer)  
> **Constraint:** Max ¥30K/month (~$4,200 USD) at ¥100K revenue

---

## Executive Summary

This document outlines a cost-optimized AI architecture for Culturalbility's B2B cross-cultural communication app. The architecture balances quality, latency, and cost while staying within the 30% revenue constraint.

**Key Design Principles:**
1. **Tiered Model Strategy** - Use cheap models for simple tasks, expensive models only when necessary
2. **Batch Processing** - Process non-real-time tasks in batches to save 40-60% on costs
3. **Intelligent Caching** - Cache common AI responses to reduce redundant API calls
4. **Hybrid Architecture** - Combine best-of-breed providers rather than single-vendor lock-in

---

## 1. API Provider Comparison

### 1.1 Speech-to-Text (STT)

| Provider | Price/min | Streaming | Accuracy | Pros | Cons |
|----------|-----------|-----------|----------|------|------|
| **OpenAI Whisper** | $0.006 | ❌ Batch only | 95-97% | Cheapest, 99 languages, best accuracy | No real-time, 25MB limit |
| **Deepgram Nova** | $0.0043 | ✅ | 92-95% | Cheapest streaming, low latency | Less accurate on accents |
| **Google Cloud** | $0.016-0.024 | ✅ | 93-96% | 125+ languages, enterprise grade | Expensive, complex pricing |
| **Azure Speech** | $0.006-0.017 | ✅ | 90-94% | Pronunciation assessment built-in | Azure ecosystem lock-in |
| **AssemblyAI** | $0.0025 | ✅ | 94-96% | Best developer experience, free tier | Higher latency |

**Recommendation:** Use **OpenAI Whisper** for batch transcription (user uploads) and **Deepgram** for real-time streaming scenarios.

### 1.2 Text-to-Speech (TTS) - Accent Simulation

| Provider | Price | Quality | Accent Support | Latency |
|----------|-------|---------|----------------|---------|
| **ElevenLabs** | $206/1M chars | ⭐⭐⭐⭐⭐ | 70+ languages, custom cloning | 150ms |
| **OpenAI TTS** | $15/1M chars | ⭐⭐⭐⭐ | Limited accents (Alloy, Echo, etc.) | 200ms |
| **Azure Neural** | $16/1M chars | ⭐⭐⭐⭐ | Good for Indian, British accents | 100ms |
| **Fish Audio** | $15/1M chars | ⭐⭐⭐⭐⭐ | Open source alternative | 300ms |
| **Amazon Polly** | $16/1M chars | ⭐⭐⭐ | Standard voices, Neural extra | 150ms |

**Recommendation:** Use **Azure Neural TTS** for Indian/British/American accents (better regional support) and **ElevenLabs** for premium scenarios only.

### 1.3 LLM for Feedback & Scoring

| Model | Input/1M | Output/1M | Best For |
|-------|----------|-----------|----------|
| **GPT-4o Mini** | $0.15 | $0.60 | Simple grammar checks, classification |
| **GPT-4o** | $2.50 | $10.00 | Complex feedback, reasoning |
| **Claude 3.5 Sonnet** | $3.00 | $15.00 | Nuanced language feedback |
| **GPT-5 Mini** | $0.25 | $2.00 | Balanced cost/quality (future) |
| **DeepSeek V3** | $0.28 | $0.42 | Budget option, good quality |

**Recommendation:** Use **GPT-4o Mini** for 80% of tasks, escalate to **GPT-4o** only for complex pronunciation analysis.

### 1.4 Pronunciation Assessment

| Provider | Price | Features |
|----------|-------|----------|
| **Azure Pronunciation Assessment** | $0.30/hour add-on | Prosody, phoneme-level scoring, fluency |
| **Whisper + GPT-4o** | ~$0.02/assessment | Custom scoring via LLM |
| **ELSA Speak API** | Custom pricing | Specialized for language learning |

**Recommendation:** Start with **Whisper + GPT-4o Mini** for cost efficiency, add **Azure** only if needed for detailed phoneme analysis.

---

## 2. Recommended Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           CULTURALBILITY iOS APP                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ │
│  │   Record    │  │   Playback  │  │   UI/UX     │  │  Progress Dashboard │ │
│  │   Audio     │  │   Audio     │  │             │  │                     │ │
│  └──────┬──────┘  └──────┬──────┘  └─────────────┘  └─────────────────────┘ │
└─────────┼────────────────┼──────────────────────────────────────────────────┘
          │                │
          ▼                ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           API GATEWAY (AWS/Azure)                           │
│                    Rate Limiting, Auth, Load Balancing                      │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
          ┌───────────────────────────┼───────────────────────────┐
          ▼                           ▼                           ▼
┌─────────────────────┐  ┌─────────────────────┐  ┌─────────────────────────────┐
│   SPEECH SERVICES   │  │   AI PROCESSING     │  │   DATA LAYER                │
│  ┌───────────────┐  │  │  ┌───────────────┐  │  │  ┌─────────────────────┐    │
│  │ Deepgram      │◄─┼──┼──┤ GPT-4o Mini   │  │  │  │ PostgreSQL          │    │
│  │ (Real-time    │  │  │  │ - Grammar     │  │  │  │ - User profiles     │    │
│  │  Streaming)   │  │  │  │ - Scoring     │  │  │  │ - Conversation logs │    │
│  └───────────────┘  │  │  └───────────────┘  │  │  │ - Progress tracking │    │
│                     │  │                     │  │  └─────────────────────┘    │
│  ┌───────────────┐  │  │  ┌───────────────┐  │  │                             │
│  │ OpenAI        │◄─┼──┼──┤ GPT-4o        │  │  │  ┌─────────────────────┐    │
│  │ Whisper       │  │  │  │ - Complex     │  │  │  │ Redis               │    │
│  │ (Batch STT)   │  │  │  │   feedback    │  │  │  │ - Session cache     │    │
│  └───────────────┘  │  │  │  - Accent     │  │  │  │ - TTS cache         │    │
│                     │  │  │    analysis   │  │  │  │ - Rate limiting     │    │
│  ┌───────────────┐  │  │  └───────────────┘  │  │  └─────────────────────┘    │
│  │ Azure Neural  │◄─┼──┘                     │  │                             │
│  │ TTS           │  │                        │  │  ┌─────────────────────┐    │
│  │ - Indian      │  │  ┌───────────────┐     │  │  │ S3/Cloud Storage    │    │
│  │ - American    │  │  │ Azure (Backup)│     │  │  │ - Audio files       │    │
│  │ - British     │  │  │ Pronunciation │◄────┘  │  │ - Training data     │    │
│  └───────────────┘  │  │ Assessment    │        │  └─────────────────────┘    │
└─────────────────────┘  └───────────────┘        └─────────────────────────────┘
```

---

## 3. Component Architecture Details

### 3.1 Listening & Comprehension (STT)

**Primary: OpenAI Whisper (Batch)**
- **Cost:** $0.006/min
- **Use:** User-uploaded practice recordings, offline mode
- **Flow:**
  1. iOS app records audio → m4a format
  2. Upload to S3 presigned URL
  3. Lambda triggers Whisper API
  4. Store transcript in PostgreSQL

**Secondary: Deepgram (Streaming)**
- **Cost:** $0.0043/min
- **Use:** Real-time conversation practice
- **Flow:**
  1. WebSocket connection from iOS
  2. Stream audio chunks
  3. Receive partial transcripts
  4. Send to LLM for immediate feedback

**Implementation:**
```swift
// iOS - Record and Upload
class AudioRecorder {
    func uploadToWhisper(audioURL: URL) async throws -> String {
        let data = try Data(contentsOf: audioURL)
        let request = makeMultipartRequest(fileData: data)
        let (response, _) = try await URLSession.shared.upload(for: request, from: data)
        return parseTranscript(response)
    }
}
```

### 3.2 AI Personas with Accents (TTS)

**Primary: Azure Neural TTS**
- **Cost:** ~$16 per 1M characters (~$0.024/min of speech)
- **Voice Mapping:**
  | Accent | Azure Voice Name | Use Case |
  |--------|------------------|----------|
  | Indian (Neutral) | en-IN-NeerjaNeural | IT/Business calls |
  | Indian (South) | en-IN-PraharNeural | Regional variety |
  | American | en-US-JennyNeural | General business |
  | British | en-GB-SoniaNeural | Formal settings |
  | Australian | en-AU-NatashaNeural | Casual business |

**Fallback: ElevenLabs (Premium only)**
- **Cost:** $206 per 1M characters
- **Use:** High-value enterprise clients, custom voice cloning

**Caching Strategy:**
- Cache common AI responses (greetings, feedback templates)
- Redis TTL: 24 hours for dynamic content, 7 days for static
- Estimated cache hit rate: 40-60%

### 3.3 Speaking Feedback Engine

**Tier 1: GPT-4o Mini (80% of requests)**
```
Prompt: Analyze this transcript for grammar and clarity:
User said: "{transcript}"
Context: {conversation_context}

Provide:
1. Grammar issues (if any)
2. Clarity score (1-10)
3. Suggested improvement
```
**Cost:** ~$0.001 per analysis

**Tier 2: GPT-4o (20% of requests - complex cases)**
```
Prompt: Deep pronunciation and cultural analysis:
Audio transcript: "{transcript}"
Expected response pattern: {context}
User's native language: {native_lang}
Target accent: {target_accent}

Provide:
1. Pronunciation issues (based on common {native_lang}→English patterns)
2. Cultural communication gaps
3. Confidence assessment
4. Specific exercises to improve
```
**Cost:** ~$0.02 per analysis

### 3.4 Conversation Scoring System

**Score Components:**
| Metric | Weight | Calculation Method |
|--------|--------|-------------------|
| Comprehension | 25% | STT confidence + GPT analysis |
| Grammar | 20% | GPT-4o Mini grammar check |
| Fluency | 20% | Words per minute + filler word ratio |
| Pronunciation | 20% | Azure assessment OR GPT inference |
| Cultural Fit | 15% | GPT-4o contextual analysis |

**Database Schema:**
```sql
-- Conversation sessions
CREATE TABLE conversations (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    scenario_type VARCHAR(50), -- 'business_call', 'presentation', etc.
    target_accent VARCHAR(20),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    overall_score DECIMAL(3,2), -- 0.00 to 10.00
    audio_url VARCHAR(500)
);

-- Detailed scores
CREATE TABLE conversation_scores (
    id UUID PRIMARY KEY,
    conversation_id UUID REFERENCES conversations(id),
    metric VARCHAR(50), -- 'comprehension', 'grammar', etc.
    score DECIMAL(3,2),
    feedback TEXT,
    created_at TIMESTAMP
);

-- Progress tracking
CREATE TABLE user_progress (
    user_id UUID PRIMARY KEY REFERENCES users(id),
    total_sessions INTEGER DEFAULT 0,
    avg_score DECIMAL(3,2),
    streak_days INTEGER,
    skill_breakdown JSONB, -- {"grammar": 7.5, "pronunciation": 6.8, ...}
    updated_at TIMESTAMP
);
```

---

## 4. Cost Breakdown & Projections

### 4.1 Per-Session Cost Analysis

**Assumptions per session:**
- Audio duration: 10 minutes (5 min user speech + 5 min AI)
- STT: 5 minutes of user speech
- TTS: 5 minutes of AI response (~750 words = ~5,000 chars)
- LLM: 2 feedback calls (1 quick, 1 detailed)

| Component | Provider | Calculation | Cost/Session |
|-----------|----------|-------------|--------------|
| STT | Whisper | 5 min × $0.006 | $0.030 |
| TTS | Azure Neural | 5,000 chars @ $16/1M | $0.080 |
| LLM (Tier 1) | GPT-4o Mini | ~10K tokens @ $0.15/1M | $0.002 |
| LLM (Tier 2) | GPT-4o | ~5K tokens @ $2.50/1M | $0.013 |
| Storage | S3 | 10MB @ $0.023/GB | $0.0002 |
| **Total per session** | | | **$0.125** |

### 4.2 Monthly Cost Projections

| Users | Sessions/User/Month | Total Sessions | AI Costs | Infrastructure* | **Total** | % of ¥100K Revenue |
|-------|---------------------|----------------|----------|-----------------|-----------|-------------------|
| 100 | 10 | 1,000 | $125 | $500 | **$625** | ~4.5% |
| 1,000 | 10 | 10,000 | $1,250 | $800 | **$2,050** | ~15% |
| 5,000 | 8 | 40,000 | $5,000 | $1,500 | **$6,500** | ~22% |
| 10,000 | 6 | 60,000 | $7,500 | $2,000 | **$9,500** | ~23% |
| 50,000 | 4 | 200,000 | $25,000 | $5,000 | **$30,000** | ~30% |

*Infrastructure includes: AWS/Azure compute, PostgreSQL, Redis, CDN, monitoring

### 4.3 Cost Optimization Strategies

1. **Batch Processing**
   - Non-urgent feedback → batch overnight
   - Savings: 40% on STT costs

2. **Aggressive Caching**
   - Cache TTS for common phrases
   - Cache GPT responses for similar errors
   - Savings: 30-40% on TTS/LLM

3. **Tiered Model Routing**
   - Simple grammar → GPT-4o Mini
   - Complex analysis → GPT-4o only when needed
   - Savings: 60% on LLM costs

4. **Audio Compression**
   - Use Opus codec: 50% smaller than m4a
   - Savings: 50% on storage + egress

5. **Volume Commitments**
   - At 10K+ users: negotiate Azure/Google commitments
   - Potential savings: 20-30%

---

## 5. Implementation Roadmap

### Phase 1: MVP (Months 1-2) - Budget: ~$500/month
**Goal:** Core functionality with minimal AI costs

**Components:**
- [ ] OpenAI Whisper integration (batch only)
- [ ] Azure TTS with 3 accents (Indian, American, British)
- [ ] GPT-4o Mini for all feedback
- [ ] Basic scoring (grammar + fluency only)
- [ ] PostgreSQL schema for users/conversations

**Tech Stack:**
- Backend: Node.js/Python FastAPI on AWS Lambda
- Database: PostgreSQL (RDS or Supabase)
- Cache: Redis (ElastiCache or Upstash)
- Storage: S3

### Phase 2: Enhanced Feedback (Months 3-4) - Budget: ~$1,500/month
**Goal:** Richer feedback and real-time capabilities

**Additions:**
- [ ] Deepgram streaming STT
- [ ] GPT-4o tier for complex analysis
- [ ] Azure pronunciation assessment (pilot)
- [ ] Progress tracking dashboard
- [ ] Redis caching layer

### Phase 3: Scale (Months 5-6) - Budget: ~$5,000/month
**Goal:** Enterprise-ready with cost controls

**Additions:**
- [ ] Batch processing pipeline
- [ ] Advanced analytics
- [ ] Custom voice cloning (ElevenLabs for enterprise tier)
- [ ] Multi-language support expansion
- [ ] Usage-based rate limiting

### Phase 4: Optimization (Months 7-12)
**Goal:** Maintain <30% cost ratio at scale

**Focus:**
- [ ] Self-hosted Whisper for high volume
- [ ] Fine-tuned models for specific accents
- [ ] Predictive caching based on user patterns
- [ ] Volume commitment negotiations

---

## 6. Code Examples

### 6.1 Whisper STT Integration

```python
# backend/services/stt.py
import openai
import boto3
from typing import Optional

class WhisperService:
    def __init__(self):
        self.client = openai.OpenAI()
        self.s3 = boto3.client('s3')
    
    async def transcribe(self, s3_url: str) -> dict:
        """Transcribe audio from S3 using Whisper"""
        # Download from S3
        bucket, key = parse_s3_url(s3_url)
        local_path = f"/tmp/{key.split('/')[-1]}"
        self.s3.download_file(bucket, key, local_path)
        
        # Call Whisper API
        with open(local_path, 'rb') as audio:
            transcript = self.client.audio.transcriptions.create(
                model="whisper-1",
                file=audio,
                response_format="verbose_json"
            )
        
        return {
            'text': transcript.text,
            'confidence': transcript.segments[0].avg_logprob if transcript.segments else 0,
            'duration': transcript.duration
        }
```

### 6.2 Azure TTS with Accent Selection

```python
# backend/services/tts.py
import azure.cognitiveservices.speech as speechsdk
from enum import Enum

class Accent(Enum):
    INDIAN_NEUTRAL = "en-IN-NeerjaNeural"
    INDIAN_SOUTH = "en-IN-PraharNeural"
    AMERICAN = "en-US-JennyNeural"
    BRITISH = "en-GB-SoniaNeural"
    AUSTRALIAN = "en-AU-NatashaNeural"

class AzureTTSService:
    def __init__(self, subscription_key: str, region: str = "eastus"):
        self.speech_config = speechsdk.SpeechConfig(
            subscription=subscription_key, 
            region=region
        )
    
    async def synthesize(
        self, 
        text: str, 
        accent: Accent = Accent.AMERICAN,
        speed: float = 1.0
    ) -> bytes:
        """Synthesize speech with specified accent"""
        self.speech_config.speech_synthesis_voice_name = accent.value
        
        synthesizer = speechsdk.SpeechSynthesizer(
            speech_config=self.speech_config,
            audio_config=None  # Return audio data
        )
        
        # Adjust prosody for naturalness
        ssml = f"""
        <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US">
            <voice name="{accent.value}">
                <prosody rate="{speed}">
                    {text}
                </prosody>
            </voice>
        </speak>
        """
        
        result = synthesizer.speak_ssml_async(ssml).get()
        return result.audio_data
```

### 6.3 Tiered LLM Feedback

```python
# backend/services/feedback.py
from openai import OpenAI
from typing import Literal

class FeedbackService:
    def __init__(self):
        self.client = OpenAI()
    
    async def analyze(
        self, 
        transcript: str,
        context: dict,
        complexity: Literal['simple', 'complex'] = 'simple'
    ) -> dict:
        """Route to appropriate model based on complexity"""
        
        if complexity == 'simple':
            return await self._analyze_simple(transcript)
        else:
            return await self._analyze_complex(transcript, context)
    
    async def _analyze_simple(self, transcript: str) -> dict:
        """Use GPT-4o Mini for grammar/clarity"""
        response = self.client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[{
                "role": "system",
                "content": """You are a speaking coach. Analyze the transcript for:
1. Grammar errors (list them)
2. Clarity score 1-10
3. One specific improvement tip
Respond in JSON format."""
            }, {
                "role": "user", 
                "content": transcript
            }],
            response_format={"type": "json_object"},
            max_tokens=500
        )
        return json.loads(response.choices[0].message.content)
    
    async def _analyze_complex(self, transcript: str, context: dict) -> dict:
        """Use GPT-4o for deep analysis"""
        response = self.client.chat.completions.create(
            model="gpt-4o",
            messages=[{
                "role": "system",
                "content": """You are an expert cross-cultural communication coach.
Analyze the speaking sample considering the user's native language and target accent.
Provide detailed feedback on pronunciation patterns, cultural nuances, and confidence."""
            }, {
                "role": "user",
                "content": f"Transcript: {transcript}\nContext: {json.dumps(context)}"
            }],
            response_format={"type": "json_object"},
            max_tokens=2000
        )
        return json.loads(response.choices[0].message.content)
```

### 6.4 Scoring Service

```python
# backend/services/scoring.py
from dataclasses import dataclass
from typing import List

@dataclass
class ScoreBreakdown:
    comprehension: float
    grammar: float
    fluency: float
    pronunciation: float
    cultural_fit: float
    overall: float

class ConversationScorer:
    def __init__(
        self, 
        stt_service,
        tts_service,
        llm_service,
        db_session
    ):
        self.stt = stt_service
        self.tts = tts_service
        self.llm = llm_service
        self.db = db_session
    
    async def score_conversation(
        self, 
        conversation_id: str,
        audio_segments: List[dict]
    ) -> ScoreBreakdown:
        """Calculate comprehensive conversation scores"""
        
        scores = ScoreBreakdown(
            comprehension=0,
            grammar=0,
            fluency=0,
            pronunciation=0,
            cultural_fit=0,
            overall=0
        )
        
        for segment in audio_segments:
            # STT with confidence
            transcript = await self.stt.transcribe(segment['audio_url'])
            scores.comprehension += transcript['confidence'] * 10
            
            # Grammar analysis
            grammar_result = await self.llm.analyze(
                transcript['text'], 
                complexity='simple'
            )
            scores.grammar += grammar_result.get('clarity_score', 5)
            
            # Fluency (words per minute)
            wpm = self._calculate_wpm(transcript['text'], segment['duration'])
            scores.fluency += self._normalize_wpm(wpm)
        
        # Average across segments
        n = len(audio_segments)
        scores.comprehension = round(scores.comprehension / n, 2)
        scores.grammar = round(scores.grammar / n, 2)
        scores.fluency = round(scores.fluency / n, 2)
        
        # Calculate overall
        scores.overall = round(
            scores.comprehension * 0.25 +
            scores.grammar * 0.20 +
            scores.fluency * 0.20 +
            scores.pronunciation * 0.20 +
            scores.cultural_fit * 0.15,
            2
        )
        
        # Save to database
        await self._save_scores(conversation_id, scores)
        
        return scores
    
    def _calculate_wpm(self, text: str, duration_sec: float) -> float:
        words = len(text.split())
        return (words / duration_sec) * 60
    
    def _normalize_wpm(self, wpm: float) -> float:
        """Normalize WPM to 0-10 scale (optimal: 120-150 wpm)"""
        if 120 <= wpm <= 150:
            return 10
        elif wpm < 80:
            return max(0, wpm / 8)
        elif wpm > 180:
            return max(0, 10 - (wpm - 150) / 10)
        else:
            return 10 - abs(wpm - 135) / 15
```

### 6.5 iOS Audio Recording with Compression

```swift
// Culturalbility/Audio/AudioRecorder.swift
import AVFoundation
import OpusSDK

class AudioRecorder: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private let settings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 16000,  // Optimal for STT
        AVNumberOfChannelsKey: 1,  // Mono
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        AVEncoderBitRateKey: 32000  // Compressed
    ]
    
    @Published var isRecording = false
    
    func startRecording() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.record, mode: .default)
        try session.setActive(true)
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("recording.m4a")
        
        audioRecorder = try AVAudioRecorder(url: url, settings: settings)
        audioRecorder?.record()
        isRecording = true
    }
    
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        isRecording = false
        return audioRecorder?.url
    }
    
    func compressForUpload(url: URL) async throws -> Data {
        // Convert to Opus for 50% size reduction
        let audioData = try Data(contentsOf: url)
        return try OpusEncoder.encode(audioData, sampleRate: 16000)
    }
}
```

---

## 7. Monitoring & Cost Controls

### 7.1 Cost Alerting Thresholds

| Metric | Warning | Critical | Action |
|--------|---------|----------|--------|
| Daily AI spend | $50 | $100 | Switch to batch processing |
| Per-user daily cost | $0.50 | $1.00 | Rate limit user |
| Cache hit rate | <50% | <30% | Review caching strategy |
| API error rate | >5% | >10% | Failover to backup provider |

### 7.2 Rate Limiting Strategy

```python
# backend/middleware/rate_limit.py
from redis import Redis
from functools import wraps

class RateLimiter:
    def __init__(self, redis: Redis):
        self.redis = redis
    
    def limit_ai_calls(self, user_tier: str = "free"):
        """Rate limit based on user tier"""
        limits = {
            'free': {'requests_per_hour': 10, 'ai_cost_daily': 0.10},
            'basic': {'requests_per_hour': 50, 'ai_cost_daily': 1.00},
            'pro': {'requests_per_hour': 200, 'ai_cost_daily': 5.00},
            'enterprise': {'requests_per_hour': 1000, 'ai_cost_daily': 50.00}
        }
        return limits.get(user_tier, limits['free'])
```

---

## 8. Risk Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| OpenAI API rate limits | High | Implement Deepgram fallback |
| Azure TTS latency | Medium | Cache + preload common responses |
| Cost overruns | High | Hard limits + alerting + tiered access |
| Accent quality complaints | Medium | A/B test ElevenLabs vs Azure |
| Data privacy (enterprise) | High | Offer Azure-only stack option |

---

## 9. Key Decisions Summary

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Primary STT | Whisper (batch) + Deepgram (streaming) | Best accuracy + cost balance |
| Primary TTS | Azure Neural | Best accent support, especially Indian |
| Primary LLM | GPT-4o Mini (80%) + GPT-4o (20%) | Cost-optimized tiered approach |
| Pronunciation | Azure Assessment (optional) | Only when enterprise requires |
| Cache | Redis | 40-60% cost reduction potential |
| Storage | S3 with Opus compression | 50% cost reduction |

---

## 10. Next Steps

1. **Week 1:** Set up AWS/Azure infrastructure, PostgreSQL schema
2. **Week 2:** Integrate Whisper STT, Azure TTS
3. **Week 3:** Build GPT-4o Mini feedback pipeline
4. **Week 4:** iOS audio recording + upload integration
5. **Week 5:** Scoring algorithm + progress tracking
6. **Week 6:** Testing + cost optimization tuning

---

*Document generated for Culturalbility AI Architecture planning. All pricing as of March 2025 - verify current rates before implementation.*
