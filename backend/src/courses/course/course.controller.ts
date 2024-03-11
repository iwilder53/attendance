import { Response, Request } from "express";
import { CourseModel } from "./course";


export const addCourse = async (req: Request, res: Response) => {

    try {

        const { sem } = req.body;
        let course = await CourseModel.findOne({ course: req.body.course, semester: sem });
        console.log(req.body);
        if (!course) {
            course = await CourseModel.create({ ...req.body });
            if (course) {

                return res.status(200).send({
                    message: 'new course created successfully',
                    success: true,
                    result: course,
                    //    accessToken: await createAccessToken(user._id)

                }
                );
            } else {
                return res.status(400).send({
                    message: 'course not created',
                    success: false,

                });
            }
        }
        else {
            return res.status(400).send({
                message: 'course already exists',
                success: false,
                result: course,
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


export const deleteCourse = async (req: Request, res: Response) => {

    try {
        const id = (req.params.id);
        /*       let course = await CourseModel.findOne({ course: req.body.course });
              console.log(req.body); */
        if (id) {
            const result = await CourseModel.deleteOne({ _id: id });
            if (result) {

                return res.status(200).send({
                    message: ' course deleted successfully',
                    success: true,


                }
                );
            } else {
                return res.status(400).send({
                    message: 'course not deleted',
                    success: false,

                });
            }
        }
        else {
            return res.status(400).send({
                message: 'course does not exist',
                success: false,
                result: req.params,
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


export const getCourses = async (req: Request, res: Response) => {

    try {
        const courses = await CourseModel.find();

        if (courses) {
            const courseList = courses.map((e) => e.course);

            return res.status(200).send({
                message: 'courses fetched successfully',
                success: true,
                result: courseList,

            }
            );
        } else {
            return res.status(400).send({
                message: 'course not found',
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
};

