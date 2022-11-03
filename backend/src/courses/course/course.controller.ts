import { Response, Request } from "express";
import { CourseModel } from "./course";


export const addCourse = async (req: Request, res: Response) => {

    try {
        let user = await CourseModel.findOne({ roll: req.body.roll });
        console.log(req.body.user);
        if (!user) {
            user = await CourseModel.create({ ...req.body });
            if (user) {

                return res.status(200).send({
                    message: 'new course created successfully',
                    success: true,
                    result: user,
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

