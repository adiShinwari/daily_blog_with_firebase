import 'package:blog_application/screens/blogs_screen.dart.dart';
import 'package:blog_application/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/universal_provider.dart';
import '../services/firebase_auth_method.dart';
import '../utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const routeName = './signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late UniversalProvider universalProvider;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signupWithEmailPass() {
    universalProvider.toggleSignupIsLoading();
    FirebaseAuthMethod(FirebaseAuth.instance)
        .signupWithEmailPass(
            email: emailController.text,
            password: passwordController.text,
            context: context)
        .then((value) {
      universalProvider.toggleSignupIsLoading();
      if (value == true) {
        emailController.text = '';
        passwordController.text = '';
        Navigator.pushNamedAndRemoveUntil(
            context, BlogsScreen.routeName, (route) => false);
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    universalProvider = Provider.of<UniversalProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Consumer<UniversalProvider>(
        builder: (context, value, child) {
          return value.signupIsLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: double.infinity,
                  child: child,
                );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: textFieldDecoration('Enter Email...'),
                cursorColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: textFieldDecoration('Enter Password...'),
                cursorColor: Colors.black,
              ),
            ),
            ElevatedButton(
                onPressed: signupWithEmailPass,
                child: const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account? '),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
