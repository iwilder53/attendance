import express, { Router } from "express";
import { addCourse, deleteCourse, getCourses } from "./course.controller";

export const CourseRouter: Router = express.Router();


// api/course/addcourse
CourseRouter.post("/addcourse", addCourse);

// api/course/getcourses
CourseRouter.get("/getCourses", getCourses);

// api/course/deleteCourse
CourseRouter.delete("/deletecourse/:id", deleteCourse);