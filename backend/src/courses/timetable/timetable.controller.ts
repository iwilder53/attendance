import { Response, Request } from "express";
import { CourseModel } from "../course/course";
import { TimetableModel } from "./timetable";



export const getTimeTable = async (req: Request, res: Response) => {
    const { semester, course } = req.body;
    try {

        let courseid = await CourseModel.find({ course: course, semester: semester });
        //  let timetable = await TimetableModel.find({ course: courseid, semester: semester }).populate({ path: 'course', model: CourseModel });

        let timetable = await TimetableModel.find({ course: courseid, semester: semester });
        if (timetable) {
            return res.status(200).send({
                success: true,
                result: timetable,

            });

        } else {
            return res.status(400).send({
                message: 'No records found',
                success: false,

            });
        }

    } catch (err) {
        console.log(err);
        return res.status(400).send({
            success: false,
            message: err,
        });

    }

}

export const addTimetable = async (req: Request, res: Response) => {

    try {

        console.log(req.body);
        const { course, day } = req.body
        let courseToAdd = await CourseModel.findOne({ course: course });
        req.body.course = courseToAdd?._id;


        let existingCourse = await TimetableModel.findOne({ course: req.body.course, day: day, semester: req.body.semester });



        if (!existingCourse) {
            existingCourse = await TimetableModel.create({ ...req.body });
            if (existingCourse) {

                return res.status(200).send({
                    message: 'timetable created successfully',
                    success: true,
                    result: existingCourse,
                    //    accessToken: await createAccessToken(user._id)

                }
                );
            } else {
                return res.status(400).send({
                    message: 'timetable not created',
                    success: false,

                });
            }
        }
        else {
            return res.status(400).send({
                message: 'timetable already exists, please update',
                success: false,
                result: existingCourse,
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
};






export const updateTimetable = async (req: Request, res: Response) => {

    try {

        console.log(req.body);
        const { course, day } = req.body
        let courseToAdd = await CourseModel.findOne({ course: course });
        req.body.course = courseToAdd?._id;


        let existingCourse = await TimetableModel.findOneAndUpdate({ course: req.body.course, day: day, semester: req.body.semester }, { ...req.body }, { new: true });



        if (existingCourse) {
            if (existingCourse) {

                return res.status(200).send({
                    message: 'timetable updated successfully',
                    success: true,
                    result: existingCourse,
                    //    accessToken: await createAccessToken(user._id)

                }
                );
            } else {
                return res.status(400).send({
                    message: 'timetable not updated',
                    success: false,

                });
            }
        }
        else {
            return res.status(400).send({
                message: 'timetable does not exist, please create',
                success: false,
                result: existingCourse,
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
};



