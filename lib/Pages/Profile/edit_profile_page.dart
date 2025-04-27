import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/ui_components.dart';
import '../../Components/universal_button.dart';
import '../../Models/databaseModel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UiComponents uiComponents = UiComponents();
  Databasemodel databasemodel =Databasemodel();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    databasemodel.getUserDetails();

    super.initState();
    // final database = Provider.of<Databasemodel>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Databasemodel>(context, listen: true);
    if (database.userData != null) {
      nameController.text = database.userData!['name'] ?? '';
      phoneNumberController.text = database.userData!['number']?? '';
      pinCodeController.text = database.userData!['pin']?? '';
      stateController.text = database.userData!['state']?? '';
      emailController.text = database.userData!['email']?? '';
      genderController.text = database.userData!['gender']?? '';
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: uiComponents.appBarText(context, 'Edit Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'e.g. Jhon',
                    labelText: 'NAME',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                    hintText: '9647252525',
                    labelText: 'NUMBER',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'asdfgh234@gmail.com',
                    labelText: 'EMAIL',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                          hintText: '',
                          labelText: 'STATE',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: pinCodeController,
                      decoration: InputDecoration(
                          hintText: '700045',
                          labelText: 'PIN',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(
                    hintText: 'Male/Female/Other',
                    labelText: 'GENDER',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              UniversalButton(
                  onPressed: () {
                    database.updateUserData(
                        nameController.text,
                        phoneNumberController.text.trim(),
                        emailController.text.trim(),
                        stateController.text,
                        pinCodeController.text.trim(),
                        genderController.text.trim());
                    Navigator.of(context).pop();
                  },
                  buttonText: "SAVE"),

            ],
          )),
    );
  }
}
