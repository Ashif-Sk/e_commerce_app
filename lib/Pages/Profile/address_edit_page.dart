import 'package:flutter/material.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:provider/provider.dart';

import '../../Components/ui_components.dart';
import '../../Models/databaseModel.dart';

class AddressEditPage extends StatefulWidget {
  final Map<String, dynamic> addressData;
  final String docId;
    const AddressEditPage({super.key,required this.addressData, required this.docId});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  UiComponents uiComponents = UiComponents();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.addressData['name'];
    phoneNumberController.text = widget.addressData['number'];
    pinCodeController.text = widget.addressData['pin'];
    stateController.text = widget.addressData['State'];
    addressController.text = widget.addressData['address'];
    landmarkController.text = widget.addressData['landmark'];
    }

  @override
  void dispose() {
    nameController.dispose();
    pinCodeController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    stateController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Databasemodel>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: uiComponents.appBarText(context, 'Edit Address'),
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
                    labelText: 'Name(Required)*',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
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
                          hintText: '',
                          labelText: 'Pin(Required)*',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.emailAddress,
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
                    hintText: '',
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
                    hintText: '9647252525',
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
                database.updateAddress(
                    nameController.text,
                    phoneNumberController.text.trim(),
                    addressController.text,
                    stateController.text,
                    pinCodeController.text.trim(),
                    landmarkController.text, widget.docId);
                Navigator.of(context).pop();
              }, buttonText: "SAVE")
            ],
          )),
    );
  }
}
