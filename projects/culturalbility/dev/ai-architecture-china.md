# Culturalbility AI Architecture Design (China-Compatible Version)

> **Version:** 2.0 - China Edition  
> **Date:** March 2025  
> **Agent:** Yang (Developer)  
> **Constraint:** Max ¥30K/month (~$4,200 USD) at ¥100K revenue  
> **Compliance:** ICP License, Data Sovereignty, China Audio AI Regulations

---

## Executive Summary

This document outlines a **China-compliant, cost-optimized AI architecture** for Culturalbility's B2B cross-cultural communication app. All services have been selected specifically for operation within mainland China without VPN/proxy requirements.

**Key Design Principles:**
1. **China-First Services** - Only providers with mainland China infrastructure (阿里云, 讯飞, 百度, DeepSeek, 月之暗面)
2. **Data Sovereignty** - All data processing stays within China borders (ICP compliance)
3. **Tiered Model Strategy** - Use cost-effective Chinese models for simple tasks, premium models only when necessary
4. **Intelligent Caching** - Cache common AI responses to reduce redundant API calls
5. **Hybrid Architecture** - Combine best-of-breed Chinese providers rather than single-vendor lock-in

---

## 1. API Provider Comparison (China-Compatible)

### 1.1 Speech-to-Text (STT)

| Provider | Price/min | Streaming | Accuracy | Pros | Cons |
|----------|-----------|-----------|----------|------|------|
| **iFlytek 科大讯飞** | ¥0.04-0.08 | ✅ | 97-98% | Best Chinese STT, 60+ languages, real-time, mainland servers | Slightly higher cost |
| **Alibaba Cloud Speech** | ¥0.025-0.05 | ✅ | 95-97% | Cheapest, Alibaba ecosystem, good English | Less accurate on accents |
| **Baidu Speech** | ¥0.03-0.06 | ✅ | 94-96% | Good Chinese/English mix, affordable | Lower quality on Indian accents |
| **Tencent ASR** | ¥0.03-0.07 | ✅ | 95-97% | Strong ecosystem, reliable | Pricing complexity |

**Recommendation:** Use **iFlytek** for primary STT (best accuracy, China-compliant) and **Alibaba Cloud Speech** as cost-optimized fallback.

**China Compliance Note:** All three providers maintain servers in mainland China with data processing strictly within China borders. iFlytek is the domestic leader in voice AI with government-level certifications.

### 1.2 Text-to-Speech (TTS) - Accent Simulation

| Provider | Price | Quality | Accent Support | Latency | China Availability |
|----------|-------|---------|----------------|---------|-------------------|
| **Azure Neural** | ¥110/1M chars | ⭐⭐⭐⭐ | Good for Indian, British accents | 100ms | ✅ Via 21Vianet |
| **iFlytek TTS** | ¥80-120/1M chars | ⭐⭐⭐⭐⭐ | 60+ languages, excellent Indian accent | 80ms | ✅ Native |
| **Alibaba Cloud TTS** | ¥60/1M chars | ⭐⭐⭐⭐ | 30+ languages, good quality | 120ms | ✅ Native |
| **Baidu TTS** | ¥50/1M chars | ⭐⭐⭐⭐ | Good for Chinese-English mix | 150ms | ✅ Native |

**Recommendation:** Primary: **iFlytek TTS** (best quality, domestic leader). Keep **Azure Neural** as backup via 21Vianet partnership (微软云与世纪互联合作).

### 1.3 LLM for Feedback & Scoring

| Model | Input/1M | Output/1M | Best For | China Availability |
|-------|----------|-----------|----------|-------------------|
| **DeepSeek V3** | ¥2.00 | ¥8.00 | Complex feedback, reasoning, excellent value | ✅ Native |
| **Kimi (月之暗面)** | ¥3.00 | ¥12.00 | Nuanced language feedback, long context | ✅ Native |
| **Qwen (通义千问)** | ¥2.00 | ¥6.00 | Alibaba ecosystem, good multilingual | ✅ Native |
| **ERNIE (百度)** | ¥3.00 | ¥9.00 | Chinese language tasks | ✅ Native |
| **GPT-4o Mini** | $0.15 | $0.60 | Simple grammar checks | ❌ Requires VPN |

**Recommendation:** Use **DeepSeek V3** as primary (best value, Chinese company). **Kimi** for complex nuanced feedback. **Qwen** as backup/alternative.

**China Compliance Note:** DeepSeek (深度求索), Moonshot AI (月之暗面), and Alibaba Cloud are all domestic Chinese companies with servers in mainland China.

### 1.4 Pronunciation Assessment

| Provider | Price | Features | China Availability |
|----------|-------|----------|-------------------|
| **iFlytek Speech Evaluation** | ¥0.05/assessment | Phoneme-level, prosody, fluency, pronunciation score | ✅ Native |
| **Azure Pronunciation Assessment** | ¥2.00/hour add-on | Good quality but overseas processing | ⚠️ Via 21Vianet only |
| **Alibaba Speech Assessment** | ¥0.03/assessment | Basic pronunciation scoring | ✅ Native |

