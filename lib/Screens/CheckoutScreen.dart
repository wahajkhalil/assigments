import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Data/DataClass.dart';
import 'package:flutterapp/Provider/ProviderCart.dart';
import 'package:provider/provider.dart';

import '../Widget/CartListItem.dart';

class CheckoutPage extends StatelessWidget {
  late List<MenuItem> cartItems;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartItems = cartProvider.cartItems;
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Adjust the corner radius as needed
            ),
            elevation: 4, // Add elevation for a shadow effect
            margin: EdgeInsets.all(16.0), // Add margin for spacing
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Total Cost: \$${totalCost.toStringAsFixed(2)}', style: TextStyle(fontSize: 40)),
                  ElevatedButton(
                    onPressed: () {
                      _showCongratulatoryDialog(context);
                      // Implement the order finalization logic here
                    },
                    child: Text('Place Order', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Congratulations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Congratulations! Your Order is Placed',
            style: TextStyle(fontSize: 16, fontFamily: 'mainfontBold'),
          ),
          SizedBox(height: 24),
          Container(
            width: 100, // Set the width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Adjust the radius for a round button
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          )
          ,
        ],
      ),
    );
  }

  void _showCongratulatoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        );
      },
    );
  }
}
