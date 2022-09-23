import 'package:blog_application/provider/universal_provider.dart';
import 'package:blog_application/screens/blogs_screen.dart.dart';
import 'package:blog_application/screens/home_screen.dart';
import 'package:blog_application/screens/login_screen.dart';
import 'package:blog_application/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => UniversalProvider()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          SignupScreen.routeName: ((context) => const SignupScreen()),
          LoginScreen.routeName: (context) => const LoginScreen(),
          BlogsScreen.routeName: (context) => const BlogsScreen(),
        },
      ),
    );
  }
}
