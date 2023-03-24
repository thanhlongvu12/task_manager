import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controls/control_model.dart';
import 'package:todolist/views/add_task_bottom_sheet_view.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return SizedBox(
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              HapticFeedback.heavyImpact();
              viewModel.bottomSheetBuilder(
                  const AddTaskBottomSheetView(), context);
            },
            child: const Icon(
              Icons.add,
              size: 30,
            )),
      );
    });
  }
}
