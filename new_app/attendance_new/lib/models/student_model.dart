class Student {
  String fname;
  String lname;
  String course;
  String section;
  int semester;
  List subjects = [];
  String email;
  int roll;
  String token;
  bool teacher;
  Student(
      {required this.course,
      required this.section,
      required this.semester,
      required this.subjects,
      this.email = 'null',
      required this.fname,
      required this.lname,
      required this.token,
      this.teacher = false,
      required this.roll});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        course: json['course']['course'] ?? ['course'],
        section: json['section'] ?? '-',
        semester: json['semester'],
        subjects: json['course']['subjects'],
        fname: json['firstName'],
        lname: json['lastName'],
        token: json['token'],
        roll: json['roll']);
  }
}
