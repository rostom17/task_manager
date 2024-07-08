import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/my_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEc = TextEditingController();
  final TextEditingController _descriptionTEc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        url: AssetPaths.url,
        fromUpdatedProfile: false,
      ),
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _titleTEc,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        //labelText: 'Enter description',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter proper description";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 8,
                      controller: _descriptionTEc,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        //labelText: 'Enter description',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter proper description";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Visibility(
                      visible: addNewTaskInProgress == false,
                      replacement: const CircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: onPressedAddButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPressedAddButton() {
    if (_formKey.currentState!.validate() == true) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestAddTaskData = {
      "title": _titleTEc.text.trim(),
      "description": _descriptionTEc.text.trim(),
      "status": "New"
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.addNewTask, requestAddTaskData);

    addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.inSuccessFul) {
      clearTextField();
      if (mounted) {
        showSnackBarMessage(context, "New Task Added Successfully");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, "Failed to Add New Task\nTry Again", true);
      }
    }
  }

  void clearTextField() {
    _titleTEc.clear();
    _descriptionTEc.clear();
  }
}
