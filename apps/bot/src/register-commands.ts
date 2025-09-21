import "dotenv/config";
import { REST, Routes, SlashCommandBuilder } from "discord.js";

const commands = [
  new SlashCommandBuilder().setName("ping").setDescription("Respond with Pong!"),
  new SlashCommandBuilder().setName("hello").setDescription("Say hello."),
].map(c => c.toJSON());

const rest = new REST({ version: "10" }).setToken(process.env.DISCORD_TOKEN!);

async function main() {
  const appId = process.env.DISCORD_CLIENT_ID!;
  if (!appId) throw new Error("Missing DISCORD_CLIENT_ID");
  await rest.put(Routes.applicationCommands(appId), { body: commands });
  console.log("✅ Global commands registered");
}
main().catch(console.error);
