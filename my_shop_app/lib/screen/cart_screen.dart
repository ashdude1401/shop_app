import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/cart.dart' show Cart;

//it only imports Cart from cart.dart

import 'package:provider/provider.dart';
import '../widget/cart_item.dart';

class CartOverviewScreen extends StatelessWidget {
  const CartOverviewScreen({super.key});
  static const routeName = './cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    //cart will listen to all the change which will happen in future

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 170, 43, 193),
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$ ${cart.totalItemPrice}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Place Order",
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          /**
           * Using a ListTile inside a Column directly can cause issues with the layout of the Column. The Column widget, by default, sizes its children based on the maximum height of the children. However, ListTile has a default height that may be larger or smaller than the maximum height of other children in the Column. This can cause the Column to be larger or smaller than expected, and can cause issues with scrolling or other layout behaviors. To avoid these issues, it is recommended to wrap the ListTile in an Expanded widget. This allows the ListTile to be sized based on the available space in the Column, and ensures that the layout of the Column is as expected.
           */
          Expanded(
            child: ListView.builder(
              //here it is important because we need first
              itemBuilder: ((context, i) => CartItem(
                  id: cart.items.values.toList()[i].id,
                  productId: cart.items.keys.toList()[i],
                  title: cart.items.values.toList()[i].title,
                  price: cart.items.values.toList()[i].price,
                  quantity: cart.items.values.toList()[i].quantity)),
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
