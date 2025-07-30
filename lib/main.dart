import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cart-bloc.dart';
import 'cart.dart';
import 'inventory.dart';

void main() {
  runApp(
      BlocProvider(
        create: (create) => ShoppingCartBloc(),
        child: MyApp(),
      ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Item> _itemsInCart = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ecommerce'),
        ),
        body: Padding(padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: const[
              Inventory(),
              ShoppingCart(),
            ],
          ),
        ),
      ),
    );
  }

// void onCartUpdated(List<Item> items) {
//   setState(() {
//     _itemsInCart = items;
//   });
// }
}