import 'package:task_manager/data/models/task_count_model.dart';

class TaskStatusCountWrapperModel {
  String? status;
  List<TaskCountModel>? taskCountList;

  TaskStatusCountWrapperModel({this.status, this.taskCountList});

  TaskStatusCountWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskCountList!.add(TaskCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCountList != null) {
      data['data'] = taskCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}