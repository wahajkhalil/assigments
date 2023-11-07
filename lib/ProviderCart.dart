import 'package:flutter/foundation.dart';
import 'package:flutterapp/Data/DataClass.dart';

class CartProvider with ChangeNotifier {
  List<MenuItem> _cartItems = [];

  List<MenuItem> get cartItems => _cartItems;

  void addToCart(MenuItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(MenuItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}
