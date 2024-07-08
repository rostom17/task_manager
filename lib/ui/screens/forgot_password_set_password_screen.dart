import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class ForgotPasswordSetPasswordScreen extends StatefulWidget {
  const ForgotPasswordSetPasswordScreen({super.key});

  @override
  State<ForgotPasswordSetPasswordScreen> createState() => _ForgotPasswordSetPasswordScreenState();
}

class _ForgotPasswordSetPasswordScreenState extends State<ForgotPasswordSetPasswordScreen> {

  final TextEditingController _newPasswordTEc = TextEditingController();
  final TextEditingController _confirmPasswordTEc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 180,),
                  Text('Set Password',style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 15,),
                  Text('Minimum length 8 with Letter and Number and Special Character combined',style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _newPasswordTEc,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'New Password',
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _confirmPasswordTEc,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 20,),

                  ElevatedButton(onPressed: (){}, child: const Text('Confirm'),),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
