import 'package:app_feedback/app_feedback.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/constants.dart';
import 'package:hire/screens/feedback.dart';
import 'package:titled_navigation_bar/src/navigation_bar.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    var device_height = MediaQuery.of(context).size.height;
    var device_width = MediaQuery.of(context).size.width;
    var currentuser = auth.currentUser;
    var firestore = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Com_name.toUpperCase(),
                    style: GoogleFonts.quicksand(
                        fontSize: big_icon_size, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HogeApp()),
                      );
                    },
                    child: Icon(
                      Icons.list,
                      size: big_icon_size,
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 96, 92, 92),
                                width: 2.0),
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () async {
                      await auth.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                    },
                    child: Icon(
                      Icons.logout,
                      size: big_icon_size,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: device_height * 0.02,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 4 / 2.8,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    autoPlay: true),
                items: [
                  'assets/images/1.jpg',
                  'assets/images/2.jpg',
                  'assets/images/3.jpg',
                  'assets/images/4.jpg',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                    height: device_height * 0.3,
                                    width: device_width * 0.8,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(child: Image.asset('${i}'))),
                              ],
                            ),
                          ]);
                    },
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: () {
                    launchAppFeedback(context);
                  },
                  child: Text('Feedback')),
              HogeApp()
            ],
          ),
        ),
      ),
    );
  }
}

class HogeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // <1> Use StreamBuilder
    return StreamBuilder<QuerySnapshot>(
        // <2> Pass `Stream<QuerySnapshot>` to stream
        stream: FirebaseFirestore.instance.collection('Work').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Container(
              height: 320,
              child: ListView(
                  shrinkWrap: true,
                  children: documents
                      .map((doc) => Card(
                            child: ListTile(
                              title: Text(doc['work']),
                              subtitle: Text(
                                  'Vacancy:${doc['vacancy']}, Duration:${doc['duration']}'),
                              trailing: Text(doc['salary']),
                            ),
                          ))
                      .toList()),
            );
          } else if (snapshot.hasError) {
            return Text('It\'s Error!');
          } else {
            return Text('');
          }
        });
  }
}
