import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Contracthome extends StatefulWidget {
  const Contracthome({Key? key}) : super(key: key);

  @override
  State<Contracthome> createState() => _ContracthomeState();
}

class _ContracthomeState extends State<Contracthome> {
  var user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Row(
              children: [
                Text(
                  'Contractor\'s homepage',
                  style: TextStyle(fontSize: 30),
                ),
                GestureDetector(
                  child: Icon(Icons.logout),
                  onTap: () async {
                    await user.signOut();
                    Navigator.pushNamed(context, '/login');
                  },
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text('Tap here to post work'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/jobentry');
                },
                child: Text('Add work')),
          ]),
        ),
      ),
    );
  }
}
