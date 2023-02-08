import 'package:flutter/material.dart';
import '../widget/app_drawer.dart';
import '../widget/user_product.dart';
import 'package:provider/provider.dart';
import '../Providers/products.dart';
import '../screen/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  static const routeName = '/userProducts';
  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: ((context, i) => UserProduct(
                  productId: productData.items[i].id,
                  productTitle: productData.items[i].title,
                  amount: productData.items[i].price,
                  imageUrl: productData.items[i].imgUrl,
                )),
            itemCount: productData.items.length,
          ),
        ),
      ),
      // body: const Center(child: Text("Nothing to show")),
    );
  }
}
