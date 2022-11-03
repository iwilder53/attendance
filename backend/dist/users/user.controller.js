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
exports.attend = exports.register = exports.login = void 0;
const user_1 = require("./user");
const course_1 = require("../courses/course/course");
const login = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.body;
        let user = yield user_1.UserModel.findOne({ id: id });
        console.log(user);
        if (!user) {
            return res.status(200).send({
                message: "New User",
                success: true,
            });
        }
        else {
            console.log(user);
            return res.status(200).send({
                message: "User Already exists",
                success: true,
                result: user,
                //  accessToken: await createAccessToken(user._id)
            });
        }
    }
    catch (error) {
        return res.status(200).send({
            success: false,
            error: error,
        });
    }
});
exports.login = login;
const register = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        let user = yield user_1.UserModel.findOne({ roll: req.body.roll });
        console.log(req.body.user);
        const { course } = req.body;
        let courseToAdd = yield course_1.CourseModel.findOne({ name: course });
        req.body.course = courseToAdd === null || courseToAdd === void 0 ? void 0 : courseToAdd._id;
        if (!user) {
            user = yield user_1.UserModel.create(Object.assign({}, req.body));
            if (user) {
                return res.status(200).send({
                    message: 'User created successfully',
                    success: true,
                    result: user,
                    //    accessToken: await createAccessToken(user._id)
                });
            }
            else {
                return res.status(400).send({
                    message: 'User not created',
                    success: false,
                });
            }
        }
        else {
            return res.status(400).send({
                message: 'User already exists',
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
exports.register = register;
const attend = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { roll, subject } = req.body;
        // let order = await OrderModel.findOneAndUpdate(
        //     { _id: orderId, "products.product": productId },
        //     { "products.$.quantity": req.body.quantity },
        //     { new: true, }
        // );
        //  let user = await UserModel.findOne({ roll: roll })
        req.body.day = new Date();
        req.body.present = true;
        let currentAttendance = yield user_1.AttendanceModel.create(Object.assign({}, req.body), { new: true });
        console.log(currentAttendance);
        let user = yield user_1.UserModel.updateOne({ roll: roll }, { $push: { attendance: currentAttendance } });
        if (user && currentAttendance) {
            return res.status(200).send({
                message: 'order updated',
                success: true,
                result: user,
            });
        }
        else {
            return res.status(400).send({
                message: 'order updated',
                success: false,
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
exports.attend = attend;
