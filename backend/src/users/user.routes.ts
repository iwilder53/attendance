import express, { Router } from "express";
import { verifyJwtToken } from "../auth.middleware";
import { login, register, attend, getAttendanceByUser, getAttendanceBySubject, generateAttendance } from "./user.controller";

export const UserRouter: Router = express.Router();


// api/user/login
UserRouter.post("/login", login);


// api/user/register
UserRouter.post("/register", register);

// api/user/markAttendance
UserRouter.post("/attend", attend);

// api/user/generateAttendance
UserRouter.post("/generateAttendance", generateAttendance);

// api/user/getAttendance
UserRouter.post("/getattendancebyuser", getAttendanceByUser);


// api/user/getAttendanceBySubject
UserRouter.post("/getattendancebysubject", getAttendanceBySubject);