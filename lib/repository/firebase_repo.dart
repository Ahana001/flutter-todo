import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/task_repo.dart';

class FirebaseTasksRepository implements TasksRepository {
  final taskCollection = FirebaseFirestore.instance.collection('todo');

  @override
  Future<void> addNewTask(Task task) {
    return taskCollection.doc(task.id).set(task.toJson());
  }

  @override
  Future<void> deleteTask(Task task) async {
    return taskCollection.doc(task.id.toString()).delete();
  }

  @override
  Future<List<Task>> tasks() async {
    var query = await taskCollection.get();
    var docs = query.docs;
    var taskList = docs.map((e) {
      return Task.fromJson(e.data());
    }).toList();
    return taskList;
  }

  @override
  Future<void> updateTask(Task update) {
    return taskCollection.doc(update.id.toString()).update(update.toJson());
  }
}
