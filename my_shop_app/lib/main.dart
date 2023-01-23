
import 'package:flutter/material.dart';
import 'package:my_shop_app/screen/order_screen.dart';
import 'package:my_shop_app/screen/user_products_screen.dart';
import './Providers/cart.dart';
import './Providers/order.dart';
import './Providers/products.dart';
import './screen/Product_overview.dart';
import './screen/cart_screen.dart';
import './screen/productDetail.dart';
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
      ChangeNotifierProvider(create: (context) => Cart()),
      ChangeNotifierProvider(create: (context)=>Orders()), 
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
          // '/':(context)=>const MyHomePage(),
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartOverviewScreen.routeName:(context) => const CartOverviewScreen(),
          OrderScreen.routeName:(context) => const OrderScreen(),
          UserProducts.routeName:(context) => const UserProducts()
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
