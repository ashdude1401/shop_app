//To create order class having everything in the order in order class
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fectchAndSetOrders() async {
    final Uri apiUrl = Uri.parse(
        'https://shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com/orders.json');
    try {
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final List<OrderItem> loadedOrderItemList = [];
        var extractedOrderItemList =
            json.decode(response.body) as Map<String, dynamic>;
        extractedOrderItemList.forEach((orderId, orderData) {
          loadedOrderItemList.add(OrderItem(
              id: orderId,
              amount: orderData['amount'],
              products: (orderData['products'] as List<dynamic>)
                  .map((ci) => CartItem(
                        id: ci['id'],
                        title: ci['title'],
                        quantity: ci['quantity'],
                        price: ci['price'],
                      ))
                  .toList(),
              dateTime: DateTime.parse(orderData['dateTime'])));
        });
        _orders = loadedOrderItemList.reversed.toList();
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    //.insert adds the item at the beggining of the list
    final timeStamp = DateTime.now();
    final Uri apiUrl = Uri.parse(
        'https://shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.post(apiUrl,
          body: json.encode({
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProduct
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));

      _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartProduct),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      print('Enable to add orders ');
    }
  }
}
