import express, { Router } from "express";
import { addTimetable, getAttendance, updateTimetable } from "./timetable.controller";

export const analyticsRouter: Router = express.Router();


analyticsRouter.get("/getattendance", getAttendance);

analyticsRouter.get("/analyticsByCourse", addTimetable);

analyticsRouter.get("/getTopStudentsWeekly", updateTimetable);
