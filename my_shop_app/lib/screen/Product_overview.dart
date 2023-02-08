import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/cart.dart';
import 'package:my_shop_app/screen/cart_screen.dart';
import 'package:my_shop_app/widget/app_drawer.dart';
// import '../widget/badge.dart';
import '../Providers/products.dart';
import '../widget/gridView_of_product.dart';
import 'package:provider/provider.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({
    super.key,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

bool _isLoading =false;

class _ProductOverviewState extends State<ProductOverview> {
  @override
  void initState() {
      setState(() {
        _isLoading = true;
      });
    // TODO: implement initState
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  var filterStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Shop"),
          actions: [
            Consumer<Cart>(
              builder: (context, cart, child) {
                return Badge(
                  label: Text(cart.itemCount.toString()),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(CartOverviewScreen.routeName);
                    },
                  ),
                );
              },
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
        body: _isLoading?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),): GridViewOfProducts(
          favFilterOn: filterStatus,
        ));
  }
}
