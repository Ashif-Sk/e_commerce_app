import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../Components/ui_components.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                color:Theme.of(context).colorScheme.primaryContainer
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  uiComponents.h1Text(context, 'Theme'),
                  CupertinoSwitch(
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    thumbColor: Theme.of(context).colorScheme.secondary,
                      value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
                      onChanged: (_){
                        Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
