import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String discription;
  final double price;
  final String imgUrl;
  bool isFavoraite;
  Future<void> toggleFavoraite() async {
    bool oldStatus = isFavoraite;
    isFavoraite = !isFavoraite;
    print(isFavoraite);
    notifyListeners();
    final Uri apiUrl = Uri.parse(
        'https://shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com/products/$id');
    try {
      final response = await http.patch(apiUrl,
          body: json.encode({
            'isFavorite': isFavoraite,
          }));
      if (response.statusCode == 200) {
        print('Succefully updated favorite status');
      } else {
        print('somthing went wrong');
        isFavoraite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      print('somthing went wrong');
        isFavoraite = oldStatus;
        notifyListeners();
      print(error);
      rethrow;
    }
  }

  Product({
    required this.id,
    required this.title,
    required this.discription,
    required this.price,
    required this.imgUrl,
    this.isFavoraite = false,
  });
}
