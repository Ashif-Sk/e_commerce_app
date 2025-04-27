import 'dart:async';

import 'package:flutter/material.dart';
import 'package:order_app/Components/ui_components.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:order_app/Pages/Auth/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    });
  }

  final uiComponents = UiComponents();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.08,
            ),
            Center(
                child:
                    uiComponents.titleText(context, 'Fresh Farm\n  Products')),
            SizedBox(
              height: height * 0.03,
            ),
            CircleAvatar(
              backgroundImage: const AssetImage('images/splashImage.png'),
              radius: width * 0.47,
            ),
            const Spacer(),
            UniversalButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                buttonText: "Let's Order")
          ],
        ),
      ),
    );
  }
}
