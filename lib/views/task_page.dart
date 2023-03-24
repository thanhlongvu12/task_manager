import 'package:flutter/material.dart';
import 'package:todolist/views/add_task_view.dart';

import 'package:todolist/views/task_list_view.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Welcome Back Bro'),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: const [
              // Header View
              // Expanded(flex: 1, child: HeaderView()),

              // Task Info View
              // Expanded(flex: 1, child: TaskInfoView()),

              // Task List View
              Expanded(flex: 7, child: TaskListView()),
            ],
          ),
        ),
        floatingActionButton: const AddTaskView());
  }
}
