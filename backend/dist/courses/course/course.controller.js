"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.addCourse = void 0;
const course_1 = require("./course");
const addCourse = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        let user = yield course_1.CourseModel.findOne({ roll: req.body.roll });
        console.log(req.body.user);
        if (!user) {
            user = yield course_1.CourseModel.create(Object.assign({}, req.body));
            if (user) {
                return res.status(200).send({
                    message: 'new course created successfully',
                    success: true,
                    result: user,
                    //    accessToken: await createAccessToken(user._id)
                });
            }
            else {
                return res.status(400).send({
                    message: 'course not created',
                    success: false,
                });
            }
        }
        else {
            return res.status(400).send({
                message: 'course already exists',
                success: false,
                result: user,
                //    accessToken: await createAccessToken(user._id)
            });
        }
    }
    catch (err) {
        console.log(err);
        return res.status(400).send({
            success: false,
            message: err,
        });
    }
});
exports.addCourse = addCourse;
