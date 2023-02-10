import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/order_item.dart' as wd;

import '../Providers/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    try {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .fectchAndSetOrders()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      super.initState();
    } catch (error) {
      print('Enable to fetch from server');
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderDetail = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: orderDetail.orders.isEmpty
          ? const Center(child: Text("No orders"))
          :_isLoading?const Center(child: CircularProgressIndicator()): ListView.builder(
              itemCount: orderDetail.orders.length,
              itemBuilder: ((context, i) => wd.OrderItem(
                    order: orderDetail.orders[i],
                  )),
            ),
    );
  }
}
