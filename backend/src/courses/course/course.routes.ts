import express, { Router } from "express";
import { addCourse } from "./course.controller";

export const CourseRouter: Router = express.Router();


// api/course/addcourse
CourseRouter.post("/addCourse", addCourse);
