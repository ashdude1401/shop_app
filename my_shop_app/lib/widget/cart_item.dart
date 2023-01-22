import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key,required this.title,required this.price,required this.quantity});
  final String title;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(child: Padding(
            padding: const EdgeInsets.all(4.0),
            //to fit the text inside the circleAvatar
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(child: Text("\$ $price")),
            ),
          )),
          title: Text(title),
          subtitle: Text("Total: ${price*quantity}"),
          trailing: Text("x$quantity"),
        ),
      ),
    );
  }
}