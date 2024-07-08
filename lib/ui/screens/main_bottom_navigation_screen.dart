import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/all_task_screen.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:task_manager/ui/widgets/my_app_bar.dart';

class MainBottomNavigationScreen extends StatefulWidget {
  const MainBottomNavigationScreen({super.key});

  @override
  State<MainBottomNavigationScreen> createState() => _MainBottomNavigationScreenState();
}

class _MainBottomNavigationScreenState extends State<MainBottomNavigationScreen> {

  int selectedInex = 0;
  final List<Widget> _renderScreens = [
    const AllTaskScreen(),
    const CompletedTaskScreen(),
    const InProgressTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(url: AssetPaths.url,fromUpdatedProfile : false,),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (index){
          setState(() {
            selectedInex = index;
          });
        },
        currentIndex: selectedInex,

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt),label: 'All Task'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all),label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.running_with_errors_outlined),label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel),label: 'Cancelled'),
        ],
      ),
      body: _renderScreens[selectedInex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onPressedAddButton,
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
  
  void _onPressedAddButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
  }


}
