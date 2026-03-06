# Agent Architecture

## The Five Agents

### 1. Content Analyzer
**Role:** Website intelligence gathering

**Input:** Website URL  
**Output:** Business profile JSON

**Tasks:**
- Crawl homepage, about, product, blog pages
- Extract: business type, target audience, value proposition, tone/voice
- Identify content gaps (what's missing from their current site)

**Tools needed:**
- Web crawler (Scrapy / Puppeteer)
- LLM for content analysis

---

### 2. Competitor Researcher
**Role:** Market intelligence

**Input:** Business profile from Analyzer  
**Output:** Competitor list with content analysis

**Tasks:**
- Search for businesses in same niche/locality
- Analyze top 5-10 competitors' content strategies
- Identify what's working for them (top performing content)

**Tools needed:**
- Search API (Google Custom Search / SerpAPI)
- Web crawler
- Content analysis LLM

---

### 3. Keyword Researcher
**Role:** SEO opportunity finder

**Input:** Business profile + competitor data  
**Output:** Keyword list with metrics

**Tasks:**
- Generate seed keywords from business description
- Find long-tail variations
- Get search volume, difficulty, CPC data
- Categorize by intent (informational, transactional, etc.)

**Tools needed:**
- Keyword API (Ahrefs / SEMrush / Ubersuggest)
- LLM for keyword clustering

---

### 4. Content Writer
**Role:** Content creator

**Input:** Keywords + business context  
**Output:** 30 content ideas with outlines

**Tasks:**
- Match keywords to content types (pillar, listicle, how-to, etc.)
- Write compelling titles
- Create article outlines (H2s, H3s)
- Assign target keywords to each piece

**Tools needed:**
- LLM (DeepSeek / Kimi)
- Content templates

---

### 5. SEO Expert
**Role:** Content optimizer

**Input:** Raw content outlines  
**Output:** Optimized content calendar

**Tasks:**
- Write meta descriptions
- Suggest internal linking opportunities
- Optimize headers for keywords
- Check keyword density
- Prioritize content by opportunity score

**Tools needed:**
- LLM with SEO training
- SEO scoring algorithm

---

## Orchestration

Options:
1. **Sequential** — Each agent waits for previous (slower, cheaper)
2. **Parallel** — All agents work simultaneously (faster, may duplicate work)
3. **Hybrid** — Analyzer → (Competitor + Keyword parallel) → Writer → SEO

**Recommended:** Hybrid for balance of speed and quality.
