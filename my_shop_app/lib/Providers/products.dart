import 'package:flutter/cupertino.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _productItems = [
    Product(
      id: 'p1',
      title: 'Jeans',
      discription: 'Black Levi jeans',
      price: 800,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p2',
      title: 'scaff',
      discription: 'Yellow stylish scaff',
      price: 29.99,
      imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Red Shirt',
      discription: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Fry Pan',
      discription: 'Bakalite stcik proof pan',
      price: 400,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  List<Product> get items {
    return [..._productItems];
  }

  List<Product> get favItems {
    return _productItems.where((ele) => ele.isFavoraite == true).toList();
  }

  Product getProductById(requiredId) {
    return _productItems.firstWhere((item) => item.id == requiredId);
  }

  void addItem(Product product) {
    //The product we got does not have id set ,so we can not directly add it to the _productItems list ,so we have to add create a new product and add set unique ID

    Product newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        discription: product.discription,
        price: product.price,
        imgUrl: product.imgUrl,
        );

    _productItems.add(newProduct);
    notifyListeners();
  }
}
