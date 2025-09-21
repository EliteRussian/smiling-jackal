-- CreateTable
CREATE TABLE "public"."Guild" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."GuildConfig" (
    "guildId" TEXT NOT NULL,
    "logChannelId" TEXT,
    "welcomeChannelId" TEXT,
    "verifyRoleId" TEXT,
    "memberRoleId" TEXT,
    "staffRoleIds" TEXT,
    "automodJson" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GuildConfig_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "public"."Infraction" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "modId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "reason" TEXT,
    "expiresAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Infraction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."LogEntry" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "data" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LogEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ReactionRole" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "messageId" TEXT NOT NULL,
    "emoji" TEXT NOT NULL,
    "roleId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ReactionRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."KbEntry" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "embedding" BYTEA,
    "status" TEXT NOT NULL DEFAULT 'approved',
    "createdBy" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "KbEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserMemory" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserMemory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."MessageStat" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "ts" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MessageStat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AiMetric" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "latencyMs" INTEGER NOT NULL,
    "usedFallback" BOOLEAN NOT NULL DEFAULT false,
    "ts" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AiMetric_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Event" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "startsAt" TIMESTAMP(3) NOT NULL,
    "endsAt" TIMESTAMP(3),
    "channelId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."EventRsvp" (
    "id" TEXT NOT NULL,
    "eventId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "EventRsvp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DailyGuildStat" (
    "date" TIMESTAMP(3) NOT NULL,
    "guildId" TEXT NOT NULL,
    "dau" INTEGER NOT NULL,
    "messages" INTEGER NOT NULL,
    "joins" INTEGER NOT NULL,
    "leaves" INTEGER NOT NULL,

    CONSTRAINT "DailyGuildStat_pkey" PRIMARY KEY ("date","guildId")
);

-- CreateTable
CREATE TABLE "public"."ModerationKpi" (
    "date" TIMESTAMP(3) NOT NULL,
    "guildId" TEXT NOT NULL,
    "incidents" INTEGER NOT NULL,
    "automodIncidents" INTEGER NOT NULL,
    "medianResponseSec" INTEGER NOT NULL,

    CONSTRAINT "ModerationKpi_pkey" PRIMARY KEY ("date","guildId")
);

-- CreateTable
CREATE TABLE "public"."VerifyStat" (
    "date" TIMESTAMP(3) NOT NULL,
    "guildId" TEXT NOT NULL,
    "newJoins" INTEGER NOT NULL,
    "verified" INTEGER NOT NULL,
    "medianVerifyMinutes" INTEGER NOT NULL,

    CONSTRAINT "VerifyStat_pkey" PRIMARY KEY ("date","guildId")
);

-- CreateIndex
CREATE INDEX "Infraction_guildId_userId_idx" ON "public"."Infraction"("guildId", "userId");

-- CreateIndex
CREATE INDEX "LogEntry_guildId_createdAt_idx" ON "public"."LogEntry"("guildId", "createdAt");

-- CreateIndex
CREATE INDEX "ReactionRole_guildId_messageId_idx" ON "public"."ReactionRole"("guildId", "messageId");

-- CreateIndex
CREATE INDEX "KbEntry_guildId_status_idx" ON "public"."KbEntry"("guildId", "status");

-- CreateIndex
CREATE INDEX "UserMemory_guildId_userId_idx" ON "public"."UserMemory"("guildId", "userId");

-- CreateIndex
CREATE INDEX "MessageStat_guildId_ts_idx" ON "public"."MessageStat"("guildId", "ts");

-- CreateIndex
CREATE INDEX "MessageStat_channelId_ts_idx" ON "public"."MessageStat"("channelId", "ts");

-- CreateIndex
CREATE INDEX "MessageStat_userId_ts_idx" ON "public"."MessageStat"("userId", "ts");

-- CreateIndex
CREATE INDEX "AiMetric_guildId_ts_idx" ON "public"."AiMetric"("guildId", "ts");

-- AddForeignKey
ALTER TABLE "public"."GuildConfig" ADD CONSTRAINT "GuildConfig_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "public"."Guild"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Infraction" ADD CONSTRAINT "Infraction_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "public"."Guild"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."LogEntry" ADD CONSTRAINT "LogEntry_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "public"."Guild"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
