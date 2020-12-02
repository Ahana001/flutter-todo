import 'dart:async';

import 'package:todo/models/task.dart';

abstract class TasksRepository {
  Future<void> addNewTask(Task task);

  Future<void> deleteTask(Task task);

  Future<List<Task>> tasks();

  Future<void> updateTask(Task task);
}
