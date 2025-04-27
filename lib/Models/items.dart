class Items {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final String category;
  final ItemCategory itemCategory;

  Items({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.itemCategory,
  });
}

enum ItemCategory { paddy, vegetables, fruit, seeds }

class WishList {
  final Items item;
  WishList( { required this.item,});
}