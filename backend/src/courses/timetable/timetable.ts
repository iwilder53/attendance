import { ObjectId } from "mongodb";
import { getModelForClass, prop, Ref } from "@typegoose/typegoose";
import { Course } from "../course/course";
export class Lecture {

    @prop()
    time: string;


    @prop()
    subject: string;

}
export class Timetable {

    readonly _id: ObjectId;

    readonly createdAt: Date;




    @prop({ required: true, ref: () => Course })
    course: Ref<Course>;
    @prop()
    day: string;
    @prop({})
    lectures: Lecture[]
    @prop({ required: true })
    semester: string;

}

export const TimetableModel = getModelForClass(Timetable, {
    schemaOptions: { timestamps: true, }
})
