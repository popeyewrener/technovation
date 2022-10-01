import 'package:app_feedback/app_feedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:translator/translator.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
final translator = GoogleTranslator();
const kMessageTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.060,
      fontWeight: FontWeight.bold,
    );

TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.030,
    );

TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: 15, color: Colors.grey, height: 1.5);

TextStyle kHaveAnAccountStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.black);

TextStyle kLoginOrSignUpTextStyle(
  Size size,
) =>
    GoogleFonts.ubuntu(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
      color: Colors.deepPurpleAccent,
    );

TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.black);

const big_icon_size = 32.0;
const Com_name = 'HIRE';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class Formfield extends StatelessWidget {
  const Formfield({
    Key? key,
    required this.namecontroller,
    required this.field,
  }) : super(key: key);

  final TextEditingController namecontroller;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: kTextFormFieldStyle(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: field,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        controller: namecontroller,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter username';
          } else if (value.length < 4) {
            return 'at least enter 4 characters';
          }
          return null;
        },
      ),
    );
  }
}

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return TitledBottomNavigationBar(
        activeColor: Color.fromARGB(255, 232, 136, 10),
        currentIndex: index, // Use this to update the Bar giving a position
        onTap: (index) {
          print("Selected Index: $index");
        },
        items: [
          TitledNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
          TitledNavigationBarItem(
              title: Text('Stores'), icon: Icon(Icons.store)),
          TitledNavigationBarItem(
              title: Text('Profile'), icon: Icon(Icons.store)),
          TitledNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              title: Text('Subscriptions')),
        ]);
  }
}

class Profession extends StatelessWidget {
  String profname, profimg, tag;
  Profession({this.profname = 'N/A', this.profimg = '', this.tag = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Hero(
            tag: '/$tag',
            child: GestureDetector(
              onTap: (() {
                Navigator.pushNamed(context, '/profession');
              }),
              child: CircleAvatar(
                radius: 50,
                child: Image.asset('$profimg'),
              ),
            ),
          ),
          Text('$profname')
        ],
      ),
    );
  }
}

void launchAppFeedback(context) {
  AppFeedback feedbackForm = AppFeedback.instance;
  feedbackForm.display(context,
      option: Option(
        ratringsBottomText1: 'Very bad',
        ratringsBottomText2: 'Very Good',
        ratingHeader: 'How would you rate this contractor/company?',
        maxRating: 5,
        ratingButtonTheme: RatingButtonThemeData.defaultTheme,
      ), onSubmit: (feedback) {
    print(feedback);
  });
}

String terms = '''


After signing terms and condition for using Hire app , you are abide to follow followings terms and conditions listed below

1)You cant do anything , misleading or fraudulent or for an illegal or unauthorised purposes.
\n
2)You can't impersonate others or provide inaccurate information.
\n
3)Once you hire workers , you are under legal agreement to protect workers laws as per Article 16(2).
\n
4)Action will be taken against any Negative feedback or review from workers which violets their primary rights.
\n
5)You will be permanantly banned if you involved in fraud , legal action will be taken against it if any.
\n
6)Once you hire workers , you are under legal agreement to protect workers laws as per Article 16(2).
\n
7)Once you hire workers ,you are require to pay the initial down Payment for using our services and to provide workers initial payment for their agreement.
\n
8)Once you sign in you are abide us to share and store your information so that workers may know more about your organisation.''';
