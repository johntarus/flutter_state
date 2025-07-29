import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/main.dart';

import 'inherited-widget.dart';

class ShoppingCart extends StatelessWidget {
  final void Function(List<Item> items) onCartUpdated;

  const ShoppingCart(this.onCartUpdated, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> currentCart = List.from(
      ShoppingCartInheritedWidget.of(context)!.itemsInCart,
    );
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          title: const Text('Shopping Cart'),
          trailing: IconButton(
            icon: const Icon(CupertinoIcons.cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ),
        const Divider(),
        ...currentCart.map((item) {
          return ListTile(
            title: Text(item.name),
            subtitle: Text('\$${item.cost.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.minus_circle),
              onPressed: () {
                currentCart.remove(item);
                onCartUpdated(currentCart);
                print('Item removed from cart: ${item.name}');
              },
            ),
          );
        }).toList(),

        if(currentCart.isNotEmpty) ...[
          const Divider(),
          ListTile(
            title: const Text('Total'),
            subtitle: Text(
              '\$${currentCart.fold(0.0, (total, item) => total + item.cost).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                onCartUpdated([]); // Clear the cart
                print('Cart cleared');
              },
              child: const Text('Clear Cart'),
            ),
          ),
        ]
        else ...[
          const ListTile(
            title: Text('Your cart is empty', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ],
      ],
    );
  }
}
