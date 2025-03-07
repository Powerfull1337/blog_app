import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/presentation/auth/register_page.dart';
import 'package:blog_app/presentation/widgets/auth_button.dart';
import 'package:blog_app/presentation/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            const AuthField(
              hintText: "Email",
            ),
            const SizedBox(height: 25),
            const AuthField(
              hintText: "Password",
            ),
            const SizedBox(height: 35),
            const AuthButton(
              text: "Sign In",
            ),
            const SizedBox(height: 25),
            RichText(
              text: TextSpan(
                text: "Dont have an account? ",
                style: const TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: "  Sign up",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        NavigationService.pushAndRemoveUntil(
                            context, const RegisterPage());
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
