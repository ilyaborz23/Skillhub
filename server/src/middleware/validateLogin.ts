import type { NextFunction, Request, Response } from "express";
import { EMAIL_PATTERN, MAX_EMAIL_LENGTH, MAX_PASSWORD_BYTES, asTrimmed } from "./validateRegister";

export const validateLogin = (req: Request, res: Response, next: NextFunction) => {
  const body = req.body ?? {};
  // Same normalization as on register, so "Name@Mail.com" finds "name@mail.com"
  const email = asTrimmed(body.email).toLowerCase();
  const password = typeof body.password === "string" ? body.password : "";

  if (!email || !password) {
    res.status(400).json({ error: "Email and password are required" });
    return;
  }
  // Malformed input can never match a stored account
  if (
    email.length > MAX_EMAIL_LENGTH ||
    !EMAIL_PATTERN.test(email) ||
    Buffer.byteLength(password) > MAX_PASSWORD_BYTES
  ) {
    res.status(401).json({ error: "Incorrect email or password" });
    return;
  }

  req.body = { email, password };
  next();
};
