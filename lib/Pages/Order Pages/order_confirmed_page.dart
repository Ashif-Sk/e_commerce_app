import 'package:flutter/material.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:order_app/Pages/home_page.dart';

import '../../Components/ui_components.dart';

class OrderConfirmedPage extends StatefulWidget {
  const OrderConfirmedPage({super.key});

  @override
  State<OrderConfirmedPage> createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage> {
  UiComponents uiComponents = UiComponents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: uiComponents.appBarText(context, ''),
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
             SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            Image.asset('images/confirmed.png',),
            const SizedBox(height: 30,),
            uiComponents.h1Text(context, "**Your Order Will\n    reach you soon**"),
            const Spacer(),
            UniversalButton(onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
              );
            },
                buttonText: "HomePage")
          ],
        ),
      ),
    );
  }
}
