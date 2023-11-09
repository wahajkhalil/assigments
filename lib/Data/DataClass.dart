import 'package:flutter/material.dart';

class ShoppingCart {
  List<MenuItem> items = [];

  void addItem(MenuItem item) {
    items.add(item);
  }

  double calculateTotalCost() {
    double total = 0.0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({
    required this.name,
    required this.price,
  });
}
