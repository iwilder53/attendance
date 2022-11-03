import express, { Router } from "express";
import { CourseRouter } from "./courses/course/course.routes";
import { UserRouter } from "./users/user.routes";
const app = express();


// api/user
app.use("/user", UserRouter);
//api/course
app.use("/course", CourseRouter);

module.exports = app;