**Recommendation:** **iFlytek Speech Evaluation** is the domestic gold standard for pronunciation assessment, used by major Chinese language learning apps.

---

## 2. Recommended Architecture (China-Compliant)

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
│                      API GATEWAY (阿里云 API Gateway)                        │
│                    Rate Limiting, Auth, Load Balancing                      │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
          ┌───────────────────────────┼───────────────────────────┐
          ▼                           ▼                           ▼
┌─────────────────────┐  ┌─────────────────────┐  ┌─────────────────────────────┐
│   SPEECH SERVICES   │  │   AI PROCESSING     │  │   DATA LAYER                │
│  ┌───────────────┐  │  │  ┌───────────────┐  │  │  ┌─────────────────────┐    │
│  │ iFlytek       │◄─┼──┼──┤ DeepSeek V3   │  │  │  │ 阿里云 RDS          │    │
│  │ Speech-to-Text│  │  │  │ - Grammar     │  │  │  │ - User profiles     │    │
│  │ (Primary STT) │  │  │  │ - Scoring     │  │  │  │ - Conversation logs │    │
│  └───────────────┘  │  │  └───────────────┘  │  │  │ - Progress tracking │    │
│                     │  │                     │  │  └─────────────────────┘    │
│  ┌───────────────┐  │  │  ┌───────────────┐  │  │                             │
│  │ Alibaba Cloud │◄─┼──┼──│ Kimi (月之暗面)│  │  │  ┌─────────────────────┐    │
│  │ Speech        │  │  │  │ - Complex     │  │  │  │ 阿里云 Redis        │    │
│  │ (Fallback)    │  │  │  │   feedback    │  │  │  │ - Session cache     │    │
│  └───────────────┘  │  │  │  - Accent     │  │  │  │ - TTS cache         │    │
│                     │  │  │    analysis   │  │  │  │ - Rate limiting     │    │
│  ┌───────────────┐  │  │  └───────────────┘  │  │  └─────────────────────┘    │
│  │ iFlytek       │◄─┼──┤                     │  │                             │
│  │ TTS           │  │  │  ┌───────────────┐  │  │  ┌─────────────────────┐    │
│  │ - Indian      │  │  │  │ Qwen (通义千问)│◄─┼──┼──┤ 阿里云 OSS          │    │
│  │ - American    │  │  │  │ (Backup LLM)  │  │  │  │ - Audio files       │    │
│  │ - British     │  │  │  └───────────────┘  │  │  │ - Training data     │    │
│  └───────────────┘  │  │                     │  │  └─────────────────────┘    │
│                     │  │  ┌───────────────┐  │  │                             │
│  ┌───────────────┐  │  │  │ iFlytek       │  │  │  ┌─────────────────────┐    │
│  │ Azure Neural  │◄─┼──┼──│ Speech Eval   │  │  │  │ 阿里云 Log Service  │    │
│  │ TTS (Backup)  │  │  │  │ (Pronunciation)│  │  │  │ - Analytics         │    │
│  └───────────────┘  │  │  └───────────────┘  │  │  │ - Monitoring        │    │
└─────────────────────┘  └─────────────────────┘  │  └─────────────────────┘    │
                                                   └─────────────────────────────┘
```

---

## 3. Component Architecture Details

### 3.1 Listening & Comprehension (STT)

**Primary: iFlytek Speech-to-Text**
- **Cost:** ¥0.04-0.08/min (¥0.04 for batch, ¥0.08 for real-time)
- **Use:** All transcription needs - both batch and streaming
- **Flow:**
  1. iOS app records audio → m4a format
  2. Upload to 阿里云 OSS presigned URL
  3. 阿里云 Function Compute triggers iFlytek API
  4. Store transcript in 阿里云 RDS PostgreSQL

**Fallback: Alibaba Cloud Speech**
- **Cost:** ¥0.025-0.05/min
- **Use:** Cost-optimized scenarios, fallback if iFlytek unavailable

**Implementation:**
```swift
// iOS - Record and Upload (China CDN)
class AudioRecorder {
    func uploadToIFlytek(audioURL: URL) async throws -> String {
        let data = try Data(contentsOf: audioURL)
        // Upload to 阿里云 OSS (domestic endpoint)
        let ossClient = OSSClient(endpoint: "oss-cn-beijing.aliyuncs.com", ...)
        let request = makeMultipartRequest(fileData: data)
        let (response, _) = try await URLSession.shared.upload(for: request, from: data)
        return parseTranscript(response)
    }
}
```

### 3.2 AI Personas with Accents (TTS)

**Primary: iFlytek TTS**
- **Cost:** ¥80-120 per 1M characters (~¥0.12/min of speech)
- **Voice Mapping:**
  | Accent | iFlytek Voice ID | Use Case |
  |--------|------------------|----------|
  | Indian (Neutral) | en-IN-Neural-01 | IT/Business calls |
  | Indian (South) | en-IN-Neural-02 | Regional variety |
  | American | en-US-Neural-01 | General business |
  | British | en-GB-Neural-01 | Formal settings |
  | Australian | en-AU-Neural-01 | Casual business |

**Fallback: Azure Neural TTS (via 21Vianet)**
- **Cost:** ~¥110 per 1M characters
- **Use:** Backup when iFlytek unavailable

**Alternative: Alibaba Cloud TTS**
- **Cost:** ¥60 per 1M characters
- **Use:** Cost-sensitive scenarios

**Caching Strategy:**
- Cache TTS responses in 阿里云 Redis
- Redis TTL: 24 hours for dynamic content, 7 days for static
- Estimated cache hit rate: 40-60%

### 3.3 Speaking Feedback Engine

**Tier 1: DeepSeek V3 (80% of requests)**
```
Prompt: Analyze this transcript for grammar and clarity:
User said: "{transcript}"
Context: {conversation_context}
User native language: {native_lang}
Target accent: {target_accent}

