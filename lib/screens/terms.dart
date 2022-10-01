import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/constants.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  final _controller = ScrollController();
  var islocked = false;

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          setState(() {
            islocked = false;
          });
          print('At the bottom');
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Terms and conditions',
              style: GoogleFonts.roboto(fontSize: 30),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(terms),
                controller: _controller,
              ),
              flex: 2,
            ),
            ElevatedButton(
                onPressed: () {
                  islocked
                      ? null
                      : Navigator.of(context).pushNamedAndRemoveUntil(
                          '/entrycontract', (Route<dynamic> route) => false);
                },
                child: Text('I agree'))
          ],
        ),
      ),
    );
  }
}
