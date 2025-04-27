import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app/Models/cart_item.dart';

import 'items.dart';

class Shop with ChangeNotifier {
  final List<Items> _items = [
    //paddy
    Items(
      name: "Aus",
      description: "Autumn rice,grown from April to August",
      imagePath: "images/paddy/aus.jpg",
      price: 20.9,
      itemCategory: ItemCategory.paddy,
      category: 'Paddy', id: 'Aus',
    ),
    Items(
      name: "Aman",
      description: "Winter rice, sown in rainy season and harvested in winter",
      imagePath: "images/paddy/aman.jpg",
      price: 20.7,
      itemCategory: ItemCategory.paddy,
      category: 'Paddy', id: 'Aman',
    ),
    Items(
      name: "Boro",
      description: "Summer rice, grown from december to May",
      imagePath: "images/paddy/aus.jpg",
      price: 20.8,
      itemCategory: ItemCategory.paddy,
      category: 'Paddy', id: 'Boro',
    ),

    //Vegetables
    Items(
      name: "Cauliflower",
      description:
          "Cauliflower is a rich source of nutrients like fiber,calcium",
      imagePath: "images/vegetables/CauliFlower.jpg",
      price: 20.0,
      itemCategory: ItemCategory.vegetables,
      category: 'Vegetable', id: 'CauliFlower',
    ),
    Items(
      name: "Kumro",
      description: "Summer rice, grown from december to May",
      imagePath: "images/vegetables/kumro.jpg",
      price: 30.0,
      itemCategory: ItemCategory.vegetables,
      category: 'Vegetable', id: 'Kumro',
    ),
    Items(
      name: "Onion",
      description: "Summer rice, grown from december to May",
      imagePath: "images/vegetables/onion.jpg",
      price: 35.0,
      itemCategory: ItemCategory.vegetables,
      category: 'Vegetable', id: 'Onion',
    ),
    Items(
      name: "Potato",
      description: "Summer rice, grown from december to May",
      imagePath: "images/vegetables/potato.jpg",
      price: 18.0,
      itemCategory: ItemCategory.vegetables,
      category: 'Vegetable', id: 'Potato',
    ),
    Items(
      name: "Tomato",
      description: "Summer rice, grown from december to May",
      imagePath: "images/vegetables/tomato.jpg",
      price: 50.0,
      itemCategory: ItemCategory.vegetables,
      category: 'Vegetable', id: 'Tomato',
    ),

    //Fruits
    Items(
      name: "Apple",
      description: "This nutritious fruit offers multiple health benefits. Apples may lower your chance of developing cancer, diabetes, and heart disease. Research says apples may also help you lose weight while improving your gut and brain health.",
      imagePath: "images/fruits/applee.jpg",
      price: 100.0,
      itemCategory: ItemCategory.fruit,
      category: 'Fruit', id: 'Apple',
    ),
    Items(
      name: "Banana",
      description: "Summer rice, grown from december to May",
      imagePath: "images/fruits/banana.jpg",
      price: 40.0,
      itemCategory: ItemCategory.fruit,
      category: 'Fruit', id: 'Banana',
    ),
    Items(
      name: "Mango",
      description: "Summer rice, grown from december to May",
      imagePath: "images/fruits/mango.jpg",
      price: 80.0,
      itemCategory: ItemCategory.fruit,
      category: 'Fruit', id: 'Mango',
    ),

    //Seeds
    Items(
      name: "Paddy Seeds",
      description: "Summer rice, grown from december to May",
      imagePath: "images/paddy/aus.jpg",
      price: 150.0,
      itemCategory: ItemCategory.seeds,
      category: 'Seeds', id: 'paddyseeds',
    ),
    Items(
      name: "Cocumber Seeds",
      description: "Summer rice, grown from december to May",
      imagePath: "images/seeds/cocumber_seeds.jpg",
      price: 300.0,
      itemCategory: ItemCategory.seeds,
      category: 'Seeds', id: 'cocumberseeds',
    ),
    Items(
      name: "Potato Seeds",
      description: "Summer rice, grown from december to May",
      imagePath: "images/seeds/potato-seeds.webp",
      price: 35.0,
      itemCategory: ItemCategory.seeds,
      category: 'Seeds', id: 'potatoseeds',
    ),
    Items(
      name: "Kumro Seeds",
      description: "Summer rice, grown from december to May",
      imagePath: "images/seeds/squash_seed.jpg",
      price: 80.0,
      itemCategory: ItemCategory.seeds,
      category: 'Seeds', id: 'kumroseeds',
    ),
  ];

  List<CartItem> _bucket = [];

  List<WishList> _wishList = [];

  // get Items
  List<Items> get items => _items;

  List<CartItem> get bucket => _bucket;

  List<WishList> get wishList => _wishList;
  // Add to Cart
  void addToBucket(Items item) {
    final CartItem? cartItem = _bucket.firstWhereOrNull((value) {
      bool isSameItem = value.item == item;
      return isSameItem;
    });
    if (cartItem != null ) {
      cartItem.quantity++;
    } else {
      _bucket.add(CartItem(item: item));
    }
    saveCartState();
    notifyListeners();
  }

  // Remove from Cart
  void removeFromBucket(CartItem item) {
    int index = _bucket.indexOf(item);
    _bucket.removeAt(index);
    saveCartState();
    notifyListeners();
  }

