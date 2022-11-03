import { Response, Request } from "express";
import { SubjectModel } from "./subjects";


export const addSubject = async (req: Request, res: Response) => {

    try {
        let subject = await SubjectModel.findOne({ name: req.body.name });
        console.log(req.body.user);
        if (!subject) {
            subject = await SubjectModel.create({ ...req.body });
            if (subject) {

                return res.status(200).send({
                    message: 'new subject created successfully',
                    success: true,
                    result: subject,
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
                result: subject,
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

