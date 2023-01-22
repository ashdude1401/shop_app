import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = './productDetail';

  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    final product =
        Provider.of<Products>(context, listen: false).getProductById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color.fromARGB(102, 2, 2, 2),
              ),
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 30, color: Colors.orange),
                  ),
                  Text("\$ ${product.price}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 105, 105, 105))),
                  Text(
                    product.discription,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
