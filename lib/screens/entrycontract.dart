import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hire/constants.dart';

class Entrycontract extends StatefulWidget {
  const Entrycontract({Key? key}) : super(key: key);

  @override
  State<Entrycontract> createState() => _EntrycontractState();
}

class _EntrycontractState extends State<Entrycontract> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController requirementcontroller = TextEditingController();
  TextEditingController emailaddresscontroller = TextEditingController();
  TextEditingController offaddcontroller = TextEditingController();
  TextEditingController aboutcompanycontroller = TextEditingController();
  CollectionReference firestorewrite =
      FirebaseFirestore.instance.collection('Contractor');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Your details',
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Formfield(
                namecontroller: namecontroller, field: 'Organisation if any'),
            Formfield(
                namecontroller: requirementcontroller, field: 'Requirements'),
            Formfield(
                namecontroller: emailaddresscontroller, field: 'Email address'),
            Formfield(
                namecontroller: offaddcontroller, field: 'Official Address'),
            Formfield(
                namecontroller: aboutcompanycontroller,
                field: 'About your company if any'),
            ElevatedButton(
                onPressed: () {
                  firestorewrite.add(
                    {
                      "Organisation": namecontroller.text,
                      "Requirements": requirementcontroller.text,
                      "email": emailaddresscontroller.text,
                      "officeadd": offaddcontroller.text,
                      "about": aboutcompanycontroller.text,
                    },
                  );
                  namecontroller.clear();
                  requirementcontroller.clear();
                  emailaddresscontroller.clear();
                  offaddcontroller.clear();
                  aboutcompanycontroller.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/contracthome', (Route<dynamic> route) => false);
                },
                child: Text('Submit'))
          ]),
        ),
      ),
    );
  }
}
