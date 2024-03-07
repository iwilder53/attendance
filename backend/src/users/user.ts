
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
    @prop()
    firstName: string;
    @prop()
    lastName: string
   
    @prop({ ref: () => Course, required: true })
    course: Ref<Course>;
    @prop()
    section: string;

    @prop({})
    phone: number;

    @prop({})
    year: string

    @prop({})
    email: string


    @prop()
    semester: string;
    @prop({ ref: () => Attendance })
    attendance: Ref<Attendance>[];

    @prop({ default: false })
    teacher: boolean;
}
export const AttendanceModel = getModelForClass(Attendance, { schemaOptions: { timestamps: true } })
export const UserModel = getModelForClass(User, {
    schemaOptions: { timestamps: true, }
})