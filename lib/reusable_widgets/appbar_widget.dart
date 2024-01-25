import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBar_Widget extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final enableBack;

  const AppBar_Widget(
      {super.key, required this.title, required this.enableBack});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: enableBack,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/signin", (r) => false);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SignInScreen()),
              // );
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.logout_outlined,
                size: 24.0,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}
