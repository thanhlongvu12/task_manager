import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controls/control_model.dart';

class DeleteBottomSheetView extends StatelessWidget {
  const DeleteBottomSheetView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    viewModel.deleteAllTasks();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: viewModel.clrLvl1,
                    backgroundColor: viewModel.clrLvl3,
                    textStyle:
                        const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Delete All"),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    viewModel.deleteCompletedTasks();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: viewModel.clrLvl1,
                    backgroundColor: viewModel.clrLvl3,
                    textStyle:
                        const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Delete Completed"),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    viewModel.deleteUncompletedTasks();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: viewModel.clrLvl1,
                    backgroundColor: viewModel.clrLvl3,
                    textStyle:
                        const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Delete Uncompleted"),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
