import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/models/data.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/firebase_repo.dart';

class TaskProvider with ChangeNotifier {
  List<Task> taskList;

  Map<int, Task> lastDeletedTask = {};

  FirebaseTasksRepository _db;

  TaskProvider.init() {
    // initializeApp();
    _db = FirebaseTasksRepository();
    taskList = [];
  }

  Future<List<Task>> getTask() async {
    // if (taskList.isNotEmpty) {
    //   return taskList;
    // }
    var data = await _db.tasks();

    taskList = data;
    print(taskList);

    notifyListeners();
    return taskList;
  }

  void delteTask(int index) {
    var task = taskList[index];
    taskList.removeAt(index);
    lastDeletedTask.clear();
    lastDeletedTask[index] = task;
    _db.deleteTask(taskList[index]);
    notifyListeners();
  }

  void undoDeleteTask() {
    taskList.insert(lastDeletedTask.keys.first, lastDeletedTask.values.first);
    _db.addNewTask(lastDeletedTask.values.first);
    notifyListeners();
  }
}
