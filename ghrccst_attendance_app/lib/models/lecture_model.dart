class Lecture {
  Lecture({required this.subject, required this.time, this.day = ''});
  String day;
  String subject;
  String time;
  bool marked = false;

  Map<String, dynamic> toJson() =>
      {'subject': subject, 'day': day, 'time': time, 'marked': marked};

  Lecture.fromJson(Map<String, dynamic> json)
      : subject = json['subject'],
        day = json['day'],
        time = json['time'],
        marked = json['marked'];
}
