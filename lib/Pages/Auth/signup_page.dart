
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app/Pages/home_page.dart';
import 'package:order_app/Pages/Auth/login_page.dart';

import '../../Components/big_image.dart';
import '../../Components/normal_text_button.dart';
import '../../Components/outline_button.dart';
import '../../Components/universal_button.dart';
import '../../Services/google_services.dart';
import 'forgotpass_page.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  final GoogleServices _googleServices = GoogleServices();
  String? user;

  Future signup(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user!.uid;
    } catch (e) {
      print(e.toString());
    }
    addUserDetails(emailcontroller.text.trim(), namecontroller.text.trim());
    if(user != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomePage()));
    }

  }

  Future addUserDetails (String email , String name) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(user).set({
      'email' : email,
      'name' : name,
      'uid' : user
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 50,
              ),
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                    hintText: 'Name',
                    labelText: 'NAME',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
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
              UniversalButton(
                  onPressed: () {
                    signup(emailcontroller.text.trim(),
                        passwordcontroller.text.trim());
                  },
                  buttonText: 'SIGN UP'),
              NormalTextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                buttonText: 'Log in',
                extraText: "Already have an account?",
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

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//
//   void signup (Email,Password) async{
//     try{
//       Response response= await post(Uri.parse('https://reqres.in/api/register'),body: {
//         'email' : Email,
//         'password': Password
//       });
//       if(response.statusCode == 200){
//         print('account');
//        var data= jsonDecode(response.body.toString());
//        print(data['token']);
//       }
//     }catch(e){
//       print(e.toString());
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         title: const Text('Sign up Here'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//            const SizedBox(
//               height: 150,
//             ),
//             TextFormField(
//               controller: emailcontroller,
//               decoration: InputDecoration(
//                   hintText: 'Email',
//                   labelText: 'EMAIL',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   )),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: passwordcontroller,
//               decoration:
//                   InputDecoration(
//                     hintText: 'password',
//                     labelText: 'PASSWORD',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//                     )
//                   ),
//             ),
//             const SizedBox(
//               height: 60,
//             ),
//             GestureDetector(
//               onTap: () {
//                 signup(emailcontroller.text.toString(), passwordcontroller.text.toString());
//               },
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.06,
//                 decoration: BoxDecoration(
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.circular(10)),
//                 child:const Center(
//                   child: Text('SIGN UP'),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
