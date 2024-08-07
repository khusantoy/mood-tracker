import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/auth_controller.dart';
import 'package:mood_tracker/utils/messages.dart';
import 'package:mood_tracker/views/widgets/textformfield_item.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authController = AuthController();

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      Messages.showLoadingDialog(context);
      await _authController
          .register(
        emailAddress: emailController.text,
        password: passwordController.text,
      )
          .then((user) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextformfieldItem(
                labelText: "Email",
                textEditingController: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your email";
                  } else {
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return "Email is wrong";
                    }
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextformfieldItem(
                labelText: "Password",
                textEditingController: passwordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your password";
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              TextformfieldItem(
                labelText: "Confirm Password",
                textEditingController: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your password";
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "Password doesn't match";
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _validateAndSubmit,
                  child: const Text("Register"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("If you already heave an account"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
