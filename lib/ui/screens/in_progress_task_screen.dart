import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/show_task_details.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool getInProgressTasksInProgress = false;
  List<TaskModel> inProgressTaskList = [];

  Future<void> _getInProgressTasks() async {
    getInProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgress);
    if (response.inSuccessFul) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      inProgressTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load Tasks, Please Refresh');
      }
    }
    getInProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getInProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getInProgressTasks();
              },
              child: Visibility(
                visible: getInProgressTasksInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: inProgressTaskList.length,
                  itemBuilder: (context, index) {
                    //debugPrint(newTaskList[index].title ?? 'not got');
                    return ShowTaskDetails(taskModel: inProgressTaskList[index],onUpdateTask: (){},);
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
