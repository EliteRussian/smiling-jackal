import "dotenv/config";
import express, { Request, Response } from "express";
import session from "express-session";
import passport from "passport";
import { Strategy as DiscordStrategy } from "passport-discord";
import cors from "cors";

const app = express();
app.disable("x-powered-by");

app.use(
  cors({
    origin: process.env.BASE_URL || true,
    credentials: true,
  })
);

app.use(express.json());

passport.use(
  new DiscordStrategy(
    {
      clientID: process.env.DISCORD_CLIENT_ID!,
      clientSecret: process.env.DISCORD_CLIENT_SECRET!,
      callbackURL: process.env.OAUTH_CALLBACK_URL!,
      scope: ["identify", "guilds"],
    },
    (
      accessToken: string,
      refreshToken: string,
      profile: any,
      done: (err: any, user?: any) => void
    ) => done(null, { profile, accessToken })
  )
);

passport.serializeUser((user: any, done: (err: any, id?: any) => void) =>
  done(null, user)
);
passport.deserializeUser((obj: any, done: (err: any, user?: any) => void) =>
  done(null, obj)
);

app.use(
  session({
    secret: process.env.SESSION_SECRET || "change-me",
    resave: false,
    saveUninitialized: false,
    cookie: { sameSite: "lax", secure: false }, // set secure: true when behind HTTPS proxy
  })
);

app.use(passport.initialize());
app.use(passport.session());

app.get("/health", (_: Request, res: Response) => res.json({ ok: true }));

app.get("/auth", passport.authenticate("discord"));
app.get(
  "/auth/callback",
  passport.authenticate("discord", { failureRedirect: "/login" }),
  (req: Request, res: Response) => res.redirect("/dashboard")
);

function requireAuth(
  req: Request & { user?: any },
  res: Response,
  next: () => void
) {
  // Not logged in → redirect to Discord OAuth
  // ts-expect-error isAuthenticated added by passport
  if (!req.isAuthenticated || !req.isAuthenticated())
    return res.redirect("/auth");
  const guilds = req.user?.profile?.guilds || [];
  const allowed = guilds.some((g: any) => g.id === process.env.MOBS_GUILD_ID);
  if (!allowed) return res.status(403).send("Not authorized for this guild.");
  next();
}

app.get("/dashboard", requireAuth, (_req: Request, res: Response) => {
  res.send("MOBS Dashboard — online. More UI coming soon.");
});

const port = Number(process.env.PORT) || 8080;
app.listen(port, () => console.log(`✅ Web listening on :${port}`));
