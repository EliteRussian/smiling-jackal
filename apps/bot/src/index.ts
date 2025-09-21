import "dotenv/config";
import { Client, GatewayIntentBits, Partials, Events, REST, Routes, SlashCommandBuilder } from "discord.js";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMembers,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
    GatewayIntentBits.GuildMessageReactions,
  ],
  partials: [Partials.Message, Partials.Channel, Partials.Reaction],
});

client.once(Events.ClientReady, async (c) => {
  console.log(`✅ Logged in as ${c.user.tag}`);
});

client.on(Events.MessageCreate, async (msg) => {
  // Basic metric capture (lightweight)
  if (!msg.guild || msg.author.bot) return;
  try {
    await prisma.messageStat.create({
      data: {
        guildId: msg.guild.id,
        channelId: msg.channel.id,
        userId: msg.author.id,
      },
    });
  } catch (e) {
    // keep silent in prod; optionally batch
  }

  // Mention-based simple reply (placeholder)
  const mentioned = msg.mentions.users.has(client.user!.id);
  if (mentioned) {
    await msg.reply("Signal received. Smiling Jackal is online and monitoring the uplink.");
  }
});

client.login(process.env.DISCORD_TOKEN);
