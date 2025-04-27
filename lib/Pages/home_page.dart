import 'package:flutter/material.dart';
import 'package:order_app/Components/ui_components.dart';
import 'package:order_app/Models/my_app_state.dart';
import 'package:order_app/Models/shop.dart';
import 'package:order_app/Pages/cart_page.dart';
import 'package:order_app/Pages/profile_page.dart';
import 'package:order_app/Pages/shop_page.dart';
import 'package:order_app/Pages/wishlist_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UiComponents uiComponents = UiComponents();
  int _selectedIndex = 0;
    final List<Widget> _pages = <Widget>[
    const ShopPage(),
    const CartPage(),
    const WishlistPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: Theme.of(context).colorScheme.primary,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Provider.of<MyAppState>(context,listen: false).saveCurrentIndex(index);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    activeIcon: Icon(Icons.shopping_bag),
                    label: "Shop"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    activeIcon: Icon(Icons.shopping_cart_rounded),
                    label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline),
                    activeIcon: Icon(Icons.favorite_outlined),
                    label: "WishList"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded),
                    activeIcon: Icon(Icons.person),
                    label: "You"),
              ]),
        ),
        body:_pages[_selectedIndex]
    );
  }
}
