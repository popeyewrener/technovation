import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/constants.dart';

class Hiringform extends StatefulWidget {
  const Hiringform({Key? key}) : super(key: key);

  @override
  State<Hiringform> createState() => _HiringformState();
}

class _HiringformState extends State<Hiringform> {
  TextEditingController hireworkcontroller = TextEditingController();
  TextEditingController skillrequirecontroller = TextEditingController();
  TextEditingController vacacncycontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController workingconditioncontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController salarycontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Center(
                child: Text(
              'Hiring Details',
              style: GoogleFonts.roboto(fontSize: 24),
            )),
            Formfield(
                namecontroller: hireworkcontroller,
                field: 'Work you hire for '),
            Formfield(
                namecontroller: skillrequirecontroller,
                field: 'Skill required'),
            Formfield(namecontroller: vacacncycontroller, field: 'Vacancy'),
            Formfield(namecontroller: placecontroller, field: 'Place'),
            Formfield(
                namecontroller: workingconditioncontroller,
                field: 'Working condition'),
            Formfield(namecontroller: timecontroller, field: 'Time '),
            Formfield(namecontroller: salarycontroller, field: 'Salary'),
            Formfield(
                namecontroller: contactcontroller, field: 'Contact details'),
          ]),
        ),
      ),
    );
  }
}