Provide:
1. Grammar issues (if any)
2. Clarity score (1-10)
3. Suggested improvement
4. Cultural context notes
```
**Cost:** ~¥0.005 per analysis (¥2/1M tokens input, ¥8/1M tokens output)

**Tier 2: Kimi 月之暗面 (20% of requests - complex cases)**
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
**Cost:** ~¥0.02 per analysis

**Backup: Qwen 通义千问**
- **Use:** Fallback when DeepSeek/Kimi unavailable
- **Cost:** ¥2/1M input, ¥6/1M output tokens

### 3.4 Pronunciation Assessment (NEW - iFlytek)

**iFlytek Speech Evaluation**
- **Cost:** ¥0.05 per assessment
- **Features:**
  - Phoneme-level accuracy scoring
  - Prosody analysis (intonation, stress, rhythm)
  - Fluency scoring (words per minute, pauses)
  - Overall pronunciation score (0-100)
  - Specific error detection (substitutions, deletions, insertions)

**Flow:**
1. User uploads audio to OSS
2. Call iFlytek Speech Evaluation API
3. Receive detailed pronunciation report
4. Store results in RDS
5. Generate personalized feedback via DeepSeek

**Integration:**
```python
# backend/services/pronunciation.py
import requests
import json

class iFlytekPronunciationService:
    def __init__(self, app_id, api_key, api_secret):
        self.app_id = app_id
        self.api_key = api_key
        self.api_secret = api_secret
        self.base_url = "https://api.xfyun.cn/v1/service/v1/ise"
    
    async def evaluate(self, audio_url: str, text: str) -> dict:
        """
        Evaluate pronunciation using iFlytek Speech Evaluation
        """
        # Download audio from OSS
        audio_data = await self._download_from_oss(audio_url)
        
        # Build request
        headers = self._build_auth_headers()
        params = {
            "aue": "raw",  # Audio format
            "language": "en_us",
            "category": "read_sentence",
            "text": text,
        }
        
        # Call iFlytek API
        response = requests.post(
            self.base_url,
            headers=headers,
            data=json.dumps(params),
            files={"audio": audio_data}
        )
        
        result = response.json()
        
        return {
            'overall_score': result['data']['overall'],
            'fluency_score': result['data']['fluency'],
            'accuracy_score': result['data']['accuracy'],
            'integrity_score': result['data']['integrity'],
            'phoneme_details': result['data']['word_scores'],
            'xml_result': result['data']['xml_result']  # Detailed phoneme analysis
        }
