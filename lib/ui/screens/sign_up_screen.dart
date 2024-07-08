import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/urls.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEc = TextEditingController();
  final TextEditingController _firstNameTEc = TextEditingController();
  final TextEditingController _lastNameTEc = TextEditingController();
  final TextEditingController _mobileNumTEc = TextEditingController();
  final TextEditingController _passwordTEc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool regInProgress = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 25,
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: _firstNameTEc,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter your First Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _lastNameTEc,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter your last Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _mobileNumTEc,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter your mobile number";
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
                      obscureText: showPassword,
                      //maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          icon: Icon(showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,),
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
                      visible: regInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _registerUser();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
      ),
    );
  }

  void _registerUser() async {
    regInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestInput = {
      "email": _emailTEc.text.trim(),
      "firstName": _firstNameTEc.text.trim(),
      "lastName": _lastNameTEc.text.trim(),
      "mobile": _mobileNumTEc.text.trim(),
      "password": _passwordTEc.text,
      "photo": "",
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, requestInput);
    regInProgress = false;
    if (response.inSuccessFul) {
      _clearTextField();
      if (mounted) {
        showSnackBarMessage(context, "Registration SuccessFull");
        setState(() {

        });
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage ?? "Registration Failed try again" );
        setState(() {

        });
      }
    }
  }

  void _clearTextField() {
    _emailTEc.clear();
    _firstNameTEc.clear();
    _lastNameTEc.clear();
    _mobileNumTEc.clear();
    _passwordTEc.clear();
  }

  @override
  void dispose() {
    _emailTEc.dispose();
    _firstNameTEc.dispose();
    _lastNameTEc.dispose();
    _mobileNumTEc.dispose();
    _passwordTEc.dispose();
    super.dispose();
  }
}
