import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/inherited-widget.dart';
import 'package:navigation/main.dart';

class Inventory extends StatelessWidget {
  final void Function(List<Item> items) onCartUpdated;

  const Inventory(this.onCartUpdated, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> currentCart = List.from(
      ShoppingCartInheritedWidget.of(context)!.itemsInCart,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Inventory', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: inventory.length,
          itemBuilder: (context, index) {
            final item = inventory[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('\$${item.cost.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.plus_circle),
                onPressed: () {
                  currentCart.add(item);
                  onCartUpdated(currentCart);
                  print('Item added to cart: ${item.name}');
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
