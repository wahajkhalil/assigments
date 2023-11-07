import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/CheckoutScreen.dart';
import 'package:flutterapp/Data/DataClass.dart';

import 'package:flutter/material.dart';
import 'package:flutterapp/ProviderCart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    double totalAmount = 0.0;
    cartItems.forEach((item) {
      // Do something with each item
      totalAmount += item.price;
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Center(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                    // Add a delete button to remove items from the cart
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cartProvider.removeFromCart(item);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Display the total amount
          Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  // Replace this with your actual logic for getting the price of an item

}