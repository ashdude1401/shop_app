import 'package:flutter/material.dart';
import '../Providers/auth.dart';
import '../screen/auth_screen.dart';
import '../screen/edit_product_screen.dart';
import '../screen/order_screen.dart';
import '../screen/user_products_screen.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Auth()),
        ChangeNotifierProvider(create: ((context) => Products())),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child:  Consumer<Auth>(builder: (context, auth, _) =>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My shop App",
        home:auth.isAuth?const ProductOverview(): const AuthScreen(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Anton',
            iconTheme: const IconThemeData(color: Colors.orange)),
        routes: {
          // '/':(context)=>const MyHomePage(),
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartOverviewScreen.routeName: (context) => const CartOverviewScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
          AuthScreen.routeName: (context) => const AuthScreen()
        },
      ), ), 
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
