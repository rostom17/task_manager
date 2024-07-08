import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class ShowTaskDetails extends StatefulWidget {
  const ShowTaskDetails({
    super.key,
    required this.taskModel,
    required this.onUpdateTask
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<ShowTaskDetails> createState() => _ShowTaskDetailsState();
}

class _ShowTaskDetailsState extends State<ShowTaskDetails> {
  bool deleteTaskInProgress = false;

  Future<void> deleteTasks() async {
    deleteTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));
    if (response.inSuccessFul) {
      showSnackBarMessage(context, "Task Deletion Successful");
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load Tasks, Please Refresh');
      }
    }
    deleteTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Card(
      elevation: 2,
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              height: 133,
              width: screenWidth - 100,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskModel.title ?? 'EmptyTitle',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.taskModel.description ?? 'EmptyDescription',
                      ),
                      Text(
                        widget.taskModel.createdDate ?? 'EmptyDate',
                      ),
                      // Text(
                      //   taskModel.status ?? 'EmptyStatus',
                      // ),
                      Chip(
                        label: Text(
                          widget.taskModel.status ?? 'EmptyStatus',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 133,
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                      visible: deleteTaskInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: IconButton(
                        onPressed: () {
                          deleteTasks();
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 30,
                          color: Colors.brown,
                        ),
                      )),
                  Visibility(
                      child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_note_outlined,
                      size: 35,
                      color: Colors.lightGreen,
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
