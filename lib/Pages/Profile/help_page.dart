import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/ui_components.dart';

class HelpPage extends StatelessWidget {

  UiComponents uiComponents = UiComponents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: uiComponents.appBarText(context, 'Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  uiComponents.h1Text(context, 'Contact: skashif@gmail.com'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
