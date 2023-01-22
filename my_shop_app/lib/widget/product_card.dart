import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/cart.dart';
import 'package:my_shop_app/screen/productDetail.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    onPress(context) {
      Navigator.of(context)
          .pushNamed(ProductDetail.routeName, arguments: productItem.id);
    }

    final boxDecoration = BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(29, 158, 158, 158),
      ),
      boxShadow: const [
        BoxShadow(
          blurRadius: 20,
          spreadRadius: 5,
          color: Color.fromARGB(184, 180, 180, 180),
        ),
      ],
      borderRadius: BorderRadius.circular(20),
    );
    final gridTileBar = GridTileBar(
      backgroundColor: Colors.black87,
      leading: Consumer<Product>(
        builder: ((context, productItem, _) => IconButton(
              icon: Icon(
                productItem.isFavoraite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.orange,
              ),
              onPressed: () => productItem.toggleFavoraite(),
            )),
      ),
      title: Text(
        productItem.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () {
          cart.addItem(
              productId: productItem.id,
              price: productItem.price,
              title: productItem.title);
        },
      ),
    );
    final gridTile = GridTile(
      footer: gridTileBar,
      child: GestureDetector(
        onTap: () => onPress(context),
        child: Image.network(
          productItem.imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Container(
      decoration: boxDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: gridTile,
      ),
    );
  }
}
