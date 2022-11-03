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
exports.addSubject = void 0;
const subjects_1 = require("./subjects");
const addSubject = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        let subject = yield subjects_1.SubjectModel.findOne({ name: req.body.name });
        console.log(req.body.user);
        if (!subject) {
            subject = yield subjects_1.SubjectModel.create(Object.assign({}, req.body));
            if (subject) {
                return res.status(200).send({
                    message: 'new subject created successfully',
                    success: true,
                    result: subject,
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
                result: subject,
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
exports.addSubject = addSubject;
