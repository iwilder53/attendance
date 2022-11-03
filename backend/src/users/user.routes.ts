import express, { Router } from "express";
import { login, register, attend, getAttendanceByUser, getAttendanceBySubject } from "./user.controller";

export const UserRouter: Router = express.Router();


// api/user/login
UserRouter.post("/login", login);


// api/user/register
UserRouter.post("/register", register);

// api/user/markAttendance
UserRouter.post("/attend", attend);


// api/user/getAttendance
UserRouter.post("/getattendancebyuser", getAttendanceByUser);


// api/user/getAttendanceBySubject
UserRouter.post("/getattendancebysubject", getAttendanceBySubject);