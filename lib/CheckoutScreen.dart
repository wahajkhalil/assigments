import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Data/DataClass.dart';

import 'Widget/CartListItem.dart';

class CheckoutPage extends StatelessWidget {
  final List<MenuItem> cartItems;

  CheckoutPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalCost = cartItems.map((item) => item.price).fold(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartListItem(menuItem: cartItems[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Total Cost: \$${totalCost.toStringAsFixed(2)}'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement the order finalization logic here
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
