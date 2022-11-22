import express, { Router } from "express";
import { addTimetable, getTimeTable, updateTimetable } from "./timetable.controller";

export const TimetableRouter: Router = express.Router();

TimetableRouter.post("/gettimetable", getTimeTable);

TimetableRouter.post("/addTimetable", addTimetable);

TimetableRouter.post("/updateTimetable", updateTimetable);
