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
  Future?  _orderFuture;
  @override
  void initState() {
    // TODO: implement initState
    _orderFuture=Provider.of<Orders>(context, listen: false).fectchAndSetOrders() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        body: FutureBuilder(
          future:_orderFuture,
              
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.error != null) {
              //Error handling
              return const Text('AN ERROR OCCURED!');
            } else {
              return Consumer<Orders>(
                builder: (context, orderDetail, child) {
                  return ListView.builder(
                    itemCount: orderDetail.orders.length,
                    itemBuilder: ((context, i) => wd.OrderItem(
                          order: orderDetail.orders[i],
                        )),
                  );
                },
              );
            }
          },
        ));
  }
}
