import 'package:flutter/material.dart';
import 'package:my_shop_app/screen/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello Friend!"),

            //to remove leading space

            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.shop),
              title: const Text("Shop"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          const Divider(),
          ListTile(
            title: const Text("Order"),
            leading: const Icon(Icons.payment),
            onTap: (() {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            }),
          )
        ],
      ),
    );
  }
}