  //increment quantity
  int incrementQuantity (CartItem cartItem){
    notifyListeners();
    return cartItem.quantity++;

  }

  //decrement quantity
  void decrementQuantity (CartItem cartItem){
   if(cartItem.quantity>1){
     cartItem.quantity--;
   } else {
     removeFromBucket(cartItem);
   }
   notifyListeners();
  }

  //Total Price of the bucket
  String totalPrice() {
    double total = 0.0;

    for (CartItem item in _bucket) {
      double itemTotal = item.item.price;
      total += itemTotal * item.quantity;
    }
    return total.toStringAsFixed(1);
  }

  //get total item count
  int getTotalItemsCount (){
    int itemCount;
    itemCount = 0;
    for(CartItem cartItem in _bucket){
      itemCount += cartItem.quantity;
    }
    return itemCount;
  }

  // add to wishList
  void addToWishlist (Items item){
    final WishList? wishListItem = _wishList.firstWhereOrNull((value) {
      bool isSameItem = value.item == item;
      return isSameItem;
    });

    if(wishListItem == null){
      _wishList.add(WishList(item: item));
      saveWishListState();

    } else{
      int index = _wishList.indexOf(wishListItem);
      _wishList.removeAt(index);
      saveWishListState();
    }
    notifyListeners();
  }

  bool isFavourite(Items item){
    final WishList? wishListItem = _wishList.firstWhereOrNull((value) {
      bool isSameItem = value.item == item;
      return isSameItem;
    });
    if(wishListItem == null){
     return false;
    } else{
      return true;
    }
  }


  Future<void> loadCartState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore.collection('users')
          .doc(user.uid).collection('cart').get();

      _bucket = snapshot.docs.map((doc) => CartItem(
        item: Items(
          id: doc.id,
          name: doc['name'],
          description: doc['description'],
          imagePath: doc['imagePath'],
          price: doc['price'],
          category: doc['category'],
          itemCategory: ItemCategory.values.firstWhere((element) => element.toString() == doc['itemCategory']),
        ),
        quantity: doc['quantity'], // Adjust as necessary
      )).toList();

      notifyListeners();
    }
  }

  Future<void> saveCartState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference wishlistRef = firestore.collection('users')
          .doc(user.uid).collection('cart');

      // Clear previous data
      await wishlistRef.get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      // Save current state
      for (CartItem item in _bucket) {
        await wishlistRef.doc(item.item.id).set({
          'name': item.item.name,
          'description': item.item.description,
          'imagePath': item.item.imagePath,
          'price': item.item.price,
          'category': item.item.category,
          'itemCategory': item.item.itemCategory.toString(),
          'quantity': item.quantity,
        });
      }
    }
  }

  Future<void> loadWishListState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore.collection('users')
          .doc(user.uid).collection('wishlist').get();

      _wishList = snapshot.docs.map((doc) => WishList(
        item: Items(
          id: doc.id,
          name: doc['name'],
          description: doc['description'],
          imagePath: doc['imagePath'],
          price: doc['price'],
          category: doc['category'],
          itemCategory: ItemCategory.values.firstWhere((element) => element.toString() == doc['itemCategory']),
        ),
      )).toList();

      notifyListeners();
    }
  }

  Future<void> saveWishListState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference wishlistRef = firestore.collection('users')
          .doc(user.uid).collection('wishlist');

      // Clear previous data
      await wishlistRef.get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      // Save current state
      for (WishList item in _wishList) {
        await wishlistRef.doc(item.item.id).set({
          'name': item.item.name,
          'description': item.item.description,
          'imagePath': item.item.imagePath,
          'price': item.item.price,
          'category': item.item.category,
          'itemCategory': item.item.itemCategory.toString(),
        });
      }
    }
  }
}


// List fullMenu = [
//   //Paddy
//   [{
//       "name": "Aus",
//       "price": 1200.0,
//       "description": "Autumn rice,grown from April to August",
//       "image": "images/paddyy.png"
//     },
//     {
//       "name": "Aman",
//       "price": 1000.0,
//       "description":
//           "Winter rice, sown in rainy season and harvested in winter",
//       "image": "images/paddyy.png"
//     }, {
//       "name": "Boro",
//       "price": 1500.0,
//       "description": "Summer rice, grown from december to May",
//       "image": "images/paddyy.png"
//     },
//   ],
//
//   //Vegetables
//   [
//     {
//       "name": "Brinjal",
//       "price": 25.0,
//       "description": "Brinjal is a rich source of nutrients like fiber,calcium",
//       "image": "images/paddyy.png"
//     },
//     {
//       "name": "Cauliflower",
//       "price": 30.0,
//       "description": "Cauliflower is a rich source of nutrients like fiber,calcium",
//       "image": "images/paddyy.png"
//     },
//     {
//       "name": "Tomato",
//       "price": 50.0,
//       "description": "Tomato is a rich source of nutrients like fiber,calcium",
//       "image": "images/paddyy.png"
//     },
//      {
//       "name": "Lady Finger",
//       "price": 50.0,
//       "description": "Tomato is a rich source of nutrients like fiber,calcium",
//       "image": "images/paddyy.png"
//     },
//   ]
//
// ];
