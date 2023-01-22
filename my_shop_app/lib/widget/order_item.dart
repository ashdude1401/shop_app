//to display order



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
 

  final double amount;
  final DateTime dateTime;

   const OrderItem({super.key,required this.amount,required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$ $amount"),
            subtitle: Text(DateFormat("dd MM YYYY hh:mm").format(dateTime)),
          )
        ],
      ),
    );
  }
}