```

### 3.5 Conversation Scoring System

**Updated Score Components:**
| Metric | Weight | Calculation Method |
|--------|--------|-------------------|
| Comprehension | 25% | iFlytek STT confidence + DeepSeek analysis |
| Grammar | 20% | DeepSeek grammar check |
| Fluency | 20% | Words per minute + filler word ratio |
| Pronunciation | 20% | iFlytek Speech Evaluation score |
| Cultural Fit | 15% | DeepSeek/Kimi contextual analysis |

---

## 4. Cost Breakdown & Projections (RMB)

### 4.1 Per-Session Cost Analysis

**Assumptions per session:**
- Audio duration: 10 minutes (5 min user speech + 5 min AI)
- STT: 5 minutes of user speech
- TTS: 5 minutes of AI response (~750 words = ~5,000 chars)
- LLM: 2 feedback calls (1 quick via DeepSeek, 1 detailed via Kimi)
- Pronunciation: 1 iFlytek assessment

| Component | Provider | Calculation | Cost/Session |
|-----------|----------|-------------|--------------|
| STT | iFlytek | 5 min × ¥0.08 | ¥0.40 |
| TTS | iFlytek | 5,000 chars @ ¥120/1M | ¥0.60 |
| LLM (Tier 1) | DeepSeek V3 | ~10K tokens @ ¥2/1M | ¥0.02 |
| LLM (Tier 2) | Kimi | ~5K tokens @ ¥3/1M | ¥0.015 |
| Pronunciation | iFlytek Eval | 1 assessment × ¥0.05 | ¥0.05 |
| Storage | 阿里云 OSS | 10MB @ ¥0.12/GB | ¥0.001 |
| **Total per session** | | | **¥1.086** (~$0.15) |

### 4.2 Monthly Cost Projections (RMB)

| Users | Sessions/User/Month | Total Sessions | AI Costs | Infrastructure* | **Total** | % of ¥100K Revenue |
|-------|---------------------|----------------|----------|-----------------|-----------|-------------------|
| 100 | 10 | 1,000 | ¥1,086 | ¥3,500 | **¥4,586** | ~4.6% |
| 1,000 | 10 | 10,000 | ¥10,860 | ¥5,600 | **¥16,460** | ~16% |
| 5,000 | 8 | 40,000 | ¥43,440 | ¥10,500 | **¥53,940** | ~54% |
| 10,000 | 6 | 60,000 | ¥65,160 | ¥14,000 | **¥79,160** | ~79% |
| 50,000 | 4 | 200,000 | ¥217,200 | ¥35,000 | **¥252,200** | ~252%* |

*At 50K users, cost exceeds revenue - need volume discounts or pricing model adjustment
*Infrastructure includes: 阿里云 ECS/Function Compute, RDS PostgreSQL, Redis, OSS, CDN, 阿里云监控

### 4.3 Cost Optimization Strategies

1. **Volume Discounts (Chinese Providers)**
   - iFlytek: 20-30% discount at 100K+ minutes/month
   - 阿里云: Enterprise agreements available at scale
   - DeepSeek: Commitment-based pricing for high volume
   - Potential savings: 25-40% at scale

2. **Aggressive Caching**
   - Cache TTS for common phrases
   - Cache DeepSeek responses for similar errors
   - 阿里云 Redis for distributed caching
   - Savings: 30-40% on TTS/LLM

3. **Tiered Model Routing**
   - Simple grammar → DeepSeek V3
   - Complex analysis → Kimi only when needed
   - Fallback → Qwen for non-critical tasks
   - Savings: 50% on LLM costs

4. **Audio Compression**
   - Use Opus codec: 50% smaller than m4a
   - iFlytek supports compressed formats natively
   - Savings: 50% on storage + egress

5. **Batch Processing**
   - Non-urgent feedback → batch overnight
   - Savings: 40% on STT costs (batch vs real-time)

---

## 5. China Compliance Section

### 5.1 Data Sovereignty Requirements

**Regulatory Framework:**
- **网络安全法 (Cybersecurity Law)** - Effective June 2017
- **数据安全法 (Data Security Law)** - Effective September 2021
- **个人信息保护法 (PIPL)** - Effective November 2021

**Key Requirements:**
| Requirement | Implementation |
|-------------|----------------|
| Data Localization | All user audio, transcripts, and personal data must be stored in mainland China |
| Cross-border Transfer | Requires security assessment if data leaves China |
| Processing Location | AI processing must occur on servers physically located in China |

**Architecture Compliance:**
- ✅ All services: iFlytek, Alibaba Cloud, DeepSeek, Moonshot AI have mainland China servers
- ✅ 阿里云 OSS buckets in Beijing/Shanghai regions only
- ✅ 阿里云 RDS with encryption at rest (国密 SM4)
- ❌ No data processing on overseas servers (AWS US, Azure US, etc.)

### 5.2 ICP License Requirements

**ICP备案 (ICP Filing) vs ICP许可证 (ICP License):**

| Type | Requirement | Timeline | Cost |
|------|-------------|----------|------|
| **ICP Filing (备案)** | Required for all websites/apps | 15-20 days | Free |
| **ICP License (许可证)** | Required for commercial internet information services | 60-90 days | ¥50K-100K+ |

**Audio AI Specific Considerations:**
- Interactive voice services may require additional **增值电信业务经营许可证 (VAT License)**
- Content moderation required for user-generated audio
- Real-name registration for all users (手机号实名认证)

**Required Documentation:**
1. 营业执照 (Business License)
2. 法人身份证 (Legal representative ID)
3. 域名证书 (Domain certificate - .cn preferred)
4. 服务器托管协议 (Server hosting agreement with 阿里云)
5. 信息安全管理制度 (Information security management policy)

### 5.3 Audio AI Content Regulations

**生成式人工智能服务管理暂行办法 (GenAI Measures) - August 2023:**

| Requirement | Implementation |
|-------------|----------------|
| 算法备案 (Algorithm Filing) | Required for AI services - file with 网信办 |
| Content Moderation | Real-time filtering of prohibited content |
| User Verification | Real-name registration required |
| Labeling | AI-generated content must be labeled |
| Training Data | Must comply with copyright and personal data laws |

**Implementation Strategy:**
```python
# backend/middleware/content_moderation.py
class ContentModerator:
    """
    内容审核 - Required for China compliance
    """
    def __init__(self):
        self.aliyun_green = AliyunGreenClient()  # 阿里云内容安全
    
    async def check_audio_content(self, audio_url: str) -> dict:
        """
        Check audio for prohibited content
        Required for user-generated content
        """
        result = await self.aliyun_green.scan_audio(audio_url)
        
        return {
            'is_clean': result.risk_level == 'normal',
            'risk_level': result.risk_level,  # normal, risky, forbidden
            'categories': result.labels,  # porn, violence, politics, etc.
            'action': 'allow' if result.risk_level == 'normal' else 'block'
        }
    
    async def check_text_content(self, text: str) -> dict:
        """Check transcript for prohibited content"""
        result = await self.aliyun_green.scan_text(text)
        return result
