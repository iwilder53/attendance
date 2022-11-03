import { Attendance, AttendanceModel, UserModel } from "./user";
import { Response, Request } from "express";
import { CourseModel } from "../courses/course/course";
import { SubjectModel } from "../courses/subjects/subjects";

export const login = async (
    req: Request,
    res: Response,
) => {
    try {
        const { id } = req.body;

        let user = await UserModel.findOne({ id: id });
        console.log(user);
        if (!user) {
            return res.status(200).send({
                message: "New User",
                success: true,
            });

        } else {
            console.log(user);
            return res.status(200).send({
                message: "userfound",
                success: true,
                result: user,
                //  accessToken: await createAccessToken(user._id)
            });
        }
    } catch (error) {
        return res.status(200).send({
            success: false,
            error: error,
        });
    }
};

export const register = async (req: Request, res: Response) => {

    try {


        let user = await UserModel.findOne({ roll: req.body.roll });
        console.log(req.body.user);
        const { course } = req.body
        let courseToAdd = await CourseModel.findOne({ name: course });
        req.body.course = courseToAdd?._id;


        if (!user) {
            user = await UserModel.create({ ...req.body });
            if (user) {

                return res.status(200).send({
                    message: 'User created successfully',
                    success: true,
                    result: user,
                    //    accessToken: await createAccessToken(user._id)

                }
                );
            } else {
                return res.status(400).send({
                    message: 'User not created',
                    success: false,

                });
            }
        }
        else {
            return res.status(400).send({
                message: 'User already exists',
                success: false,
                result: user,
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


export const attend = async (req: Request, res: Response) => {
    try {
        const { roll, subject } = req.body;

        console.log(req.body);
        let currentAttendance = await AttendanceModel.create({ ...req.body });

        console.log("cuurent attendance" + currentAttendance);


        let user = await UserModel.findOneAndUpdate({ roll: roll }, { $push: { attendance: currentAttendance._id } }, { new: true })

        if (user && currentAttendance) {
            return res.status(200).send({
                message: 'attendance updated ',
                success: true,
                result: user,

            }

            );
        }
        else {
            return res.status(400).send({
                message: 'failed',
                success: false,

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

}


export const getAttendanceByUser = async (req: Request, res: Response) => {
    const { roll } = req.body;
    try {
        let attendance = await UserModel.find({ roll: roll }).populate({ path: 'course', model: CourseModel })
            .populate({ path: 'attendance', model: AttendanceModel });

        if (attendance) {
            return res.status(200).send({
                success: true,
                result: attendance,

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


export const getAttendanceBySubject = async (req: Request, res: Response) => {
    const { subject, semester, course } = req.body;
    try {
        let attendance = await AttendanceModel.find({ subject: subject, semester: semester, course: course });
        if (attendance) {
            return res.status(200).send({
                success: true,
                result: attendance,

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


