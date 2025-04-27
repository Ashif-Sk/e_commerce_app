import 'package:flutter/material.dart';

import '../Models/shop.dart';
import '../Pages/details_page.dart';

class ItemBuilder extends StatelessWidget {
  final List<dynamic> items;
  final Shop shopItems;

  const ItemBuilder({super.key,required this.items, required this.shopItems});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.88,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailsPage(item: items[index])));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
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
                              items[index].imagePath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: IconButton(
                                onPressed: () {
                                  shopItems.addToWishlist(items[index]);
                                },
                                icon: Icon(
                                  shopItems.isFavourite(items[index])
                                      ? Icons.favorite
                                      : Icons
                                      .favorite_outline_rounded,
                                  color: shopItems.isFavourite(items[index])
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
                                items[index].name,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: items[index].price.toString(),
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
                            shopItems.addToBucket(items[index]);
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
        });;
  }
}
