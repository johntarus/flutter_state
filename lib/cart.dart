import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/provider.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartProvider>(
      builder:
          (BuildContext context, ShoppingCartProvider cart, Widget? child) =>
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: const Text('Shopping Cart'),
                    trailing: IconButton(
                      icon: const Icon(CupertinoIcons.cart),
                      onPressed: () {},
                    ),
                  ),

                  const Divider(),
                  ...cart.uniqueItemsInCart.map((item) {
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('\$${item.cost.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(CupertinoIcons.minus_circled),
                        onPressed: () {
                          cart.removeItem(item);
                          print('Item removed from cart: ${item.name}');
                        },
                      ),
                    );
                  }).toList(),
                  ListTile(
                    title: Text(
                      'Total Cost: \$${cart.totalCost.toStringAsFixed(2)}',
                    ),
                    subtitle: Text('Total Items: ${cart.itemsInCart.length}'),
                    trailing: OutlinedButton.icon(
                        onPressed: ()=> Provider.of<ShoppingCartProvider>
                          (context, listen: false).emptyCart(),
                        label: const Text('Clear Cart')),
                  ),
                ],
              ),
    );
  }
}
