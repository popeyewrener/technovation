import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/constants.dart';

class JobEntry extends StatefulWidget {
  const JobEntry({Key? key}) : super(key: key);

  @override
  State<JobEntry> createState() => _JobEntryState();
}

class _JobEntryState extends State<JobEntry> {
  TextEditingController salarycontroller = TextEditingController();
  TextEditingController workcontroller = TextEditingController();
  TextEditingController skillcontroller = TextEditingController();
  TextEditingController vacancycontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController workconditioncontroller = TextEditingController();
  TextEditingController workdurationcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference firestorewrite =
        FirebaseFirestore.instance.collection('Work');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Job Profile',
                style: GoogleFonts.roboto(fontSize: 30),
              ),
            ),
            Formfield(
              namecontroller: workcontroller,
              field: 'Work you hire for',
            ),
            Formfield(
              namecontroller: skillcontroller,
              field: 'Skill required',
            ),
            Formfield(
              namecontroller: vacancycontroller,
              field: 'No of vacancies',
            ),
            Formfield(
              namecontroller: placecontroller,
              field: 'Place of work',
            ),
            Formfield(
              namecontroller: workconditioncontroller,
              field: 'Working conditions',
            ),
            Formfield(
              namecontroller: workdurationcontroller,
              field: 'Duration of work',
            ),
            Formfield(
              namecontroller: salarycontroller,
              field: 'Salary details',
            ),
            ElevatedButton(
                onPressed: () async {
                  await firestorewrite.add({
                    "work": workcontroller.text,
                    "skill": skillcontroller.text,
                    "vacancy": vacancycontroller.text,
                    "place": placecontroller.text,
                    "workingcond": workconditioncontroller.text,
                    "duration": workdurationcontroller.text,
                    "salary": salarycontroller.text,
                    "timestamp": Timestamp.now()
                  });
                  Navigator.pop(context);
                  AlertDialog(
                    title: Text('Your work has been posted'),
                  );
                },
                child: Text('Submit'))
          ]),
        ),
      ),
    );
  }
}
