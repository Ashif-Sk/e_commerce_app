import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Models/databaseModel.dart';
import 'package:order_app/Models/my_app_state.dart';
import 'package:order_app/Models/shop.dart';
import 'package:order_app/Pages/splash_page.dart';
import 'package:order_app/firebase_options.dart';
import 'package:provider/provider.dart';

import 'Theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()..loadState()),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Shop()..loadCartState()..loadWishListState(),
        ),
        ChangeNotifierProvider(
          create: (context) => Databasemodel()..getUserDetails(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashPage(),
    );
  }
}
