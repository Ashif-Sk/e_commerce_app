import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Pages/Profile/add_address_page.dart';
import 'package:order_app/Pages/Profile/address_edit_page.dart';
import 'package:order_app/Services/database_services.dart';
import 'package:provider/provider.dart';

import '../../Components/ui_components.dart';
import '../../Models/databaseModel.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  UiComponents uiComponents = UiComponents();
  DatabaseServices databaseServices = DatabaseServices();

  // void handleClick(String value) {
  //   switch (value) {
  //     case "Edit":
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const AddressEditPage()));
  //       break;
  //     case "Remove":
  //       databaseServices.deleteAddress(_docId!);
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Databasemodel>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: uiComponents.appBarText(context, 'My Address'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: database.getAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List addressList = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = addressList[index];
                    String docId = doc.id;
                    Map<String, dynamic> addressData =
                        doc.data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      uiComponents.h1Text(
                                          context, addressData['name']),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      uiComponents.normalText(
                                          context,
                                          addressData['address'] +
                                              "; ${addressData['pin']}" +
                                              "; ${addressData['landmark']}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      uiComponents.normalText(
                                          context, addressData['number'])
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  child: PopupMenuButton<String>(
                                      iconColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onSelected: (value) {
                                        switch (value) {
                                          case "Edit":
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddressEditPage(
                                                          addressData:
                                                              addressData,
                                                          docId: docId,
                                                        )));
                                            break;
                                          case "Remove":
                                            databaseServices
                                                .deleteAddress(docId);
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return ['Edit', 'Remove']
                                            .map((String value) {
                                          return PopupMenuItem<String>(
                                              height: 30,
                                              value: value,
                                              child: Text(value));
                                        }).toList();
                                      }))
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddAddressPage())),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
