import 'package:flutter/material.dart';
import '../Components/ui_components.dart';
import '../Models/items.dart';
import '../Models/shop.dart';
import 'details_page.dart';

class CategoryPage extends StatefulWidget {
  final ItemCategory category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  UiComponents uiComponents = UiComponents();
  List<Items> categoryItems =[];
  @override
  void initState() {
    Shop shop =Shop();
    categoryItems = _filterItemByCategory(widget.category ,shop.items);
    super.initState();
  }
  List<Items> _filterItemByCategory(ItemCategory category ,List<Items> fullItems){
    return fullItems.where((item)=>item.itemCategory == category).toList();
  }
  Shop shop =Shop();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor:Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          title: uiComponents.appBarText(context, 'Category'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.orangeAccent,
                ))
          ],
        ),
      body:GridView.builder(
        padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.88,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2),
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>DetailsPage(item: categoryItems[index])));
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
                      SizedBox(
                        height: height * 0.13,
                        width: double.maxFinite,
                        child: Image.asset(
                          categoryItems[index].imagePath,
                          fit: BoxFit.fill,
                        ),
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
                                width: width*0.27,
                                child: Text(
                                  categoryItems[index].name,

                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: categoryItems[index].price.toString(),
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
                            onTap: (){
                              shop.addToBucket(categoryItems[index]);
                            },
                            child: Container(
                              height: height * 0.035,
                              width: width * 0.067,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(5)),
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
  }
}
