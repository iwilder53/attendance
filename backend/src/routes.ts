import express, { Router } from "express";
import { CourseRouter } from "./courses/course/course.routes";
import { TimetableRouter } from "./courses/timetable/timetable.routes";
import { UserRouter } from "./users/user.routes";
const app = express();


// api/user
app.use("/user", UserRouter);
//api/course
app.use("/course", CourseRouter);
// api/timetable
app.use("/timetable", TimetableRouter);

module.exports = app;