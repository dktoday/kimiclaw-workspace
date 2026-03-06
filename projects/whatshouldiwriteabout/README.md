# What Should I Write About?

> AI-powered content strategy platform for busy founders and marketers

## The Concept

Users enter their website URL. Five AI agents work in parallel to:

1. **🔍 Content Analyzer** — Reads their site to understand business, audience, and goals
2. **🎯 Competitor Researcher** — Finds competitors in their niche/locality  
3. **🔑 Keyword Researcher** — Discovers content opportunities and search volume
4. **✍️ Content Writer** — Drafts titles, outlines, and post structures
5. **📈 SEO Expert** — Optimizes content based on keyword research

**Result:** A complete 30-day content calendar with optimized post ideas.

---

## Tech Stack (TBD)

| Layer | Options |
|-------|---------|
| Frontend | Next.js / React / Vue |
| Backend | Node.js / Python |
| AI | DeepSeek / Kimi / iFlytek (China-compatible) |
| Database | PostgreSQL |
| Hosting | Vercel / Aliyun |

---

## Agent Workflow

```
User Input: URL
     ↓
┌─────────────────┐
│ Content Analyzer │ → Reads site, extracts: business type, audience, tone
└────────┬────────┘
         ↓
┌────────────────────┐
│ Competitor Research │ → Finds 5-10 competitors, analyzes their content
└────────┬───────────┘
         ↓
┌──────────────────┐
│ Keyword Research │ → Identifies 50+ keywords, search volume, difficulty
└────────┬─────────┘
         ↓
┌───────────────┐
│ Content Writer │ → Creates 30 titles + outlines + target keywords
└────────┬──────┘
         ↓
┌────────────┐
│ SEO Expert │ → Edits for SEO: meta descriptions, internal linking, headers
└────────────┘
         ↓
   Output: Content Calendar (CSV/JSON)
```

---

## Project Structure

```
whatshouldiwriteabout/
├── web/                    # Frontend (this HTML demo)
├── docs/                   # Documentation
├── agents/                 # Agent logic/prompts
└── README.md              # This file
```

---

## Status

**Phase:** Concept / Design  
**Next:** Technical architecture planning

---

## Domain

whatsheiwriteabout.com (registered?)
