
import { getModelForClass, prop, Ref } from "@typegoose/typegoose";
import { ObjectId } from "mongodb";
import { Course } from "../courses/course/course";

export class Attendance {
    readonly _id: ObjectId;

    readonly createdAt: Date;

    @prop({})
    roll: number;


    @prop({})
    subject: string;
    @prop()
    class: ObjectId;

    @prop({})
    locationLat: string;

    @prop({})
    locationLng: string;

    @prop({})
    semester: string;

    @prop({})
    course: string;

}

export class User {

    readonly _id: string;

    readonly createdAt: Date;

    @prop({})
    roll: number;
    @prop({ required: true })
    userName: string;
    @prop({ required: true })
    firstName: string;
    @prop({ required: true })
    lastName: string

    @prop({ required: true })
    password: string

    @prop({ ref: () => Course, required: true })
    course: Ref<Course>;
    @prop()
    section: string;

    @prop({})
    phone: number;

    @prop({})
    year: string

    @prop({})
    token: string

    @prop({ required: true })
    email: string


    @prop()
    semester: number;
    @prop({ ref: () => Attendance })
    attendance: Ref<Attendance>[];

    @prop({})
    entries: number;

    @prop({ default: false })
    teacher: boolean;
}
export const AttendanceModel = getModelForClass(Attendance, { schemaOptions: { timestamps: true } })
export const UserModel = getModelForClass(User, {
    schemaOptions: { timestamps: true, }
})