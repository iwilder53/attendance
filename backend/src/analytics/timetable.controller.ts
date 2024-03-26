import { Response, Request } from "express";
import { AttendanceModel } from "../users/user";
import { TimetableModel } from "../courses/timetable/timetable";
import { CourseModel } from "../courses/course/course";



export const getAttendance = async (req: Request, res: Response) => {

    try {

        let logs = await AttendanceModel.find();

        if (logs) {
            return res.status(200).send({
                success: true,
                result: logs,

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

export const topWeeklyStudents = async (req: Request, res: Response) => {

    try {


        let attencanceList = await AttendanceModel.find();

        const students = attencanceList.map((e) => { roll: e.roll });




        let existingCourse = await TimetableModel.findOne({ course: req.body.course, semester: req.body.semester });



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

        //  req.body = JSON.parse(req.body);

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



