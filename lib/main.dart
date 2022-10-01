import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hire/screens/choice.dart';
import 'package:hire/screens/contracthome.dart';
import 'package:hire/screens/entrycontract.dart';
import 'package:hire/screens/entryprofile.dart';
import 'package:hire/screens/hiringform.dart';
import 'package:hire/screens/homepage.dart';
import 'package:hire/screens/jobentry.dart';
import 'package:hire/screens/login1.dart';
import 'package:hire/screens/photo.dart';
import 'package:hire/screens/signUp_view.dart';
import 'package:hire/screens/terms.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Files App',
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.done &&
              FirebaseAuth.instance.currentUser != null) {
            return Home();
          } else if (snapshot.connectionState == ConnectionState.done &&
              FirebaseAuth.instance.currentUser == null) {
            return LoginView();
          }
          return CircularProgressIndicator();
        },
      ),
      routes: {
        "/login": (context) => LoginView(),
        "/signup": (context) => SignUpView(),
        "/home": (context) => Home(),
        '/entryprofile': (context) => EntryProfile(),
        '/entrycontract': (context) => Entrycontract(),
        '/choice': (context) => Choice(),
        '/terms': (context) => Terms(),
        '/jobentry': (context) => JobEntry(),
        '/contracthome': (context) => Contracthome()
      },
    );
  }
}
