
import { getModelForClass, prop, Ref } from "@typegoose/typegoose";
import { ObjectId } from "mongodb";
import { User } from "../../users/user";
import { Subject } from "../subjects/subjects";



export class Course {

    readonly _id: ObjectId;

    readonly createdAt: Date;


    @prop({ required: true })
    course: string;

    @prop({ required: true })
    semester: number;
    @prop()
    subjects: string[];

  /*        @prop({ ref: () => Subject })
        subjects: Ref<Subject>[]; */
    
    /*     @prop({ type: User })
        students: User[];
     */
    @prop({})
    startDate: Date;

    @prop({})
    endDate: Date;

}

export const CourseModel = getModelForClass(Course, {
    schemaOptions: { timestamps: true, }
})