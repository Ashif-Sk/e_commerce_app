import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Components/big_image.dart';
import 'package:order_app/Components/normal_text_button.dart';
import 'package:order_app/Components/outline_button.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:order_app/Pages/Auth/signup_page.dart';
import 'package:order_app/Pages/home_page.dart';

import '../../Services/google_services.dart';
import 'forgotpass_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GoogleServices _googleServices = GoogleServices();
  String? user;

  Future signup(email, password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user!.uid;
      // addUserDetails(emailcontroller.text.trim());
    } catch (e) {
      print(e.toString());
    }

  }

  Future addUserDetails(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(user).set({'email': email, 'uid': user});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 40,
              ),
              const BigImage(imagePath: 'images/account-login.png'),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_rounded),
                    hintText: 'Email',
                    labelText: 'EMAIL',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'password',
                    labelText: 'PASSWORD',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
             NormalTextButton(onPressed:  () {
               Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => const ForgotPasswordPage()));
             },
                 buttonText: 'Forgot Password?', extraText: ''),
              const SizedBox(
                height: 10,
              ),
              UniversalButton(
                  onPressed: () {
                    signup(emailcontroller.text.trim(),
                        passwordcontroller.text.trim());
                  },
                  buttonText: 'LOG IN'),
              NormalTextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                buttonText: 'Sign Up',
                extraText: "Don't have an account?",
              ),
              const SizedBox(
                height: 20,
              ),
              BigOutlineButton(
                  onPressed: () => _googleServices.googleSignIn(),
                  buttonText: 'Continue with Google',
                  icon: Icons.g_mobiledata_rounded),
              const SizedBox(
                height: 20,
              ),
              BigOutlineButton(
                  onPressed: () {},
                  buttonText: 'Continue with Mobile',
                  icon: Icons.call)
            ],
          ),
        ),
      ),
    );
  }
}
