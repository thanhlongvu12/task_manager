import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controls/control_model.dart';

import 'dart:async';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
          decoration: BoxDecoration(
              color: viewModel.clrLvl2,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30))),
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: viewModel.numTasks,
            itemBuilder: (context, index) {
              DateTime taskDeadline = viewModel.getTaskDeadline(index);
              bool isExpired = DateTime.now().isAfter(taskDeadline);
              bool isCompleted = viewModel.getTaskCompleted(index);

// Determine task color based on completed and expired status
              Color taskColor;
              if (isCompleted) {
                taskColor = Colors.lightGreenAccent;
              } else if (isExpired) {
                taskColor = Colors.redAccent;
              } else {
                taskColor = viewModel.clrLvl1;
              }

              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  HapticFeedback.mediumImpact();
                  viewModel.deleteTask(index);
                },
                background: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.red.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Icon(Icons.delete, color: Colors.red.shade700)),
                ),
                child: Opacity(
                  opacity: isCompleted ? 0.5 : 1,
                  child: IgnorePointer(
                    ignoring: isCompleted || isExpired,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: taskColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          side: BorderSide(width: 2, color: viewModel.clrLvl3),
                          checkColor: viewModel.clrLvl1,
                          activeColor: viewModel.clrLvl3,
                          value: viewModel.getTaskValue(index),
                          onChanged: (value) {
                            viewModel.setTaskValue(index, value!);
                          },
                        ),
                        title: Text(viewModel.getTaskTitle(index),
                            style: TextStyle(
                                color: viewModel.clrLvl4,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                        subtitle: Text(
                            'Deadline: ${DateFormat('dd/MM/yyyy').add_jm().format(viewModel.getTaskDeadline(index))}',
                            style: TextStyle(
                                color: viewModel.clrLvl3, fontSize: 12)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final titleController =
                                        TextEditingController(
                                            text:
                                                viewModel.getTaskTitle(index));
                                    final deadlineController =
                                        TextEditingController(
                                            text: DateFormat('dd/MM/yyyy')
                                                .add_jm()
                                                .format(viewModel
                                                    .getTaskDeadline(index)));

                                    return AlertDialog(
                                      title: const Text('Edit Task'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              labelText: 'Title',
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          TextField(
                                            controller: deadlineController,
                                            decoration: const InputDecoration(
                                              labelText: 'Deadline',
                                            ),
                                            onTap: () async {
                                              final picked =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: viewModel
                                                    .getTaskDeadline(index),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 365)),
                                              );
                                              if (picked != null) {
                                                final timePicked =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                    viewModel
                                                        .getTaskDeadline(index),
                                                  ),
                                                );
                                                if (timePicked != null) {
                                                  final deadline = DateTime(
                                                      picked.year,
                                                      picked.month,
                                                      picked.day,
                                                      timePicked.hour,
                                                      timePicked.minute);
                                                  deadlineController.text =
                                                      DateFormat('dd/MM/yyyy')
                                                          .add_jm()
                                                          .format(deadline);
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: viewModel.clrLvl3,
                                          ),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final title =
                                                titleController.text.trim();
                                            final deadline =
                                                DateFormat('dd/MM/yyyy')
                                                    .add_jm()
                                                    .parse(
                                                        deadlineController.text
                                                            .trim(),
                                                        true);
                                            viewModel.editTask(
                                                index, title, deadline);
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: viewModel.clrLvl3,
                                            foregroundColor: viewModel.clrLvl1,
                                          ),
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit, color: viewModel.clrLvl3),
                            ),
                            IconButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                viewModel.deleteTask(index);
                              },
                              icon: Icon(Icons.delete,
                                  color: Colors.red.shade700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ));
    });
  }
}
