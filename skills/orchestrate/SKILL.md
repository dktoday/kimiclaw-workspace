---
description: Coordinate multiple agents for complex tasks. Use for multi-perspective analysis, comprehensive reviews, or tasks requiring different domain expertise.
---

# Multi-Agent Orchestration

You are now in **ORCHESTRATION MODE**. Your task: coordinate specialized agents to solve this complex problem.

## Task to Orchestrate
$ARGUMENTS

---

## 🔴 CRITICAL: Minimum Agent Requirement

> ⚠️ **ORCHESTRATION = MINIMUM 3 DIFFERENT AGENTS**
> 
> If you use fewer than 3 agents, you are NOT orchestrating - you're just delegating.
> 
> **Validation before completion:**
> - Count invoked agents
> - If `agent_count < 3` → STOP and invoke more agents
> - Single agent = FAILURE of orchestration

### Agent Selection Matrix

| Task Type | REQUIRED Agents (minimum) |
|-----------|---------------------------|
| **Web App** | frontend-specialist, backend-specialist, test-engineer |
| **API** | backend-specialist, security-auditor, test-engineer |
| **UI/Design** | frontend-specialist, seo-specialist, performance-optimizer |
| **Database** | database-architect, backend-specialist, security-auditor |
| **Full Stack** | project-planner, frontend-specialist, backend-specialist, devops-engineer |
| **Debug** | debugger, explorer-agent, test-engineer |
| **Security** | security-auditor, penetration-tester, devops-engineer |
| **Strategy** | ceo, pm, devil (business decisions) |
| **Design System** | designer, dev, marketing (UX + feasibility + market fit) |

---

## Pre-Flight: Mode Check

| Current Mode | Task Type | Action |
|--------------|-----------|--------|
| **plan** | Any | ✅ Proceed with planning-first approach |
| **edit** | Simple execution | ✅ Proceed directly |
| **edit** | Complex/multi-file | ⚠️ Ask: "This task requires planning. Switch to plan mode?" |
| **ask** | Any | ⚠️ Ask: "Ready to orchestrate. Switch to edit or plan mode?" |

---

## 🔴 STRICT 2-PHASE ORCHESTRATION

### PHASE 1: PLANNING (Sequential - NO parallel agents)

| Step | Agent | Action |
|------|-------|--------|
| 1 | `project-planner` or `pm` | Create docs/PLAN.md |
| 2 | (optional) `explorer-agent` | Codebase discovery if needed |
| 3 | `ceo` | Strategic validation |

> 🔴 **NO OTHER AGENTS during planning!** Only planner, explorer, and CEO.

### ⏸️ CHECKPOINT: User Approval

After PLAN.md is complete, ASK:

```
"✅ Plan created: docs/PLAN.md

Do you approve? (Y/N)
- Y: Implementation begins
- N: I'll revise the plan"
```

> 🔴 **DO NOT proceed to Phase 2 without explicit user approval!**

### PHASE 2: IMPLEMENTATION (Parallel agents after approval)

| Parallel Group | Agents |
|----------------|--------|
| Foundation | `database-architect`, `security-auditor` |
| Core | `backend-specialist`, `frontend-specialist` |
| Polish | `test-engineer`, `devops-engineer` |
| Business | `marketing`, `designer`, `dev` |

> ✅ After user approval, invoke multiple agents in PARALLEL.

---

## Our Agent Team (7 agents)

| Agent | Domain | Use When |
|-------|--------|----------|
| `ceo` | Strategy | Decisions, vision, prioritization |
| `pm` | Planning | Roadmaps, task breakdown |
| `designer` | UI/UX | Wireframes, design system |
| `dev` | Engineering | Code, architecture |
| `it` | Infrastructure | Tech specs, costs, security |
| `marketing` | Growth | Go-to-market, user acquisition |
| `devil` | Critical analysis | Risk assessment, validation |

---

## Orchestration Protocol

### Step 1: Analyze Task Domains
Identify ALL domains this task touches:
```
□ Strategy     → ceo
□ Planning     → pm
□ Design       → designer
□ Engineering  → dev, it
□ Marketing    → marketing
□ Validation   → devil
```

### Step 2: Phase Detection

| If Plan Exists | Action |
|----------------|--------|
| NO plan document | → Go to PHASE 1 (planning only) |
| YES plan + user approved | → Go to PHASE 2 (implementation) |

### Step 3: Execute Based on Phase

**PHASE 1 (Planning):**
```
Use the pm agent to create roadmap
Use the ceo agent to validate strategy
Use the devil agent to find risks
→ STOP after plan is created
→ ASK user for approval
```

**PHASE 2 (Implementation - after approval):**
```
Invoke agents in PARALLEL:
Use the designer agent to [task]
Use the dev agent to [task]
Use the marketing agent to [task]
```

**🔴 CRITICAL: Context Passing (MANDATORY)**

When invoking ANY subagent, you MUST include:

1. **Original User Request:** Full text of what user asked
2. **Decisions Made:** All user answers to questions
3. **Previous Agent Work:** Summary of what previous agents did
4. **Current Plan State:** If plan files exist, include them

---

## Output Format

```markdown
## 🎼 Orchestration Report

### Task
[Original task summary]

### Agents Invoked (MINIMUM 3)
| # | Agent | Focus Area | Status |
|---|-------|------------|--------|
| 1 | pm | Task breakdown | ✅ |
| 2 | designer | UI implementation | ✅ |
| 3 | devil | Risk validation | ✅ |

### Key Findings
1. **[Agent 1]**: Finding
2. **[Agent 2]**: Finding
3. **[Agent 3]**: Finding

### Deliverables
- [ ] PLAN.md created
- [ ] Code implemented
- [ ] Risks validated

### Summary
[One paragraph synthesis of all agent work]
```

---

## 🔴 EXIT GATE

Before completing orchestration, verify:

1. ✅ **Agent Count:** `invoked_agents >= 3`
2. ✅ **Report Generated:** Orchestration Report with all agents listed

> **If any check fails → DO NOT mark orchestration complete.**

---

**Begin orchestration now. Select 3+ agents, execute, synthesize results.**
