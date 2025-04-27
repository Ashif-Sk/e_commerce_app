import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Components/reusable_listile.dart';
import 'package:order_app/Models/databaseModel.dart';
import 'package:order_app/Pages/Profile/address_page.dart';
import 'package:order_app/Pages/Profile/help_page.dart';
import 'package:order_app/Pages/Profile/settings_page.dart';
import 'package:order_app/Pages/Profile/edit_profile_page.dart';
import 'package:provider/provider.dart';

import '../Components/ui_components.dart';
import 'Auth/main_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UiComponents uiComponents = UiComponents();
  Databasemodel databasemodel =Databasemodel();

  //Map<String, dynamic>? userData;

  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (Route<dynamic> route) => false,
      );
    });
  }


  @override
  void initState() {
    databasemodel.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Databasemodel>(context,listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: uiComponents.appBarText(context, 'My Account'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 30,
          ),
           CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 50,
            child: const Icon(
              Icons.person,
              size: 70,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: userData.userData != null
                  ? uiComponents.h1Text(context, userData.userData!['name'])
                  : const CircularProgressIndicator()),
          const SizedBox(
            height: 30,
          ),
          ReusableListile(
              text: "Edit Profile",
              leadingIcon: Icons.edit,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage())),
              trailingIcon: Icons.navigate_next),
          ReusableListile(
              text: "My Orders",
              leadingIcon: Icons.shopping_bag,
              onTap: () {},
              trailingIcon: Icons.navigate_next),
          ReusableListile(
              text: "Address",
              leadingIcon: Icons.location_on,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddressPage())),
              trailingIcon: Icons.navigate_next),
          ReusableListile(
              text: "Shipping",
              leadingIcon: Icons.directions_bus,
              onTap: () {},
              trailingIcon: Icons.navigate_next),
          ReusableListile(
              text: "Help & Support",
              leadingIcon: Icons.headphones,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HelpPage())),
              trailingIcon: Icons.navigate_next),
          ReusableListile(
              text: "Settings",
              leadingIcon: Icons.settings,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              trailingIcon: Icons.navigate_next),
          ReusableListile(
              text: "Log Out",
              leadingIcon: Icons.exit_to_app_rounded,
              onTap: () {
                signOut(context);
              },
              trailingIcon: Icons.navigate_next),
        ],
      ),
    );
  }
}
