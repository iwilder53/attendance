
import { getModelForClass, prop, Ref } from "@typegoose/typegoose";
import { ObjectId } from "mongodb";
import { Course } from "../course/course";



export class Subject {

    readonly _id: ObjectId;

    readonly createdAt: Date;

    @prop({ required: true })
    subjectName: string;

    @prop({ required: true })
    semester: string;

    @prop({ ref: () => Course })
    course: Ref<Course>;




}

export const SubjectModel = getModelForClass(Subject, {
    schemaOptions: { timestamps: true, }
})