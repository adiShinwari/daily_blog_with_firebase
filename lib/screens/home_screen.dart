import 'package:blog_application/provider/universal_provider.dart';
import 'package:blog_application/screens/blogs_screen.dart.dart';
import 'package:blog_application/screens/login_screen.dart';
import 'package:blog_application/services/firebase_auth_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = './homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog Checker'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Consumer<UniversalProvider>(
            builder: (context, value, child) => value.googleSignin == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: const Text('Login With email/pass'),
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder()),
                          onPressed: () {
                            value.toggleGoogleSignin();
                            FirebaseAuthMethod(FirebaseAuth.instance)
                                .googleSignin(context)
                                .then((_) {
                              value.toggleGoogleSignin();
                              if (_ == true) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    BlogsScreen.routeName, (route) => false);
                              }
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.google,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Google Sign in')
                            ],
                          ))
                    ],
                  ),
          ),
        ));
  }
}
