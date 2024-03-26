import mongoose, { Document, Schema } from 'mongoose';

// Define interfaces for type-checking
interface Course extends Document {
    course_code: string;
    course_name: string;
    instructor_id: mongoose.Types.ObjectId;
    schedule: Schedule[];
}

interface Instructor extends Document {
    instructor_name: string;
    courses_taught: string[];
}

interface Classroom extends Document {
    room_number: string;
    capacity: number;
    building: string;
}

interface TimetableEntry extends Document {
    course_id: mongoose.Types.ObjectId;
    instructor_id: mongoose.Types.ObjectId;
    day: string;
    start_time: string;
    end_time: string;
    classroom: string;
}

interface Schedule {
    day: string;
    start_time: string;
    end_time: string;
    classroom: string;
}

// Define schemas
const CourseSchema = new Schema<Course>({
    course_code: { type: String, required: true },
    course_name: { type: String, required: true },
    instructor_id: { type: Schema.Types.ObjectId, ref: 'Instructor', required: true },
    schedule: [{
        day: { type: String, required: true },
        start_time: { type: String, required: true },
        end_time: { type: String, required: true },
        classroom: { type: String, required: true }
    }]
});

const InstructorSchema = new Schema<Instructor>({
    instructor_name: { type: String, required: true },
    courses_taught: [{ type: String, required: true }]
});

const ClassroomSchema = new Schema<Classroom>({
    room_number: { type: String, required: true },
    capacity: { type: Number, required: true },
    building: { type: String, required: true }
});

const TimetableEntrySchema = new Schema<TimetableEntry>({
    course_id: { type: Schema.Types.ObjectId, ref: 'Course', required: true },
    instructor_id: { type: Schema.Types.ObjectId, ref: 'Instructor', required: true },
    day: { type: String, required: true },
    start_time: { type: String, required: true },
    end_time: { type: String, required: true },
    classroom: { type: String, required: true }
});

// Define models
const CourseModel = mongoose.model<Course>('Course', CourseSchema);
const InstructorModel = mongoose.model<Instructor>('Instructor', InstructorSchema);
const ClassroomModel = mongoose.model<Classroom>('Classroom', ClassroomSchema);
const TimetableEntryModel = mongoose.model<TimetableEntry>('TimetableEntry', TimetableEntrySchema);

export { CourseModel, InstructorModel, ClassroomModel, TimetableEntryModel };
