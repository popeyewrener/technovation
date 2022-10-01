import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/constants.dart';
import 'package:image_picker/image_picker.dart';

class EntryProfile extends StatefulWidget {
  const EntryProfile({Key? key}) : super(key: key);

  @override
  State<EntryProfile> createState() => _EntryProfileState();
}

class _EntryProfileState extends State<EntryProfile> {
  final ImagePicker _picker = ImagePicker();
  @override
  TextEditingController namecontroller = TextEditingController();
  TextEditingController skilledcontroller = TextEditingController();
  TextEditingController expreiencecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference firestorewrite =
        FirebaseFirestore.instance.collection('Worker');
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Text(
                'Provide us your details',
                style: GoogleFonts.roboto(fontSize: 24),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Formfield(
              namecontroller: namecontroller,
              field: 'Name',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Formfield(
              namecontroller: skilledcontroller,
              field: 'Skilled in',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Formfield(
              namecontroller: expreiencecontroller,
              field: 'Experience',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Formfield(
              namecontroller: addresscontroller,
              field: 'Address',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Formfield(
              namecontroller: contactcontroller,
              field: 'Contact Details',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ElevatedButton(
                onPressed: () {
                  firestorewrite.add({
                    "uid": user,
                    "name": namecontroller.text,
                    "skilled": skilledcontroller.text,
                    'experience': expreiencecontroller.text,
                    'address': addresscontroller.text,
                    'contact': contactcontroller.text,
                    'timestamp': Timestamp.now()
                  });
                  namecontroller.clear();
                  skilledcontroller.clear();
                  expreiencecontroller.clear();
                  addresscontroller.clear();
                  contactcontroller.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
                child: Text('Submit'))
          ]),
        ),
      ),
    );
  }
}
