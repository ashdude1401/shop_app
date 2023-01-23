import 'package:flutter/material.dart';
import '../widget/app_drawer.dart';
import '../widget/user_product.dart';
import 'package:provider/provider.dart';
import '../Providers/products.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({super.key});

  static const routeName = '/userProducts';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      drawer:const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: ((context, i) => UserProduct(
            productTitle: productData.items[i].title,
            amount: productData.items[i].price,
            imageUrl: productData.items[i].imgUrl,
          )),
          itemCount: productData.items.length,
        ),
      ),
      // body: const Center(child: Text("Nothing to show")),
    );
  }
}
