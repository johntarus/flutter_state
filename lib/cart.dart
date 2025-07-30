import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/cart-bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder:
          (BuildContext context, ShoppingCartState state) =>
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
                  if (state is Waiting)
                    const Center(child: CircularProgressIndicator())
                  else if (state is InitialShoppingCartState)
                    const Center(child: Text('Your cart is empty'))
                  else if (state is CartWithItems)
                    ...state.itemsInCart.map((item) {
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('\$${item.cost.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(CupertinoIcons.minus_circled),
                          onPressed: () {
                            context.read<ShoppingCartBloc>().add(ClearCart());
                          },
                        ),
                      );
                    }).toList(),
                  if (state is CartWithItems && state.itemsInCart.isNotEmpty)
                    ListTile(
                      title: const Text('Total Cost'),
                      subtitle: Text(
                        '\$${state.totalCost.toStringAsFixed(2)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(CupertinoIcons.trash),
                        onPressed: () {
                          context.read<ShoppingCartBloc>().add(ClearCart());
                        },
                      ),
                    ),
                  if (state is CartWithItems && state.itemsInCart.isEmpty)
                    const Center(child: Text('Your cart is empty')),
                ],
              ),
    );
  }
}
