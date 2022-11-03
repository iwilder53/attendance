"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CourseRouter = void 0;
const express_1 = __importDefault(require("express"));
const course_controller_1 = require("./course.controller");
exports.CourseRouter = express_1.default.Router();
// api/course/addcourse
exports.CourseRouter.post("/addCourse", course_controller_1.addCourse);
