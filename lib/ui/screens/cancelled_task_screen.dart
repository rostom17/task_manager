import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/show_task_details.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool getCancelledTasksInProgress = false;
  List<TaskModel> cancelledTaskList = [];

  Future<void> _getCancelledTask() async {
    getCancelledTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelled);
    if (response.inSuccessFul) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      cancelledTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load Tasks, Please Refresh');
      }
    }
    getCancelledTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getCancelledTask();
              },
              child: Visibility(
                visible: getCancelledTasksInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: cancelledTaskList.length,
                  itemBuilder: (context, index) {
                    //debugPrint(newTaskList[index].title ?? 'not got');
                    return ShowTaskDetails(taskModel: cancelledTaskList[index], onUpdateTask:() {
                      //_getAllTasks();
                      //_getTaskStatus();

                    },);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