```

**Required Content Categories to Block:**
- 色情 (Pornography)
- 暴力 (Violence)
- 恐怖主义 (Terrorism)
- 政治敏感 (Political sensitivity)
- 违法信息 (Illegal information)

### 5.4 Compliance Checklist

| Item | Status | Notes |
|------|--------|-------|
| ICP Filing | ⬜ Required | Apply after domain registration |
| ICP License | ⬜ Required if commercial | Consult with 阿里云代理商 |
| 算法备案 | ⬜ Required | File with 网信办 within 10 days of launch |
| 等保测评 | ⬜ Recommended | Level 2 or 3 based on data sensitivity |
| 隐私政策 | ⬜ Required | Must comply with PIPL |
| 用户协议 | ⬜ Required | Include AI service terms |
| 数据分类分级 | ⬜ Required | Per Data Security Law |
| 应急响应预案 | ⬜ Required | Data breach response plan |

### 5.5 Data Processing Agreement (DPA)

All Chinese providers must sign data processing agreements:

| Provider | DPA Available | Data Location |
|----------|---------------|---------------|
| iFlytek | ✅ | 北京, 合肥, 上海 |
| 阿里云 | ✅ | 中国境内多个可用区 |
| DeepSeek | ✅ | 杭州 |
| Moonshot AI | ✅ | 北京 |

---

## 6. Implementation Roadmap

### Phase 1: MVP (Months 1-2) - Budget: ~¥3,500/month
**Goal:** Core functionality with China-compliant services

**Components:**
- [ ] iFlytek STT integration (batch only)
- [ ] iFlytek TTS with 3 accents (Indian, American, British)
- [ ] DeepSeek V3 for all feedback
- [ ] Basic scoring (grammar + fluency only)
- [ ] 阿里云 RDS PostgreSQL schema
- [ ] ICP Filing application

**Tech Stack:**
- Backend: Node.js/Python FastAPI on 阿里云 Function Compute
- Database: 阿里云 RDS PostgreSQL
- Cache: 阿里云 Redis
- Storage: 阿里云 OSS
- CDN: 阿里云 CDN (domestic)

### Phase 2: Enhanced Feedback (Months 3-4) - Budget: ~¥8,000/month
**Goal:** Richer feedback and real-time capabilities

**Additions:**
- [ ] iFlytek real-time streaming STT
- [ ] Kimi tier for complex analysis
- [ ] iFlytek Speech Evaluation (pronunciation)
- [ ] Progress tracking dashboard
- [ ] 算法备案 (Algorithm Filing)

### Phase 3: Scale (Months 5-6) - Budget: ~¥15,000/month
**Goal:** Enterprise-ready with cost controls

**Additions:**
- [ ] Batch processing pipeline
- [ ] Advanced analytics (阿里云 Log Service)
- [ ] Qwen backup LLM integration
- [ ] Multi-language support expansion
- [ ] Usage-based rate limiting

### Phase 4: Optimization (Months 7-12)
**Goal:** Maintain <30% cost ratio at scale

**Focus:**
- [ ] Volume commitment negotiations with iFlytek/阿里云
- [ ] Fine-tuned DeepSeek models for specific accents
- [ ] Predictive caching based on user patterns
- [ ] 等保测评 (Level 2/3 certification)

---

## 7. Code Examples (China SDKs)

### 7.1 iFlytek STT Integration

```python
# backend/services/stt_iflytek.py
import requests
import json
import hashlib
import hmac
import base64
from datetime import datetime

