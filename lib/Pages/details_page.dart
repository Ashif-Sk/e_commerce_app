import 'package:flutter/material.dart';
import 'package:order_app/Components/outline_button.dart';
import 'package:order_app/Components/ui_components.dart';
import 'package:order_app/Components/universal_button.dart';
import 'package:order_app/Pages/Order%20Pages/payment_page.dart';
import 'package:provider/provider.dart';

import '../Models/items.dart';
import '../Models/shop.dart';

class DetailsPage extends StatefulWidget {
  final Items item;
  const DetailsPage({super.key, required this.item});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  UiComponents uiComponents = UiComponents();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: uiComponents.appBarText(context, widget.item.category),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.orangeAccent,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: ListView(
          children: [
            Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: height * 0.37,
                    width: double.maxFinite,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Image.asset(widget.item.imagePath,
                          fit: BoxFit.scaleDown),
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          Provider.of<Shop>(context,listen: false).addToWishlist(widget.item);
                        },
                        icon: Icon(
                          Provider.of<Shop>(context,listen: true).isFavourite(widget.item)
                              ? Icons.favorite
                              : Icons
                              .favorite_outline_rounded,
                          color: Provider.of<Shop>(context,listen: true).isFavourite(widget.item)
                              ? Colors.red
                              : Colors.black,
                          size: 25,
                        )))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                uiComponents.h1Text(context, widget.item.name),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Rs${widget.item.price}',
                      style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(
                      text: "/kg",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BigOutlineButton(
                onPressed: () {
                  Provider.of<Shop>(context,listen: false).addToBucket(widget.item);
                },
                buttonText: 'Add to cart',
                icon: Icons.shopping_cart),
            const SizedBox(
              height: 20,
            ),
            UniversalButton(onPressed: ()  =>Navigator.push(context, MaterialPageRoute(
                builder: (context)=>  const PaymentPage())),buttonText: 'Buy now'),
            const SizedBox(
              height: 20,
            ),
            uiComponents.h1Text(context, 'Description:'),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.item.description,
              style: const TextStyle(
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
