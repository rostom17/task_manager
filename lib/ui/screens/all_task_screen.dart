import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/show_task_details.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';
import 'package:task_manager/ui/widgets/task_status_widget.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  bool getAllTasksInProgress = false;

  List<TaskModel> newTaskList = [];

  Future<void> _getAllTasks() async {
    getAllTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.allTask);
    if (response.inSuccessFul) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load Tasks, Please Refresh');
      }
    }
    getAllTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TaskStatusWidget(),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllTasks();
              },
              child: Visibility(
                visible: getAllTasksInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: newTaskList.length,
                  itemBuilder: (context, index) {
                    //debugPrint(newTaskList[index].title ?? 'not got');
                    return ShowTaskDetails(taskModel: newTaskList[index],onUpdateTask:() {
                      _getAllTasks();
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
