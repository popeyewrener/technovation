import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:lottie/lottie.dart';

import 'login1.dart';
import '../constants.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var _googleSignIn;
  bool spinner = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, theme);
              } else {
                return _buildSmallScreen(size, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(Size size, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 0,
            child: Lottie.asset(
              'assets/loginfile1.json',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(Size size, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(Size size, ThemeData theme) {
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: size.width > 600
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            size.width > 600
                ? Container()
                : Lottie.asset(
                    'assets/wave.json',
                    height: size.height * 0.2,
                    width: size.width,
                    fit: BoxFit.fill,
                  ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Sign Up',
                style: kLoginTitleStyle(size),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Create Account',
                style: kLoginSubtitleStyle(size),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// username
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),

                      controller: nameController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        } else if (value.length < 4) {
                          return 'at least enter 4 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// Gmail
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_rounded),
                        hintText: 'gmail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter gmail';
                        } else if (!value.endsWith('@gmail.com')) {
                          return 'please enter valid gmail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// password
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            true ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            ;
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 6) {
                          return 'at least enter 6 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                      style: kLoginTermsAndPrivacyStyle(size),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// SignUp Button
                    signUpButton(theme),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Navigate To Login Screen
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        _formKey.currentState?.reset();

                        true;
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: kHaveAnAccountStyle(size),
                          children: [
                            TextSpan(
                                mouseCursor: MouseCursor.defer,
                                text: " Login",
                                style: kLoginOrSignUpTextStyle(size)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient:
                LinearGradient(colors: [Color(0xFFdc4754), Color(0xFFe86d30)])),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: () async {
            try {
              final newuser = await _auth.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
              if (newuser != null) {
                Navigator.pushNamed(context, '/choice');
              }
            } catch (e) {
              print(e);
              setState(() {
                spinner = false;
              });
            }
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              // ... Navigate To your Home Page
            }
          },
          child: const Text(
            'Sign up',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
