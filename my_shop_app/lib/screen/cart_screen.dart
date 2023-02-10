import 'package:flutter/material.dart';
import '../Providers/cart.dart' show Cart;

//it only imports Cart from cart.dart

import 'package:provider/provider.dart';
import '../widget/cart_item.dart';
import '../Providers/order.dart';

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
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:( widget.cart.totalItemPrice <= 0||_isLoading)
            ? null
            : () async {
                try {
                  setState(() {
                    _isLoading = true;
                  });
                  await Provider.of<Orders>(context, listen: false).addOrder(
                      widget.cart.items.values.toList(),
                      widget.cart.totalItemPrice);
                  setState(() {
                    _isLoading = false;
                  });
                  widget.cart.clear();
                } catch (error) {
                  print('somthing went wrong will adding to cart');
                }
              },
        child: _isLoading?Center(child: const CircularProgressIndicator()) :const Text(
          "Place Order",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ));
  }
}
