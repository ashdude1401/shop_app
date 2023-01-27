import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String discription;
  final double price;
  final String imgUrl;
  bool isFavoraite;
  toggleFavoraite() {
    isFavoraite = !isFavoraite;
    print(isFavoraite);
    notifyListeners();
  }
  Product({
    required this.id,
    required this.title,
    required this.discription,
    required this.price,
    required this.imgUrl,
    this.isFavoraite=false, 
  });
}
