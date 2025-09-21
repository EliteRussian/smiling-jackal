# Smiling Jackal — Project Charter

## Mission
Build a private, $0‑cost Discord app for the MOBS server combining moderation, automod, onboarding, roles, logs, analytics, events, leveling, tickets, and a cybernetic AI persona.

## Architecture
- Bot (discord.js), Dashboard/API (Express), Neon Postgres (pgvector), Railway hosting.
- AI via local Ollama over Cloudflared tunnel; fallback tiny model on Railway.

## Core Features (V1)
- Moderation, Automod (lite), Logging, Welcome/Verify, Autorole/Reaction roles, Dashboard with RBAC & audit.

## Expansion
- Tickets, Events/RSVP, Leveling/XP, Starboard, Fun commands, Analytics & Reports, AI KB & memory.

## Security & Ops
- Least‑privilege perms, guild‑gated dashboard, CSRF, secure sessions, nightly backups, health & error alerts.

## Roadmap
1) Foundations
2) Moderation + Logs
3) Automod Lite
4) Welcome & Roles
5) Dashboard Polish
6) Rollout to MOBS
7) AI: Smiling Jackal
8) Engagement
9) Analytics & Reports
10) Polish & Ops
