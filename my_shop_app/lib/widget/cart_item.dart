import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity});
  final String title;
  final double price;
  final int quantity;
  final String productId;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      /**
       * In the Dismissible widget, the key is used as an identifier for the widget. This is important because when the widget is swiped to be dismissed, the framework needs to know which widget to remove from the tree. Additionally, keys provide a way to identify a widget during the build process and to associate a widget with a unique string identifier.
       */
      key: ValueKey(id),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(18.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      //Alowing deleting the tile in only one direction

      direction: DismissDirection.endToStart,

      //Adding same padding and margin so that it cover the whole ListTile

      onDismissed: (direction) {
        //remove the item from the cart and update the cart Amount

        Provider.of<Cart>(context, listen: false).removeItem(productId);

        //Here we required the cart productId data only to pass it into removeItem so that we can remove that from cart and update the other accordingly
      },
      confirmDismiss: (direction) {
        //showDialog box show a dialog box and return a future object which return bool value

        return showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: const Text("Are you sure ?"),
                  content:
                      const Text("You want to remove the item from the cart"),
                  actions: [
                    TextButton(
                      onPressed: (() => Navigator.of(context).pop(true)),
                      child: const Text("YES"),
                    ),
                    TextButton(
                      onPressed: (() => Navigator.of(context).pop(false)),
                      child: const Text("NO"),
                    )
                  ],
                )));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(4.0),

              //to fit the text inside the circleAvatar

              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(child: Text("\$ $price")),
              ),
            )),
            title: Text(title),
            subtitle: Text("Total: ${price * quantity}"),
            trailing: Text("x$quantity"),
          ),
        ),
      ),
    );
  }
}
