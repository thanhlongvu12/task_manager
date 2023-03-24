import 'package:flutter/material.dart';

import '../models/task_model.dart';

class AppViewModel extends ChangeNotifier {
  List<Task> tasks = <Task>[];

  Color clrLvl1 = Colors.blue;
  Color clrLvl2 = Colors.grey.shade200;
  Color clrLvl3 = Colors.teal.shade800;
  Color clrLvl4 = Colors.grey.shade900;

  int get numTasks => tasks.length;

  int get numTasksRemaining => tasks.where((task) => !task.complete).length;

  int get numTasksCompleted => tasks.where((task) => task.complete).length;

  get numTasksExpired => null;

  void addTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  bool getTaskValue(int taskIndex) {
    return tasks[taskIndex].complete;
  }

  String getTaskTitle(int taskIndex) {
    return tasks[taskIndex].title;
  }

  void deleteTask(int taskIndex) {
    tasks.removeAt(taskIndex);
    notifyListeners();
  }

  void setTaskValue(int taskIndex, bool taskValue) {
    tasks[taskIndex].complete = taskValue;
    notifyListeners();
  }

  void deleteAllTasks() {
    tasks.clear();
    notifyListeners();
  }

  void deleteCompletedTasks() {
    tasks = tasks.where((task) => !task.complete).toList();
    notifyListeners();
  }

  void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: ((context) {
          return bottomSheetView;
        }));
  }

  DateTime getTaskDeadline(int index) {
    return tasks[index].deadline;
  }

  void deleteUncompletedTasks() {
    tasks = tasks.where((task) => task.complete).toList();
    notifyListeners();
  }

  void editTask(int index, String title, DateTime deadline) {
    tasks[index].title = title;
    tasks[index].deadline = deadline;
    notifyListeners();
  }

  bool getTaskCompleted(int index) {
    return tasks[index].complete;
  }
}
