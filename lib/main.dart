import 'package:flutter/material.dart';
import 'package:navigation/inherited-widget.dart';

import 'cart.dart';
import 'inventory.dart';

class Item {
  final String name;
  final double cost;

  Item({required this.name, required this.cost});
}

final List<Item> inventory = [
  Item(name: 'Item 1', cost: 10.0),
  Item(name: 'Item 2', cost: 20.0),
  Item(name: 'Item 3', cost: 30.0),
  Item(name: 'shoe', cost: 200),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Item> _itemsInCart = [];
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
        child: ShoppingCartInheritedWidget(
          itemsInCart: _itemsInCart,
          onListChanged: (List<Item> items) =>  onCartUpdated,
          child: ListView(
            children: [
              Inventory(onCartUpdated),
              ShoppingCart(onCartUpdated),
            ],
          ),
        ),),
      ),
    );
  }

  void onCartUpdated(List<Item> items) {
    setState(() {
      _itemsInCart = items;
    });
  }
}