//to display order
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Providers/order.dart' as od;

//Making the widget stateful full its state does not effects the state of other widgets in app so it better to maintain it in statefulWidget not change notifier

class OrderItem extends StatefulWidget {
  final od.OrderItem order; 

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$ ${widget.order.amount}"),
            subtitle:
                Text(DateFormat("dd/MM/YYYY hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: (() {
                setState(() {
                  expanded = !expanded;
                });
              }),
            ),
          ),
          
          //used because there few elements so listview without buider will be usfull

          if (expanded) 
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 8),

              //To ensure that we do not have the oversize or underSize container hieght
              
              height: min(widget.order.products.length*20 +50 , 180),
              child: ListView(children: 
                widget.order.products.map((prod)=>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("\$ ${prod.title}",style:const TextStyle(color: Colors.grey),),
                        Text("${prod.quantity}X \$ ${prod.price}",style:const TextStyle(color: Colors.grey),)
                      ],
                    )
                 ).toList()
              ),
            ),
        ],
      ),
    );
  }
}
