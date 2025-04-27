import 'package:order_app/Models/items.dart';

class CartItem{
  final Items item;
   int quantity ;
  CartItem( { required this.item, this.quantity =1,});

  double get getTotalPrice{
    return item.price * quantity;
}
}

class Item {
  final String id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});
}