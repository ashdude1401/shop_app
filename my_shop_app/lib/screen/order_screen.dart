import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/order_item.dart' as wd;

import '../Providers/order.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final orderDetail=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title:const Text("Orders"),),
      body:ListView.builder(itemBuilder: ((context, i) =>wd.OrderItem(amount: orderDetail.orders[i].amount,dateTime: orderDetail.orders[i].dateTime,)))
    );
  }
}