class iFlytekSTTService:
    """
    科大讯飞语音识别服务
    iFlytek Speech-to-Text Service
    """
    def __init__(self, app_id, api_key, api_secret):
        self.app_id = app_id
        self.api_key = api_key
        self.api_secret = api_secret
        self.base_url = "https://iat-api.xfyun.cn/v2/iat"
    
    def _build_auth_url(self) -> str:
        """Build authenticated URL with signature"""
        date = datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')
        signature_origin = f"host: iat-api.xfyun.cn\ndate: {date}\nGET /v2/iat HTTP/1.1"
        
        signature_sha = hmac.new(
            self.api_secret.encode('utf-8'),
            signature_origin.encode('utf-8'),
            digestmod=hashlib.sha256
        ).digest()
        signature_sha = base64.b64encode(signature_sha).decode('utf-8')
        
        authorization_origin = f'api_key="{self.api_key}", algorithm="hmac-sha256", '
        authorization_origin += f'headers="host date request-line", signature="{signature_sha}"'
        authorization = base64.b64encode(authorization_origin.encode('utf-8')).decode('utf-8')
        
        return f"{self.base_url}?authorization={authorization}&date={date}&host=iat-api.xfyun.cn"
    
    async def transcribe(self, audio_url: str) -> dict:
        """Transcribe audio using iFlytek"""
        # Download from 阿里云 OSS
        audio_data = await self._download_from_oss(audio_url)
        
        # WebSocket connection for real-time transcription
        auth_url = self._build_auth_url()
        
        # iFlytek requires WebSocket for streaming
        # Send audio in chunks
        frames = self._slice_audio(audio_data)
        
        transcript_parts = []
        async with websockets.connect(auth_url) as ws:
            for frame in frames:
                await ws.send(json.dumps({
                    "common": {"app_id": self.app_id},
                    "business": {
                        "language": "en_us",
                        "domain": "iat",
                        "accent": "mandarin",
                        "vad_eos": 3000
                    },
                    "data": {
                        "status": 2 if frame['is_last'] else 1,
                        "format": "audio/L16;rate=16000",
                        "encoding": "raw",
                        "audio": base64.b64encode(frame['data']).decode('utf-8')
                    }
                }))
                
                response = await ws.recv()
                result = json.loads(response)
                if 'data' in result and 'result' in result['data']:
                    transcript_parts.append(result['data']['result']['ws'])
        
        return {
            'text': self._parse_transcript(transcript_parts),
            'confidence': result['data'].get('score', 0),
            'provider': 'iFlytek'
        }
```

### 7.2 DeepSeek LLM Integration

```python
# backend/services/llm_deepseek.py
import requests
import json

class DeepSeekService:
    """
    DeepSeek V3 LLM Service
    深度求索大语言模型服务
    """
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.base_url = "https://api.deepseek.com/v1"
    
    async def analyze_grammar(self, transcript: str) -> dict:
        """Grammar analysis using DeepSeek V3"""
        response = requests.post(
            f"{self.base_url}/chat/completions",
            headers={
                "Authorization": f"Bearer {self.api_key}",
                "Content-Type": "application/json"
            },
            json={
                "model": "deepseek-chat",
                "messages": [
                    {
                        "role": "system",
                        "content": """You are a speaking coach analyzing English transcripts.
Analyze for grammar errors and provide feedback in JSON format:
{
    "grammar_issues": [],
    "clarity_score": 0-10,
    "improvement_tip": "",
    "corrected_version": ""
}"""
                    },
                    {
                        "role": "user",
                        "content": transcript
                    }
                ],
                "response_format": {"type": "json_object"},
                "max_tokens": 500,
                "temperature": 0.3
            }
        )
        
        result = response.json()
        return json.loads(result['choices'][0]['message']['content'])
    
    async def analyze_cultural_context(
        self, 
        transcript: str, 
        native_lang: str,
        target_accent: str
    ) -> dict:
        """Cultural context analysis"""
        response = requests.post(
            f"{self.base_url}/chat/completions",
            headers={
                "Authorization": f"Bearer {self.api_key}",
                "Content-Type": "application/json"
            },
            json={
                "model": "deepseek-chat",
                "messages": [
                    {
                        "role": "system",
                        "content": f"""You are a cross-cultural communication expert.
The user is a {native_lang} speaker practicing {target_accent} English.
Analyze their communication style and provide cultural feedback."""
                    },
                    {
                        "role": "user",
                        "content": transcript
                    }
                ],
                "max_tokens": 1000,
                "temperature": 0.5
            }
        )
        
        result = response.json()
        return {
            'feedback': result['choices'][0]['message']['content'],
            'tokens_used': result['usage']['total_tokens']
        }
```

### 7.3 Kimi (Moonshot AI) Integration

```python
# backend/services/llm_kimi.py
import requests
import json

class KimiService:
    """
    Moonshot AI Kimi LLM Service
    月之暗面大语言模型服务
    """
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.base_url = "https://api.moonshot.cn/v1"
    
    async def complex_analysis(self, transcript: str, context: dict) -> dict:
        """Complex feedback using Kimi"""
        response = requests.post(
            f"{self.base_url}/chat/completions",
            headers={
                "Authorization": f"Bearer {self.api_key}",
                "Content-Type": "application/json"
            },
            json={
                "model": "moonshot-v1-128k",  # 128K context window
                "messages": [
                    {
                        "role": "system",
                        "content": """You are an expert language coach specializing in 
business English for cross-cultural communication. Provide detailed, nuanced feedback
focusing on pronunciation patterns, cultural nuances, and professional communication."""
                    },
                    {
                        "role": "user",
                        "content": f"Transcript: {transcript}\nContext: {json.dumps(context, ensure_ascii=False)}"
                    }
                ],
                "max_tokens": 2000,
                "temperature": 0.4
            }
        )
        
        result = response.json()
        return {
            'analysis': result['choices'][0]['message']['content'],
            'tokens_used': result['usage']['total_tokens']
        }
