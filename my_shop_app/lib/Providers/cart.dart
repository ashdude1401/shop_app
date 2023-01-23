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

  int get itemCount {
    return _items.length;
  }

  double get totalItemPrice {
    var total = 0.0;
    _items.forEach((productId, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      {required String productId,
      required double price,
      required String title}) {
    if (_items.containsKey(productId)) {
      //If product is already present the we just have to add 1 to the item
      _items.update(
          productId,
          (existingValue) => CartItem(
              id: existingValue.id,
              title: existingValue.title,
              quantity: existingValue.quantity + 1,
              price: existingValue.price));
      //to notifyevry widgit listening to it
    } else {
      //If product is  absent
      _items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, quantity: 1, price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void removeAddedItem(String productId) {
    //IF not present then don't do anything
    if (!_items.containsKey(productId)) {
      return;
    }

    int? quantity = _items[productId]?.quantity;
    if (quantity != null && quantity > 1) {
      //If present then check if the quantity is more then one or not

      _items.update(
          productId,
          (existingProduct) => CartItem(
              id: existingProduct.id,
              title: existingProduct.title,
              quantity: existingProduct.quantity - 1,
              price: existingProduct.price));
    } else {
      //if the quantity is one then remove the product from cart

      _items.remove(productId);
    }
    notifyListeners();
  }
}
