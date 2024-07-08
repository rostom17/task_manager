import 'package:flutter/material.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/my_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailTEc = TextEditingController();
  final TextEditingController _firstNameTEc = TextEditingController();
  final TextEditingController _lasNameTEc = TextEditingController();
  final TextEditingController _mobileTEc = TextEditingController();
  final TextEditingController _passwordTEc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        url: AssetPaths.url,
        fromUpdatedProfile: true,
      ),
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildPhotoPicker(),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: const  InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration:const  InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration:const  InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_circle_right_outlined),
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

  Container _buildPhotoPicker() {
    return Container(
      width: double.maxFinite,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
      child: Container(
        width: 100,
        height: 48,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          color: Colors.grey,
        ),
        alignment: Alignment.center,
        child: const Text(
          'Photo',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
