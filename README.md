# Smiling Jackal — MOBS All‑in‑One Discord App

> Private, $0‑cost Discord bot + dashboard with moderation, automod, onboarding, roles, logs, analytics, and a cybernetic AI persona.

## Monorepo
```
apps/
  bot/   # Discord bot (discord.js, TypeScript)
  web/   # Dashboard + API + AI gateway (Express)
prisma/  # Prisma schema & migrations
```

## Quick start

1) **Install deps**
```
npm i
```

2) **Set ENV** — copy `.env.example` to `.env` (or set in Railway Variables).

3) **Generate Prisma client**
```
npm run prisma:generate
```

4) **Build**
```
npm run build
```

5) **Run locally (dev)**
```
npm run dev
```

## Deploy (Railway)

- Connect this repo to Railway.
- Railway reads `railway.toml` and creates **bot** + **web** services.
- Set variables in both services (see `.env.example`).
- Run `npm run prisma:migrate` once on deploy (or use Railway deploy command).

## Slash commands
From Railway shell in the **bot** service:
```
npm run register -w apps/bot
```

## Database
- Neon Postgres (free). Enable `pgvector` if you plan to use AI RAG:
```
CREATE EXTENSION IF NOT EXISTS vector;
```

## AI (Ollama)
Run locally:
```
ollama run llama3.1:8b
cloudflared tunnel --url http://localhost:11434
```
Set `JACKAL_OLLAMA_URL` to the printed HTTPS URL.

## License
Private, all rights reserved by the MOBS owner.
