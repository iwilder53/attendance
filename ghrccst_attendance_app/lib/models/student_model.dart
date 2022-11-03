import 'lecture_model.dart';

class Student{
  String name;
  List<Lecture> lectures;
  String course;
  String section;
  String semester;

  Student({required this.course,required this.section,required this.semester, required this.lectures,required this.name});
}