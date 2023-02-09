import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'product.dart';
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _productItems = [
    // Product(
    //   id: 'p1',
    //   title: 'Jeans',
    //   discription: 'Black Levi jeans',
    //   price: 800,
    //   imgUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'scaff',
    //   discription: 'Yellow stylish scaff',
    //   price: 29.99,
    //   imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Red Shirt',
    //   discription: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imgUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Fry Pan',
    //   discription: 'Bakalite stcik proof pan',
    //   price: 400,
    //   imgUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
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

  //The product we got does not have id set ,so we can not directly add it to the _productItems list ,so we have to add create a new product and add set unique ID

  //now I want to store the data in local memory as well as in cloud

  Future<void> addItem(Product product) async {
    final url = Uri.https(
        'shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com',
        '/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'discription': product.discription,
            'price': product.price,
            'imgUrl': product.imgUrl,
            'isFavorite': product.isFavoraite,
          }));

      Product newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        discription: product.discription,
        price: product.price,
        imgUrl: product.imgUrl,
      );
      _productItems.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchAndSetProducts() async {
    final Uri apiUrl = Uri.parse(
        'https://shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com/products.json');

    try {
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body) as Map<String, dynamic>;
        final List<Product> loadedProducts = [];
        extractedData.forEach(
          (prodId, prodData) {
            loadedProducts.add(Product(
                id: prodId,
                title: prodData['title'],
                discription: prodData['discription'],
                price: prodData['price'],
                imgUrl: prodData['imgUrl'],
                isFavoraite: prodData['isFavorite']));
          },
        );
        _productItems = loadedProducts;
        notifyListeners();
        print(extractedData);
        // Use the data as needed in your app
      } else {
        // Handle error cases
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateItem(String id, Product newProduct) async {
    final idx = _productItems.indexWhere((element) => element.id == id);
    if (idx >= 0) {
      final Uri apiUrl = Uri.parse(
          'https://shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com/products/$id.json');
      try {
        final response = await http.patch(apiUrl,
            body: json.encode({
              'discription': newProduct.discription,
              'imgUrl': newProduct.imgUrl,
              'price': newProduct.price,
              'title': newProduct.title
            }));

        if (response.statusCode == 200) {
          print('Update was successful');
        } else {
          throw Exception(
              'Update failed with status code ${response.statusCode}');
        }
        _productItems[idx] = newProduct;
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      throw Exception('Item with id $id not found');
    }
  }

  Future<void> deleteItem(String id) async {
    final int idx = _productItems.indexWhere((element) => element.id == id);
    if (idx >= 0) {
      final deletedProduct = _productItems[idx];
      _productItems.removeAt(idx);
      notifyListeners();
      final Uri apiUrl = Uri.parse(
          'https://shopping-app-tutorial-18ffb-default-rtdb.firebaseio.com/products/$id.json');
      try {
        final response = await http.delete(apiUrl);
        if (response.statusCode >= 400) {
          throw Exception('Error deleting product from Firebase');
        }
        print('Product deleted from Firebase successfully.');
      } catch (error) {
        _productItems.insert(idx, deletedProduct);
        notifyListeners();
        print(
            'Error deleting product from Firebase. Product was restored. Error: $error');
        rethrow;
      }
    } else {
      print('Product not found in the list');
    }
  }
}
