import 'package:flutter/material.dart';
import 'package:order_app/Models/items.dart';
import 'package:provider/provider.dart';

import '../Components/ui_components.dart';
import '../Models/shop.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final UiComponents uiComponents = UiComponents();
  List<WishList>? wishlistItem;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<Shop>(
      builder: (BuildContext context, shopItems, Widget? child) {
        wishlistItem = shopItems.wishList.toList() ;
        return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: uiComponents.appBarText(context, 'My Wishlist'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.88,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2),
                itemCount: wishlistItem!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             DetailsPage(item: wishlistItem![index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Positioned(
                                  child: SizedBox(
                                    height: height * 0.13,
                                    width: double.maxFinite,
                                    child: Image.asset(
                                      wishlistItem![index].item.imagePath,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          shopItems.addToWishlist(wishlistItem![index].item);
                                        },
                                        icon: Icon(
                                          shopItems.isFavourite(wishlistItem![index].item)
                                              ? Icons.favorite
                                              : Icons
                                              .favorite_outline_rounded,
                                          color: shopItems.isFavourite(wishlistItem![index].item)
                                              ? Colors.red
                                              : Colors.black,
                                          size: 25,
                                        )))
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: width * 0.27,
                                      child: Text(
                                        wishlistItem![index].item.name,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: wishlistItem![index].item.price.toString(),
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
                                GestureDetector(
                                  onTap: () {
                                    shopItems.addToBucket(wishlistItem![index].item);
                                  },
                                  child: Container(
                                    height: height * 0.035,
                                    width: width * 0.067,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                        BorderRadius.circular(5)),
                                    child: const Icon(
                                      Icons.shopping_cart_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
        );
      },);
  }
}
