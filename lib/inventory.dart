import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/cart-bloc.dart';

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

class Inventory extends StatelessWidget {
const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(builder:
   (BuildContext context, ShoppingCartState state){
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ListTile(
            title: Text('Inventory'),
          ),
          const Divider(),
          ...inventory.map((item) {
            return ListTile(
              title: Text(item.name),
              subtitle: Text('\$${item.cost.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.add_circled),
                onPressed: () {
                  context.read<ShoppingCartBloc>().add(AddItemToCart(item: item));
                  print('Item added to cart: ${item.name}');
                },
              ),
            );
          }).toList(),
        ],
    );
       },
     );
  }
}
