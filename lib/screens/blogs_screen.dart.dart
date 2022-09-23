import 'package:blog_application/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlogsScreen extends StatefulWidget {
  static const routeName = './blogsScreen';
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final _auth = FirebaseAuth.instance;

  late User user;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        user = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Blogs'),
        actions: [
          IconButton(
            onPressed: () async {
              _auth.signOut().then((value) => Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false));
            },
            icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
          )
        ],
      ),
      body: Center(
        // child: Text('Welcome ${user.email!.split('@')[0]}'),
        child: Text('Welcome ${user.displayName}'),
      ),
    );
  }
}
