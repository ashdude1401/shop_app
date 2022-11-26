import 'package:flutter/material.dart';
import '../widget/gridView_of_product.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({
    super.key,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var filterStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Shop"),
          actions: [
            PopupMenuButton(
              itemBuilder: ((context) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: Text(
                      "only Favoraite",
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                  ),
                  const PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Show All",
                        style: TextStyle(fontFamily: 'Lato'),
                      )),
                ];
              }),
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                setState(() {
                  if (value == 0) {
                    filterStatus = true;
                  } else {
                    filterStatus = false;
                  }
                });
              },
            )
          ],
        ),
        body: GridViewOfProducts(
          favFilterOn: filterStatus,
        ));
  }
}
