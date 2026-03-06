#!/bin/bash
# App Team Orchestration Script
# Usage: ./app-team.sh <agent> <task>

AGENT=$1
TASK="${@:2}"

if [ -z "$AGENT" ] || [ -z "$TASK" ]; then
    echo "Usage: ./app-team.sh <ceo|pm|designer|dev> <task description>"
    echo ""
    echo "Examples:"
    echo "  ./app-team.sh ceo 'Should we build a mobile app or web app first?'"
    echo "  ./app-team.sh pm 'Create a roadmap for MVP launch in 6 weeks'"
    echo "  ./app-team.sh designer 'Design the onboarding flow'"
    echo "  ./app-team.sh dev 'Set up the project structure with Next.js'"
    exit 1
fi

echo "🚀 Spawning $AGENT agent for task..."
echo "Task: $TASK"
echo ""

# This will be handled by OpenClaw's sessions_spawn
openclaw sessions spawn --agent $AGENT --task "$TASK"
