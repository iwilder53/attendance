import '../models/lecture_model.dart';

sortList(List<Lecture> object) {
  object.sort((a, b) {
    var aProp = a.subject;
    var bProp = b.subject;
    return aProp.compareTo(bProp);
  });
}
sortTimetable(List<List<Lecture>> allLectures){
  List lectures = [];
 
}