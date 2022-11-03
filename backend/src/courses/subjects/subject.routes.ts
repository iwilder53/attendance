import express, { Router } from "express";
import { addSubject } from "./subject.controller";

export const CourseRouter: Router = express.Router();


// api/course/addsubject
CourseRouter.post("/addSubject", addSubject);
