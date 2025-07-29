import 'package:flutter/cupertino.dart';
import 'package:navigation/main.dart';

class ShoppingCartInheritedWidget extends InheritedWidget {
  final List<Item> itemsInCart;
  final ValueChanged<List<Item>> onListChanged;

  @override
  const ShoppingCartInheritedWidget({
    super.key,
    required super.child,
    required this.itemsInCart,
    required this.onListChanged,
  });

  static ShoppingCartInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShoppingCartInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ShoppingCartInheritedWidget oldWidget) {
    return oldWidget.itemsInCart != oldWidget.itemsInCart ||
           oldWidget.onListChanged != onListChanged;
  }
}