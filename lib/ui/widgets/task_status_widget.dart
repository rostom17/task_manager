import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_status_count_wrapper_model.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class TaskStatusWidget extends StatefulWidget {
  const TaskStatusWidget({super.key});

  @override
  State<TaskStatusWidget> createState() => _TaskStatusWidgetState();
}

class _TaskStatusWidgetState extends State<TaskStatusWidget> {
  bool getTaskStatus = false;

  List<TaskCountModel> statusList = [];

  Future<void> _getTaskStatus() async {
    getTaskStatus = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.status);
    if (response.inSuccessFul) {
      TaskStatusCountWrapperModel taskListWrapperModel =
          TaskStatusCountWrapperModel.fromJson(response.responseData);
      statusList = taskListWrapperModel.taskCountList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to load Tasks, Please Refresh');
      }
    }
    getTaskStatus = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: statusList.map((elements) {
          return _buildCard(
              context, elements.sum.toString(), elements.sId ?? 'Unknown');
        }).toList(),
      ),
    );
  }

  Card _buildCard(BuildContext context, String taskNum, String taskName) {
    return Card(
      elevation: 3,
      color: Colors.green.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              taskNum,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              taskName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
