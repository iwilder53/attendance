"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const course_routes_1 = require("./courses/course/course.routes");
const user_routes_1 = require("./users/user.routes");
const app = (0, express_1.default)();
// api/user
app.use("/user", user_routes_1.UserRouter);
//api/course
app.use("/course", course_routes_1.CourseRouter);
module.exports = app;
