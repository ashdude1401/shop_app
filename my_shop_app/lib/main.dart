
import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/cart.dart';
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

    //Setting up the Multiple provider as now there are two object data which is required at many places setting up here because it is the top most class 

    return MultiProvider(providers:[
      ChangeNotifierProvider(
      create: ((context) => Products())),
      ChangeNotifierProvider(create: (context) => Cart(),) 
    ] ,
    
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
