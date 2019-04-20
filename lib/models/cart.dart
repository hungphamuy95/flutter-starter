import 'dart:collection';

import 'package:demo_app/models/src/item.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{
  // Internal, private state of the cart.
  final List<Item> _items = [];

  // An unmodified view of the items in the cart
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // The current total price of all items (assuming all items cost 1$)
  int get totalPrice => _items.length;

  // Adds [item] to cart. This is the only way to modify cart from the outside.
  void add(Item item){
    _items.add(item);
    // This line tells [Model] that is should rebuild the widgets that depend on it.
    notifyListeners();
  }

  // Remove all items in the cart.
  void clear(){
    _items.clear();
  }
}
