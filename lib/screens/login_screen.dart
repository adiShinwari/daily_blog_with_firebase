import 'package:blog_application/screens/blogs_screen.dart.dart';
import 'package:blog_application/screens/signup_screen.dart';
import 'package:blog_application/services/firebase_auth_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/universal_provider.dart';
import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = './login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late UniversalProvider universalProvider;
 

  void _loginWithEmailPass() {
    universalProvider.toggleLoginIsLoading();
    FirebaseAuthMethod(FirebaseAuth.instance)
        .loginWithEmailPass(
            emailController.text, passwordController.text, context)
        .then((value) {
      universalProvider.toggleLoginIsLoading();
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
        title: const Text('Login'),
        
      ),
      body: Consumer<UniversalProvider>(
        builder: (context, value, child) => value.loginIsLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(width: double.infinity, child: child),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login',
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
              onPressed: _loginWithEmailPass,
              child: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have account?  '),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignupScreen.routeName);
                    },
                    child: Text(
                      'create one',
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
