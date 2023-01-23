import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/order_item.dart' as wd;

import '../Providers/order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderDetail = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: orderDetail.orders.isEmpty
          ? const Center(child: Text("No orders"))
          : ListView.builder(
              itemCount: orderDetail.orders.length,
              itemBuilder: ((context, i) => wd.OrderItem(
                    order: orderDetail.orders[i],
                  )),
            ),
    );
  }
}
