"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserModel = exports.AttendanceModel = exports.User = exports.Attendance = void 0;
const typegoose_1 = require("@typegoose/typegoose");
const course_1 = require("../courses/course/course");
class Attendance {
}
exports.Attendance = Attendance;
class User {
}
__decorate([
    (0, typegoose_1.prop)({}),
    __metadata("design:type", Number)
], User.prototype, "roll", void 0);
__decorate([
    (0, typegoose_1.prop)({ required: true }),
    __metadata("design:type", String)
], User.prototype, "userName", void 0);
__decorate([
    (0, typegoose_1.prop)({ ref: () => course_1.Course }),
    __metadata("design:type", Object)
], User.prototype, "course", void 0);
__decorate([
    (0, typegoose_1.prop)({ type: Attendance, }),
    __metadata("design:type", Array)
], User.prototype, "attendance", void 0);
__decorate([
    (0, typegoose_1.prop)({}),
    __metadata("design:type", Boolean)
], User.prototype, "teacher", void 0);
exports.User = User;
exports.AttendanceModel = (0, typegoose_1.getModelForClass)(Attendance, { schemaOptions: { timestamps: true } });
exports.UserModel = (0, typegoose_1.getModelForClass)(User, {
    schemaOptions: { timestamps: true, }
});
