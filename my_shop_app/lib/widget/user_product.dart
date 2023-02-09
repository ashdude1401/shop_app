import 'package:flutter/material.dart';
import 'package:my_shop_app/screen/edit_product_screen.dart';
import '../Providers/products.dart';
import 'package:provider/provider.dart';

class UserProduct extends StatelessWidget {
  final String productId;
  final String productTitle;
  final double amount;
  final String imageUrl;
  const UserProduct(
      {super.key,
      required this.productId,
      required this.productTitle,
      required this.amount,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(productTitle),
          subtitle: Text("\$ $amount"),
          leading: CircleAvatar(
            //It takes NetworkImage not Image.network which is a widget it is not a widget

            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: (() {
                      Navigator.pushNamed(context, EditProductScreen.routeName,
                          arguments: productId);
                    }),
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () async {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .deleteItem(productId);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Error deleting product, please try again later.'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    icon: Icon(Icons.delete,
                        color: Theme.of(context).colorScheme.error))
              ],
            ),
          )),
    );
  }
}
