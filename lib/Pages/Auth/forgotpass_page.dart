import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:order_app/Pages/Auth/login_page.dart';

import '../../Components/big_image.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailcontroller = TextEditingController();

  Future passwordReset(BuildContext context) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(context: context,
          builder: (context){
        return const AlertDialog(
          content: Text('Password reset link sent,check your email'),

        );

      });
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        // title: const Text('Forgot Password?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const BigImage(imagePath: 'images/key.png'),
            const SizedBox(height: 40,),
             Text('Enter your Email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary
              ),),
            const SizedBox(height: 20,),
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_rounded),
                  hintText: 'Email',
                  labelText: 'EMAIL',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30,),
           UniversalButton(onPressed: ()=>passwordReset(context),
               buttonText: 'RESET PASSWORD')
          ],
        ),
      ),
    );
  }
}
