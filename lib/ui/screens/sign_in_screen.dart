import 'package:flutter/material.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controller/authentication_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_email_verify_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_navigation_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEc = TextEditingController();
  final TextEditingController _passwordTEc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool signInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailTEc,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter your email";
                        } else if (AssetPaths.emailChecker.hasMatch(value!) ==
                            false) {
                          return 'Enter valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passwordTEc,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          iconSize: 28,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter your password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: signInProgress == false,
                      replacement:const  Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: _onPressedNextButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPassword,
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
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

  Future<void> _signIn() async {
    signInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestLogin = {
      "email": _emailTEc.text.trim(),
      "password": _passwordTEc.text,
    };

    final NetworkResponse networkResponse =
        await NetworkCaller.postRequest(Urls.loginUrl, requestLogin);

    signInProgress = true;
    if (mounted) {
      setState(() {});
    }

    if (networkResponse.inSuccessFul) {
      LoginModel loginModel = LoginModel.fromJson(networkResponse.responseData);
      await AuthenticationController.saveAccessToken(loginModel.token!);
      await AuthenticationController.saveUserData(loginModel.userModel!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainBottomNavigationScreen(),
        ),
      );
      setState(() {

      });
    }
    else{
      showSnackBarMessage(context,  "Login Failed, Invalid Email or Password",true);
      signInProgress = false;
      setState(() {

      });
    }
  }

  void _onPressedNextButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  void _onTapForgotPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPasswordEmailVerifyScreen()));
  }

  @override
  void dispose() {
    _emailTEc.dispose();
    _passwordTEc.dispose();
    super.dispose();
  }
}
