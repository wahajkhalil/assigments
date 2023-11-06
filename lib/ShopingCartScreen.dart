import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/CheckoutScreen.dart';
import 'package:flutterapp/Data/DataClass.dart';

class ShoppingCartPage extends StatelessWidget {
  final ShoppingCart cart;

  ShoppingCartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Center(
        child: Column(
          children: [
            Text('Items in Cart:'),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Text('Total Cost: \$${cart.calculateTotalCost().toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
             //    Navigator.push(
             //      context,
             // //      MaterialPageRoute(
             // // ///       builder: (context) => CheckoutPage( cart),
             // //      ),
             //    );

                // widget.cart.addItem(MenuItem(name: widget.name, price: widget.price));
              },
              child: Text('Place order'),
            )
          ],
        ),
      ),
    );
  }
}