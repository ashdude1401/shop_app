import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_shop_app/Providers/products.dart';
import 'package:my_shop_app/screen/Product_overview.dart';
import 'package:my_shop_app/screen/productDetail.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(const MyShopApp());
}

class MyShopApp extends StatelessWidget {
  const MyShopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => Products()),
      //New instance of Products
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My shop App",
        home: const MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Anton',
            iconTheme: const IconThemeData(color: Colors.orange)),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductOverview();
  }
}
