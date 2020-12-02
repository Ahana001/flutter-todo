class Task {
  final String title;
  final String info;
  final String date;
  final String id;
  final bool isDone;

  Task({this.title, this.info, this.date, this.id, this.isDone});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        title: json['title'] as String,
        info: json['info'] as String,
        date: json['date'] as String,
        id: json['id'] as String,
        isDone: json['isDone'] as bool);
  }

  Map<String, Object> toJson() {
    return {
      'isDone': isDone,
      'title': title,
      'info': info,
      'id': id,
      'date': date,
    };
  }
}
