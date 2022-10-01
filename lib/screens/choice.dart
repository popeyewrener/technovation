import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Choose your profile:',
              style: GoogleFonts.roboto(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/entryprofile');
                },
                child: Text('Worker')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/terms');
                },
                child: Text('Contractor')),
          )
        ],
      ),
    );
  }
}
