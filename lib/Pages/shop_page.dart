import 'package:flutter/material.dart';
import 'package:order_app/Components/catagory_button.dart';
import 'package:order_app/Components/ui_components.dart';
import 'package:order_app/Models/shop.dart';
import 'package:order_app/Pages/category_page.dart';
import 'package:order_app/Pages/details_page.dart';
import 'package:provider/provider.dart';

import '../Models/items.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  UiComponents uiComponents = UiComponents();
  TextEditingController searchController = TextEditingController();
  List<Items> items = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: uiComponents.appBarText(context, 'Welcome'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded),
                    hintText: 'Search what do you want?',
                    // labelText: 'EMAIL',
                    border: InputBorder.none,
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'images/OIP.jpg',
                fit: BoxFit.fill,
                height: height * 0.2,
                width: double.maxFinite,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            uiComponents.h1Text(context, "Categories"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  color: Colors.green.shade50,
                  image: "images/paddyy.png",
                  text: "Paddy",
                  imageColor: Colors.green.shade900,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                              category: ItemCategory.paddy))),
                ),
                // const SizedBox(width: 20,),
                CategoryButton(
                  color: Colors.red.shade50,
                  image: "images/fruit.png",
                  text: "Fruit",
                  imageColor: Colors.red.shade800,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                              category: ItemCategory.fruit))),
                ),
                // const SizedBox(width: 20,),
                CategoryButton(
                  color: Colors.yellow.shade50,
                  image: "images/vegetables.png",
                  text: "Veg",
                  imageColor: Colors.amber.shade900,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                              category: ItemCategory.vegetables))),
                ),
                // const SizedBox(width: 20,),
                CategoryButton(
                  color: Colors.blue.shade50,
                  image: "images/seed.png",
                  text: "Seeds",
                  imageColor: Colors.blue.shade800,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryPage(
                              category: ItemCategory.seeds))),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            uiComponents.h1Text(context, "Items"),
            const SizedBox(
              height: 20,
            ),
            Consumer<Shop>(
              builder: (BuildContext context, shopItems, Widget? child) {
                items = shopItems.items.toList();
                return GridView.builder(
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
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
