import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_set_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordPinVerfyScreen extends StatefulWidget {
  const ForgotPasswordPinVerfyScreen({super.key});

  @override
  State<ForgotPasswordPinVerfyScreen> createState() =>
      _ForgotPasswordPinVerfyScreenState();
}

class _ForgotPasswordPinVerfyScreenState
    extends State<ForgotPasswordPinVerfyScreen> {
  final TextEditingController _pinTEc = TextEditingController();

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
                  const SizedBox(
                    height: 200,
                  ),
                  Text(
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('A six digit PIN has sent to your email address',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    controller: _pinTEc,
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.grey.shade200,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.grey.shade400,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _onPressedVerify,
                    child: const Text('Verify'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: _onPressedSignInButton,
                        child: const Text('Sign in'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedVerify() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPasswordSetPasswordScreen()));
  }

  void _onPressedSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false);
  }
}
