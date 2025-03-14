import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/pages/auth/login_page.dart';
import 'package:blog_app/presentation/widgets/auth_button.dart';
import 'package:blog_app/presentation/widgets/auth_field.dart';
import 'package:blog_app/presentation/widgets/loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                AuthField(
                  hintText: "Email",
                  controller: emailController,
                ),
                const SizedBox(height: 25),
                AuthField(
                  hintText: "Username",
                  controller: nameController,
                ),
                const SizedBox(height: 25),
                AuthField(
                  hintText: "Password",
                  controller: passwordController,
                ),
                const SizedBox(height: 35),
                AuthButton(
                  text: "Sign Up",
                  onTap: () {
                    context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                  },
                ),
                const SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "  Log in",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService.push(context, const LoginPage());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
