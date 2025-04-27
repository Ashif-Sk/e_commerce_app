import 'package:flutter/material.dart';
import 'package:order_app/Models/databaseModel.dart';
import 'package:provider/provider.dart';

import '../../Components/ui_components.dart';
import '../../Components/universal_button.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  UiComponents uiComponents = UiComponents();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Databasemodel>(context,listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: uiComponents.appBarText(context, 'New Address'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'e.g. Jhon',
                    labelText: 'Name(Required)*',
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
                    labelText: 'Phone number(Required)*',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                          hintText: 'e.g. West Bengal',
                          labelText: 'State(Required)*',
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
                          hintText: '700025',
                          labelText: 'Pin(Required)*',
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
                controller: addressController,
                decoration: InputDecoration(
                    hintText: 'Your full address',
                    labelText: 'Address(Required)*',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: landmarkController,
                decoration: InputDecoration(
                    hintText: 'Nearby famous place',
                    labelText: 'Landmark(Required)*',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              UniversalButton(onPressed: (){
                database.addNewAddress(
                    nameController.text,
                    phoneNumberController.text.trim(),
                    addressController.text,
                    stateController.text,
                    pinCodeController.text.trim(),
                    landmarkController.text);
                Navigator.of(context).pop();
              }, buttonText: "SAVE")
            ],
          )),
    );
  }
}
