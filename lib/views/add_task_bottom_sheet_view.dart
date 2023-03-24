import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controls/control_model.dart';

import '../../models/task_model.dart';

class AddTaskBottomSheetView extends StatefulWidget {
  const AddTaskBottomSheetView({Key? key});

  @override
  _AddTaskBottomSheetViewState createState() => _AddTaskBottomSheetViewState();
}

class _AddTaskBottomSheetViewState extends State<AddTaskBottomSheetView> {
  final TextEditingController titleController = TextEditingController();
  DateTime? deadline;
  TimeOfDay? deadlineTime;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: titleController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter Task Title',
                      hintStyle: TextStyle(color: viewModel.clrLvl2),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: viewModel.clrLvl2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: viewModel.clrLvl2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        final TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          setState(() {
                            deadline = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                            deadlineTime = selectedTime;
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: viewModel.clrLvl2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        deadline == null
                            ? 'Select Deadline'
                            : DateFormat('dd/MM/yyyy hh:mm a')
                                .format(deadline!),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        final newTask = Task(
                          titleController.text,
                          false,
                          deadline ?? DateTime.now(),
                        );
                        viewModel.addTask(newTask);
                        titleController.clear();
                        deadline = null;
                        deadlineTime = null;
                        Navigator.of(context).pop();
                      }
                    },
                    // style: ElevatedButton.styleFrom(
                    //     // primary: viewModel.clrLvl3,
                    //     side: BorderSide(width: 8)),
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