```

### 7.4 iFlytek TTS Integration

```python
# backend/services/tts_iflytek.py
import requests
import json
import base64
from enum import Enum

class iFlytekAccent(Enum):
    INDIAN_NEUTRAL = "en-IN-Neural-01"
    INDIAN_SOUTH = "en-IN-Neural-02"
    AMERICAN = "en-US-Neural-01"
    BRITISH = "en-GB-Neural-01"
    AUSTRALIAN = "en-AU-Neural-01"

class iFlytekTTSService:
    """
    科大讯飞语音合成服务
    iFlytek Text-to-Speech Service
    """
    def __init__(self, app_id, api_key, api_secret):
        self.app_id = app_id
        self.api_key = api_key
        self.api_secret = api_secret
        self.base_url = "https://tts-api.xfyun.cn/v2/tts"
    
    async def synthesize(
        self,
        text: str,
        accent: iFlytekAccent = iFlytekAccent.AMERICAN,
        speed: int = 50  # 0-100, 50 is normal
    ) -> bytes:
        """Synthesize speech with specified accent"""
        
        # Build authentication
        from datetime import datetime
        date = datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')
        
        # Request body
        body = {
            "common": {
                "app_id": self.app_id
            },
            "business": {
                "aue": "lame",  # MP3 format
                "sfl": 1,  # Streaming
                "auf": "audio/L16;rate=16000",
                "vcn": accent.value,
                "speed": speed,
                "volume": 50,
                "pitch": 50,
                "bgs": 0,
                "tte": "UTF8"
            },
            "data": {
                "status": 2,
                "text": base64.b64encode(text.encode('utf-8')).decode('utf-8')
            }
        }
        
        # HTTP request to iFlytek TTS API
        response = requests.post(
            self.base_url,
            headers=self._build_headers(date),
            json=body
        )
        
        result = response.json()
        
        if result['code'] != 0:
            raise Exception(f"TTS Error: {result['message']}")
        
        # Decode audio data
        audio_data = base64.b64decode(result['data']['audio'])
        return audio_data
```

### 7.5 阿里云 OSS Upload

```python
# backend/services/oss_storage.py
import oss2
from typing import Optional

class AliyunOSSService:
    """
    阿里云对象存储服务
    Aliyun Object Storage Service
    """
    def __init__(
        self,
        access_key_id: str,
        access_key_secret: str,
        endpoint: str = "oss-cn-beijing.aliyuncs.com",
        bucket_name: str = "culturalbility-audio"
    ):
        self.auth = oss2.Auth(access_key_id, access_key_secret)
        self.bucket = oss2.Bucket(self.auth, endpoint, bucket_name)
        self.cdn_domain = "https://audio.culturalbility.cn"  # 阿里云 CDN
    
    async def upload_audio(
        self,
        file_data: bytes,
        user_id: str,
        session_id: str
    ) -> str:
        """Upload audio to OSS with CDN URL"""
        
        # Generate unique filename
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        object_key = f"audio/{user_id}/{session_id}/{timestamp}.m4a"
        
        # Upload to OSS
        self.bucket.put_object(object_key, file_data)
        
        # Return CDN URL (for faster China access)
        return f"{self.cdn_domain}/{object_key}"
    
    def generate_presigned_url(
        self,
        object_key: str,
        expiration: int = 3600
    ) -> str:
        """Generate presigned URL for iOS upload"""
        return self.bucket.sign_url('PUT', object_key, expiration)
```

---

## 8. Monitoring & Cost Controls

### 8.1 Cost Alerting Thresholds

| Metric | Warning | Critical | Action |
|--------|---------|----------|--------|
| Daily AI spend | ¥350 | ¥700 | Switch to batch processing |
| Per-user daily cost | ¥3.5 | ¥7 | Rate limit user |
| Cache hit rate | <50% | <30% | Review caching strategy |
| API error rate | >5% | >10% | Failover to backup provider |

### 8.2 阿里云 CloudMonitor Integration

```python
# backend/monitoring/cloudmonitor.py
from aliyunsdkcore.client import AcsClient
from aliyunsdkcms.request.v20190101 import PutCustomMetricRequest

