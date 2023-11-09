import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Screens/CheckoutScreen.dart';
import 'package:flutterapp/Data/DataClass.dart';

import 'package:flutter/material.dart';
import 'package:flutterapp/Provider/ProviderCart.dart';
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
        title: Text("My Cart"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Add your click listener logic here
                    // For example, you can navigate to the cart screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                ),
                if (cartItems.length > 0)
                  Positioned(
                    right: 8, // Adjust the position as needed
                    top: 8, // Adjust the position as needed
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        cartItems.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), // Adjust the corner radius as needed
                    ),
                    elevation: 4, // Add elevation for a shadow effect
                    margin: EdgeInsets.all(8.0), // Add margin for spacing
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    18.0), // Adjust the corner radius as needed
              ),
              elevation: 4, // Add elevation for a shadow effect
              margin: EdgeInsets.all(8.0), // Add margin for spacing
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                        style:
                            TextStyle(fontSize: 40, fontFamily: 'mainfontBold'),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the next screen here
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckoutPage(),
                      ));
                    },
                    icon: Icon(Icons.arrow_forward), // Built-in icon
                    label: Text('Go to Place Order Screen'),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 40.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
