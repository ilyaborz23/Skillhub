import express from "express";
import { login, register } from "../controllers/authController";
import { validateRegister } from "../middleware/validateRegister";
import { validateLogin } from "../middleware/validateLogin";

const router = express.Router();

router.post("/register", validateRegister, register);
router.post("/login", validateLogin, login);

export default router;
