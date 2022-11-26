import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = './productDetail';
  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    final product = Provider.of<Products>(context,listen: false).getProductById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
    );
  }
}