class ChinaCloudMonitor:
    """
    阿里云云监控集成
    Aliyun CloudMonitor Integration
    """
    def __init__(self, access_key, secret_key, region="cn-beijing"):
        self.client = AcsClient(access_key, secret_key, region)
    
    async def report_ai_cost(
        self,
        provider: str,  # iFlytek, DeepSeek, Kimi
        cost_rmb: float,
        tokens: int
    ):
        """Report AI API costs to CloudMonitor"""
        request = PutCustomMetricRequest()
        request.set_MetricList([{
            "groupId": 12345,
            "metricName": "AI_Cost",
            "dimensions": {
                "provider": provider,
                "service": "AI_API"
            },
            "time": int(time.time() * 1000),
            "type": 0,
            "values": {
                "value": cost_rmb,
                "token_count": tokens
            }
        }])
        
        response = self.client.do_action_with_exception(request)
        return response
```

### 8.3 Rate Limiting Strategy

```python
# backend/middleware/rate_limit.py
import redis
from functools import wraps

class ChinaRateLimiter:
    """Rate limiter using 阿里云 Redis"""
    def __init__(self, redis_client: redis.Redis):
        self.redis = redis_client
    
    def limit_ai_calls(self, user_tier: str = "free"):
        """Rate limit based on user tier (RMB-based)"""
        limits = {
            'free': {'requests_per_hour': 10, 'ai_cost_daily': 1.0},      # ¥1/day
            'basic': {'requests_per_hour': 50, 'ai_cost_daily': 10.0},    # ¥10/day
            'pro': {'requests_per_hour': 200, 'ai_cost_daily': 50.0},     # ¥50/day
            'enterprise': {'requests_per_hour': 1000, 'ai_cost_daily': 500.0}
        }
        return limits.get(user_tier, limits['free'])
```

---

## 9. Risk Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| iFlytek API rate limits | High | Implement Alibaba Cloud Speech fallback |
| DeepSeek service disruption | High | Failover to Kimi or Qwen |
| Regulatory changes | Medium | Monitor 网信办 announcements, maintain compliance checklist |
| Cost overruns | High | Hard limits + 阿里云 CloudMonitor alerting + tiered access |
| Accent quality complaints | Medium | A/B test iFlytek vs Azure 21Vianet |
| Data privacy (enterprise) | High | Offer 阿里云-only stack option, sign DPA |
| ICP License delays | High | Apply early, work with 阿里云代理 |
| 算法备案 rejection | Medium | Prepare detailed algorithm documentation |

---

## 10. Key Decisions Summary (China Edition)

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Primary STT | iFlytek (科大讯飞) | Best accuracy, domestic leader, China-compliant |
| STT Fallback | Alibaba Cloud Speech | Cost-effective, same ecosystem |
| Primary TTS | iFlytek TTS | Best quality, domestic leader |
| TTS Backup | Azure Neural (21Vianet) | International accent quality |
| Primary LLM | DeepSeek V3 | Best value, Chinese company, excellent quality |
| Complex Analysis | Kimi (月之暗面) | Long context, nuanced feedback |
| LLM Backup | Qwen (通义千问) | Alibaba ecosystem, reliable |
| Pronunciation | iFlytek Speech Evaluation | Domestic gold standard |
| Cloud Platform | 阿里云 | Full stack, ICP support, China compliance |
| Storage | 阿里云 OSS | Domestic, CDN integration |
| Cache | 阿里云 Redis | 40-60% cost reduction potential |
| Database | 阿里云 RDS PostgreSQL | Managed, encrypted, compliant |

---

## 11. Provider Contact Information

| Provider | Website | Support | Documentation |
|----------|---------|---------|---------------|
| iFlytek 科大讯飞 | www.xfyun.cn | 400-019-9999 | www.xfyun.cn/doc |
| DeepSeek 深度求索 | www.deepseek.com | Online ticket | platform.deepseek.com |
| Moonshot AI 月之暗面 | www.moonshot.cn | platform@moonshot.cn | platform.moonshot.cn |
| 阿里云 | www.aliyun.com | 95187 | help.aliyun.com |
| 百度智能云 | cloud.baidu.com | 4008-777-818 | cloud.baidu.com/doc |

---

## 12. Next Steps

1. **Week 1:** Set up 阿里云 infrastructure (ECS/RDS/Redis/OSS), apply for ICP Filing
2. **Week 2:** Apply for iFlytek developer account, get API credentials
3. **Week 3:** Integrate iFlytek STT, iFlytek TTS
4. **Week 4:** Apply for DeepSeek API access, build feedback pipeline
5. **Week 5:** iOS audio recording + 阿里云 OSS upload integration
6. **Week 6:** Scoring algorithm + progress tracking
7. **Week 7:** iFlytek Speech Evaluation integration
8. **Week 8:** Testing + cost optimization + 算法备案 preparation

---

*Document generated for Culturalbility AI Architecture - China Edition. All pricing as of March 2025 in RMB. Verify current rates and compliance requirements before implementation.*

**Compliance Review Required:** Legal team to review ICP License, 算法备案, and 等保测评 requirements before launch.
