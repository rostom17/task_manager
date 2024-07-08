import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/show_task_details.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool getCompletedTasksInProgress = false;
  List<TaskModel> completedTaskList = [];

  Future<void> _getCompletedTasks() async {
    getCompletedTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.competedTask);
    if (response.inSuccessFul) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      completedTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load Tasks, Please Refresh');
      }
    }
    getCompletedTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  int lengthOfCompletedTask () {
    _getCompletedTasks();
    return completedTaskList.length;
  }

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getCompletedTasks();
              },
              child: Visibility(
                visible: getCompletedTasksInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: completedTaskList.length,
                  itemBuilder: (context, index) {
                    //debugPrint(newTaskList[index].title ?? 'not got');
                    return ShowTaskDetails(taskModel: completedTaskList[index], onUpdateTask: (){},);
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
