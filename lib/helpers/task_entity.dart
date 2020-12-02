

class TaskEntity {
  final bool isDone;
  final String id;
  final String info;
  final String title;
  final String date;

  TaskEntity(this.title, this.id, this.info, this.isDone, this.date);

  Map<String, Object> toJson() {
    return {
      'isDone': isDone,
      'title': title,
      'info': info,
      'id': id,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'TaskEntity { isDone: $isDone, title: $title, info: $info, id: $id }';
  }

  Map<String, Object> toDocument() {
    return {
      'isDone': isDone,
      'title': title,
      'info': info,
    };
  }
}
