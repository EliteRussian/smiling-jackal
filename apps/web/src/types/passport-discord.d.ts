declare module "passport-discord" {
  // minimal shim so TS stops complaining; we don't need full typings here
  import { Strategy as OAuth2Strategy, StrategyOptions } from "passport-oauth2";
  export const Strategy: new (
    options: StrategyOptions,
    verify: (...args: any[]) => void
  ) => OAuth2Strategy;
}
