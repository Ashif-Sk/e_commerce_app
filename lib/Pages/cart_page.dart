import 'package:flutter/material.dart';
import 'package:order_app/Models/cart_item.dart';
import 'package:order_app/Models/shop.dart';
import 'package:provider/provider.dart';

import '../Components/ui_components.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final UiComponents uiComponents = UiComponents();
  List<CartItem>? bucketItem;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<Shop>(
      builder: (BuildContext context, value, Widget? child) {
        bucketItem = value.bucket.toList();
        return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: uiComponents.appBarText(context, 'My Bucket'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body:Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                      itemCount: value.bucket.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: height * 0.137,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: width*0.25,
                                      height: double.maxFinite,
                                      child: Image.asset(bucketItem![index].item.imagePath,fit: BoxFit.fill,)),
                                  const SizedBox( width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        bucketItem![index].item.name,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        bucketItem![index].item.category,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: "Rs.${bucketItem![index].item.price}",
                                          style: const TextStyle(
                                              color: Colors.teal,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const TextSpan(
                                          text: "/kg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ]))
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            value.removeFromBucket(bucketItem![index]);
                                          },
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.red,
                                            size: 30,
                                          )),
                                      const Spacer(),
                                      SizedBox(
                                        width: width * 0.19,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                value.decrementQuantity(bucketItem![index]);
                                              },
                                              child: Container(
                                                height: height * 0.028,
                                                width: width * 0.058,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            uiComponents.h1Text(context, bucketItem![index].quantity.toString()),
                                            GestureDetector(
                                              onTap: (){
                                                value.incrementQuantity(bucketItem![index]);
                                              },
                                              child: Container(
                                                height: height * 0.03,
                                                width: width * 0.06,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: height*0.08,
                  width: double.maxFinite,
                  decoration:  BoxDecoration(
                  color:Theme.of(context).colorScheme.primaryContainer
                ),
                  child: Row(
                    children: [
                      const Text(
                        "Total:",
                        style:  TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ) ,),
                      const SizedBox(width: 5,),
                      Text(
                        "Rs.${value.totalPrice()}",
                        style:  TextStyle(
                          overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary
                        ) ,),
                      const Spacer(),
                      MaterialButton(
                        minWidth: width * 0.3,
                        height: 40,
                        elevation: 1,
                        onPressed: (){},
                        shape: const StadiumBorder(),
                        color: Theme.of(context).colorScheme.secondary,
                      child: const Text(
                        "Checkout",
                        style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                        ) ,),)
                    ],
                  ),
                ),
                const SizedBox(height: 5,)
              ],
            ),
        );
      },
    );

  }
}
