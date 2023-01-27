//To create order class having everything in the order in order class

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProduct, double total) {
    //.insert adds the item at the beggining of the list
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProduct),
    );
    notifyListeners();
  }
}
