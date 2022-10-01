import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _auth = FirebaseAuth.instance;
  var user;
  bool spinner = false;
  bool obscure = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size);
            } else {
              return _buildSmallScreen(size);
            }
          },
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
  ) {
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
          child: _buildMainBody(
            size,
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
  ) {
    return Center(
      child: _buildMainBody(
        size,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
  ) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
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
                'Login',
                style: kLoginTitleStyle(size),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Welcome Back ',
                style: kLoginSubtitleStyle(size),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
                child: Column(
                  children: [
                    /// username or Gmail
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username or Gmail',
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
                      obscureText: obscure,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscure ? obscure = false : obscure = true;
                            });
                            true;
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

                    /// Login Button
                    loginButton(),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Navigate To Login Screen
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        _formKey.currentState?.reset();
                        true;
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: kHaveAnAccountStyle(size),
                          children: [
                            TextSpan(
                              text: " Sign up",
                              style: kLoginOrSignUpTextStyle(
                                size,
                              ),
                            ),
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

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient:
                LinearGradient(colors: [Color(0xFFdc4754), Color(0xFFe86d30)])),
        child: ElevatedButton(
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
            setState(() {
              spinner = true;
            });
            try {
              user = await _auth.signInWithEmailAndPassword(
                  email: nameController.text,
                  password: passwordController.text);

              if (user != null) {
                Navigator.pushNamed(context, '/entryprofile');
              }
            } catch (e) {
              print(e);
              spinner = false;
            }

            // Validate returns true if the form is valid, or false otherwise.
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
