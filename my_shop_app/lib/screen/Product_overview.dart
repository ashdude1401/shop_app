import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/cart.dart';
import 'package:my_shop_app/screen/cart_screen.dart';
import 'package:my_shop_app/widget/app_drawer.dart';
import '../widget/badge.dart';
import '../widget/gridView_of_product.dart';
import 'package:provider/provider.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({
    super.key,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var filterStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Shop"),
          actions: [
            Consumer<Cart>(
              builder: (context, cart, child) =>
                  Badge(value: cart.itemCount.toString(), child: child!),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pushNamed(CartOverviewScreen.routeName);
                },
              ),
            ),
            PopupMenuButton(
              itemBuilder: ((context) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: Text(
                      "only Favoraite",
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Show All",
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                  ),
                ];
              }),
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                setState(() {
                  if (value == 0) {
                    filterStatus = true;
                  } else {
                    filterStatus = false;
                  }
                });
              },
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: GridViewOfProducts(
          favFilterOn: filterStatus,
        ));
  }
}
