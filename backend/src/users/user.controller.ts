import { Attendance, AttendanceModel, UserModel } from "./user";
import { Response, Request } from "express";
import { CourseModel } from "../courses/course/course";
import "@typegoose/typegoose";
import { time } from "console";
import { createAccessToken } from "../auth.middleware";
import { Encrypt } from "../crypto";

export const login = async (
    req: Request,
    res: Response,
) => {
    try {

        const { email, pass } = req.body;

        //  let attendance = await AttendanceModel.find({ roll: id });
        // let attendanceList = await AttendanceModel.find({ roll: id });
        let user = await UserModel.findOne({ email: email }).populate({ path: 'course', model: CourseModel }).populate({ path: 'attendance', model: AttendanceModel });
        console.log(user);
        if (!user) {
            return res.status(200).send({
                message: "New User, Please register first",
                success: true,
            });

        } else {
            console.log(user);
            const passValid = await Encrypt.comparePassword(pass, user.password);
            if (!passValid) {
                return res.status(200).send({
                    message: "Invalid Password",
                    success: true,
                });
            }

            user.token = await createAccessToken(user._id)
            return res.status(200).send({
                message: "userfound",
                success: true,
                result: user,
                // attendance: attendanceList,

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

export const getTeacher = async (
    req: Request,
    res: Response,
) => {
    try {

        const { id } = req.body;

        // let attendance = await AttendanceModel.find({ roll: id });
        //let attendanceList = await AttendanceModel.find({ roll: id });
        let teacher = await UserModel.findOne({ id: id, teacher: true }).populate({ path: 'attendance', model: AttendanceModel });
        console.log(teacher);
        if (!teacher) {
            return res.status(200).send({
                message: "not found",
                success: true,
            });

        } else {
            console.log(teacher);
            return res.status(200).send({
                message: "teacher",
                success: true,
                result: teacher,


                //  accessToken: await createAccessToken(student._id)
            });
        }
    } catch (error) {
        return res.status(200).send({
            success: false,
            error: error,
        });
    }
};

export const getStudent = async (
    req: Request,
    res: Response,
) => {
    try {


        const id = (req.params.id);
        console.log(id);
        console.log("working")
        // let attendance = await AttendanceModel.find({ roll: id });
        let student = await UserModel.findOne({ _id: id })//.populate({ path: 'course', model: CourseModel }).populate({ path: 'attendance', model: AttendanceModel });
        let attendanceList = await AttendanceModel.find({ roll: student?.roll }).sort();
        let course = await CourseModel.findOne({ _id: student?.course })
        console.log(student);
        if (!student) {
            console.log(id);

            return res.status(200).send({
                message: "not found",
                success: true,
            });

        } else {
            console.log(student);
            return res.status(200).send({
                id: student.id,
                title: `${student.firstName} ${student.lastName}`,
                info: {
                    username: student.userName,
                    fullname: `${student.firstName} ${student.lastName}`,
                    email: student.email,
                    course: course?.course,
                    phone: student.phone,

                }
                , chart: {
                    dataKeys: [
                        { name: "subject", color: "#82ca9d" },
                        { name: "createdAt", color: "#8884d8" }],
                    data: attendanceList
                }


            });
        }
    } catch (error) {
        return res.status(200).send({
            success: false,
            error: error,
        });
    }
};

export const getStudents = async (
    req: Request,
    res: Response,
) => {
    try {
        let student = await UserModel.find({ isTeacher: false }).populate({ path: 'course', model: CourseModel }).sort({ 'firstName': 1 });
        console.log(student);
        if (!student) {
            return res.status(200).send({
                message: "not found",
                success: true,
            });

        } else {
            console.log(student);
            const data = student;
            return res.status(200).send(
                data
            );
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

        const { course, email, semester } = req.body
        let user = await UserModel.findOne({ email: req.body.email });
        req.body.password = await Encrypt.cryptPassword(req.body.password);



        if (!user) {
            let courseToAdd = await CourseModel.findOne({ course: course, semester: semester });
            req.body.course = courseToAdd?._id;
            user = await UserModel.create({ ...req.body });
            if (user) {
                user = await user.populate({ path: 'course', model: CourseModel });
                return res.status(200).send({
                    message: 'User created successfully',
                    success: true,
                    result: user,
                    accessToken: await createAccessToken(user._id)

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
                accessToken: await createAccessToken(user._id)
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

export const addStudent = async (req: Request, res: Response) => {

    try {

        console.log(req.body);

        const { course, email } = req.body
        let user = await UserModel.findOne({ email: req.body.email });
        let courseToAdd = await CourseModel.findOne({ course: course });
        req.body.course = courseToAdd?._id;

        req.body.password = await Encrypt.cryptPassword(req.body.password);




        if (!user) {
            user = await UserModel.create({ ...req.body });
            if (user) {

                return res.status(200).send({
                    message: 'User created successfully',
                    success: true,
                    result: user,
                    accessToken: await createAccessToken(user._id)

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
                accessToken: await createAccessToken(user._id)
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


export const getTeachers = async (
    req: Request,
    res: Response,
) => {
    try {
        const teacher = await UserModel.findOne({ isTeacher: true }).populate({ path: 'attendace', model: AttendanceModel }).populate({ path: 'course', model: CourseModel }).sort({ 'firstName': 1 });
        console.log(teacher);
        if (!teacher) {
            return res.status(200).send({
                message: "not found",
                success: true,
            });

        } else {
            console.log(teacher);
            const data = teacher;
            return res.status(200).send(
                data
            );
        }
    } catch (error) {
        return res.status(200).send({
            success: false,
            error: error,
        });
    }
};


//helper functions
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

function getCount(list: any[]) {
    return list.length;
}