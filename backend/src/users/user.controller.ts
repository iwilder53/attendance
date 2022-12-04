import { Attendance, AttendanceModel, UserModel } from "./user";
import { Response, Request } from "express";
import { CourseModel } from "../courses/course/course";
import "@typegoose/typegoose";
import { time } from "console";

export const login = async (
    req: Request,
    res: Response,
) => {
    try {

        const { phone } = req.body;
        // let attendance = await AttendanceModel.find({ roll: id });
        //let attendanceList = await AttendanceModel.find({ roll: id });
        let user = await UserModel.findOne({ phone: phone }).populate({ path: 'course', model: CourseModel }).populate({ path: 'attendance', model: AttendanceModel });
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
                //    attendance: attendanceList

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

        console.log(req.body);

        let user = await UserModel.findOne({ roll: req.body.roll });
        const { course } = req.body
        let courseToAdd = await CourseModel.findOne({ course: course });
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

        const { roll, id, locationLat, locationLng } = req.body;


        let attendanceId = await AttendanceModel.findOne({ _id: id });


        if (!attendanceId) {
            return res.status(400).send({
                message: 'failed',
                success: false,

            });
        } else {

            const distanceFromCollege = getDistanceFromLatLonInKm(Number.parseFloat(attendanceId.locationLat), Number.parseFloat(attendanceId.locationLng), Number.parseFloat(locationLat), Number.parseFloat(locationLng));

            console.log('distance' + distanceFromCollege + attendanceId
            );
            let dt = attendanceId.createdAt;
            const attendanceDt = dt.getTime();
            const currentDt = new Date();
            const currentDtMillis = currentDt.getTime();

            if (distanceFromCollege > 0.1 || (currentDtMillis - attendanceDt) > 60000) {
                return res.status(400).send({
                    message: 'Away From College',
                    success: false,

                });
            }
        }

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

export const generateAttendance = async (req: Request, res: Response) => {
    try {
        const { roll, subject } = req.body;

        console.log(req.body);
        let currentAttendance = await AttendanceModel.create({ ...req.body });



        let user = await UserModel.findOneAndUpdate({ roll: roll }, { $push: { attendance: currentAttendance._id } }, { new: true })

        if (user && currentAttendance) {
            return res.status(200).send({
                message: 'attendance updated ',
                success: true,
                result: user,
                attendance: currentAttendance._id

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



function distance(lat1: number, lon1: number, lat2: number, lon2: number, unit: string) {
    if ((lat1 == lat2) && (lon1 == lon2)) {
        return 0;
    }
    else {
        var radlat1 = Math.PI * lat1 / 180;
        var radlat2 = Math.PI * lat2 / 180;
        var theta = lon1 - lon2;
        var radtheta = Math.PI * theta / 180;
        var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
        if (dist > 1) {
            dist = 1;
        }
        dist = Math.acos(dist);
        dist = dist * 180 / Math.PI;
        dist = dist * 60 * 1.1515;
        if (unit == "K") { dist = dist * 1.609344 }
        if (unit == "N") { dist = dist * 0.8684 }
        return dist;
    }
}

function getDistanceFromLatLonInKm(lat1: number, lon1: number, lat2: number, lon2: number) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1);  // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2)
        ;
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
}

function deg2rad(deg: number) {
    return deg * (Math.PI / 180)
}