# App Team - Multi-Agent Development Setup

## Your Team

| Agent | Role | Best For |
|-------|------|----------|
| **CEO** | Strategy & Decisions | Product vision, tech stack choices, feature prioritization |
| **PM** | Project Management | Task breakdown, scheduling, progress tracking |
| **Designer** | UI/UX Design | User flows, wireframes, design systems |
| **Dev** | Engineering | Architecture, coding, testing, deployment |
| **Kimi Claw** (me) | Coordinator | Orchestrating the team, context switching, final integration |

## How to Use

### Option 1: Direct Agent Switching (Recommended)
Tell me which agent you want to talk to:

```
"Switch to CEO mode - should we build mobile-first or web-first?"
"PM - create a 6-week roadmap for MVP"
"Designer - design the onboarding flow"
"Dev - set up a Next.js project with TypeScript"
```

I'll adopt that agent's persona immediately.

### Option 2: Spawn Isolated Sessions
For complex tasks that need focused work:

```bash
# Check available agents
openclaw agents list

# Spawn an agent for a specific task
openclaw sessions spawn --agent ceo --task "Create product strategy for a fitness app"
```

### Option 3: Team Meeting Mode
I can simulate a team meeting where multiple agents "discuss":

```
"Let's have a team meeting about the login feature"
```

I'll play all roles and give you a structured discussion output.

## Workflow Example

### Phase 1: Strategy (CEO)
```
You: "CEO - I want to build a personal finance app for young professionals. 
      What's our strategy?"
CEO: [Strategic decisions on platform, features, timeline]
```

### Phase 2: Planning (PM)
```
You: "PM - based on CEO's decisions, create a project plan"
PM: [Task breakdown, milestones, resource allocation]
```

### Phase 3: Design (Designer)
```
You: "Designer - design the core screens"
Designer: [Wireframes, user flows, design specs]
```

### Phase 4: Build (Dev)
```
You: "Dev - implement the authentication system"
Dev: [Code, tests, deployment config]
```

### Phase 5: Review (All)
```
You: "Let's review - is this ready for launch?"
[Multi-agent review with go/no-go decision]
```

## Project Files Organization

```
~/workspace/
├── projects/
│   └── your-app/
│       ├── docs/
│       │   ├── prd.md           # Product Requirements
│       │   ├── design.md        # Design specs
│       │   └── architecture.md  # Technical docs
│       ├── design/
│       │   └── mockups/         # Design assets
│       ├── src/
│       │   ├── frontend/
│       │   └── backend/
│       └── README.md
├── agents/                      # Agent configs
│   ├── ceo.yaml
│   ├── pm.yaml
│   ├── designer.yaml
│   └── dev.yaml
└── app-team.sh                  # Helper script
```

## Quick Start Commands

```bash
# Create new project
mkdir -p ~/workspace/projects/my-app
cd ~/workspace/projects/my-app

# Initialize with README
echo "# My App" > README.md

# Check agent status
openclaw agents list

# View agent configs
cat ~/.openclaw/agents/ceo.yaml
```

## Tips

1. **Start with CEO** - Always begin with strategic clarity
2. **One agent at a time** - Don't mix roles in a single conversation
3. **Document decisions** - I'll save key decisions to `docs/decisions.md`
4. **Iterate fast** - Use me (Kimi Claw) for quick questions between agent sessions
5. **Review checkpoints** - Pause at milestones for multi-agent review

## Need Help?

Just ask me anything:
- "How do I switch agents?"
- "What's the best workflow for my situation?"
- "CEO, review this design decision"
- "Dev, help me debug this error"

I'm your coordinator - I know what all agents are doing and can context-switch instantly.
