import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/products.dart';
import '../widget/product_card.dart';
import 'package:provider/provider.dart';

class GridViewOfProducts extends StatelessWidget {
  final bool favFilterOn;
  const GridViewOfProducts({
    Key? key,
    required this.favFilterOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productList =
        favFilterOn == true ? productData.favItems : productData.items;
    print(productList);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 5),
      itemBuilder: ((ctx, idx) {
        return ChangeNotifierProvider.value(
          value: productList[idx],
          child: const ProductCard(),
        );
      }),
      itemCount: productList.length,
    );
  }
}
