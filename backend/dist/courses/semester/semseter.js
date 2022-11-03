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
exports.SemesterModel = exports.Semester = void 0;
const typegoose_1 = require("@typegoose/typegoose");
const subjects_1 = require("../subjects/subjects");
class Semester {
}
__decorate([
    (0, typegoose_1.prop)({ required: true }),
    __metadata("design:type", String)
], Semester.prototype, "course", void 0);
__decorate([
    (0, typegoose_1.prop)({ required: true }),
    __metadata("design:type", String)
], Semester.prototype, "semester", void 0);
__decorate([
    (0, typegoose_1.prop)({ type: subjects_1.Subject }),
    __metadata("design:type", Array)
], Semester.prototype, "subjects", void 0);
__decorate([
    (0, typegoose_1.prop)({}),
    __metadata("design:type", Date)
], Semester.prototype, "startDate", void 0);
__decorate([
    (0, typegoose_1.prop)({}),
    __metadata("design:type", Date)
], Semester.prototype, "endDate", void 0);
exports.Semester = Semester;
exports.SemesterModel = (0, typegoose_1.getModelForClass)(Semester, {
    schemaOptions: { timestamps: true, }
});
