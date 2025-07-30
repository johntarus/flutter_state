import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'inventory.dart';

@immutable
abstract class ShoppingCartEvent{}

@immutable
abstract class ShoppingCartState{}

class InitialShoppingCartState extends ShoppingCartState {
  InitialShoppingCartState(): super();
}

class CartWithItems extends ShoppingCartState {
  final List<Item> itemsInCart;

  CartWithItems({required this.itemsInCart}): super();

  double get totalCost {
    return itemsInCart.fold(0.0, (sum, item) => sum + item.cost);
  }

  List<Item> get uniqueItemsInCart {
    return itemsInCart.toSet().toList();
  }
}

class Waiting extends ShoppingCartState {
  Waiting(): super();
}

class AddItemToCart extends ShoppingCartEvent {
  final Item item;

  AddItemToCart({required this.item}): super();
}

class ClearCart extends ShoppingCartEvent {
  ClearCart();
}

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final List<Item> _itemsInCart = <Item>[];

  ShoppingCartBloc() : super(InitialShoppingCartState()) {
    on<AddItemToCart>((event, emit) async {
      emit(Waiting());
      await Future.delayed(const Duration(seconds: 2));
      _itemsInCart.add(event.item);
      emit(CartWithItems(itemsInCart: _itemsInCart));
    });

      on<ClearCart>((event, emit) async {
        _itemsInCart.clear();
        emit(InitialShoppingCartState());
      });
  }
}