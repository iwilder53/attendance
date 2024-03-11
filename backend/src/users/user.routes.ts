import express, { Router } from "express";
import { verifyJwtToken } from "../auth.middleware";
import { login, getStudents, register, attend, getAttendanceByUser, getAttendanceBySubject, generateAttendance, getStudent, addStudent } from "./user.controller";

export const UserRouter: Router = express.Router();


// api/user/login
UserRouter.post("/login", login);

// api/user/login
UserRouter.post("/addstudent", addStudent);

// api/user/getstudents
UserRouter.get("/getstudents", getStudents);

//get student
// api/user/getstudent
UserRouter.get("/getstudent/:id", getStudent);


// api/user/register
UserRouter.post("/register", register);

// api/user/markAttendance
UserRouter.post("/attend", verifyJwtToken, attend);

// api/user/generateAttendance
UserRouter.post("/generateAttendance", generateAttendance);

// api/user/getAttendance
UserRouter.post("/getattendancebyuser", verifyJwtToken, getAttendanceByUser);


// api/user/getAttendanceBySubject
UserRouter.post("/getattendancebysubject", verifyJwtToken, getAttendanceBySubject);