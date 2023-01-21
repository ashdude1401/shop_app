import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //If product is already present the we just have to add 1 to the item
      items.update(productId, (existingValue) =>CartItem(id: existingValue.id, title:existingValue.title, quantity: existingValue.quantity + 1, price:existingValue.price) );
    } else {
      //If product is  absent
      items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, quantity: 1, price: price));
    }
  }
}
