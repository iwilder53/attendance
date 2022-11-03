"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserRouter = void 0;
const express_1 = __importDefault(require("express"));
const user_controller_1 = require("./user.controller");
exports.UserRouter = express_1.default.Router();
// api/user/login
exports.UserRouter.post("/login", user_controller_1.login);
// api/user/register
exports.UserRouter.post("/register", user_controller_1.register);
// api/user/markAttendance
exports.UserRouter.post("/attend", user_controller_1.attend);
