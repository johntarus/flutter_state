import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inventory.dart';

class ShoppingCartProvider extends ChangeNotifier {
  final List<Item> _itemsInCart = [];

  UnmodifiableListView<Item> get itemsInCart => UnmodifiableListView(_itemsInCart);

  double get totalCost{
    double price = 0.0;
    for (Item item in _itemsInCart) {
      price += item.cost;
    }
    return price;
  }

  List<Item> get uniqueItemsInCart {
    final List<Item> uniqueItems = [];
    for (Item item in _itemsInCart) {
      if (!uniqueItems.contains(item)) {
        uniqueItems.add(item);
      }
    }
    return uniqueItems;
  }

  void addItem(Item item) {
    _itemsInCart.add(item);
    notifyListeners();
    print('Item added to cart: ${item.name}');
  }

  void removeItem(Item item) {
    _itemsInCart.remove(item);
    notifyListeners();
    print('Item removed from cart: ${item.name}');
  }

  void emptyCart() {
    _itemsInCart.clear();
    notifyListeners();
    print('Cart emptied');
  }
}
