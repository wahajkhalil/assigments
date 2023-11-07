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
        title: Text('Cart'),
      ),
      body: Center(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}',style: TextStyle(fontSize:40,fontFamily: 'mainfontBold' ),)),
            ),

        SizedBox(
        width: 100.0,
        height: 80.0,
     )
            ,
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the next screen here
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CheckoutPage(),
                ));
              },
              icon: Icon(Icons.arrow_forward), // Built-in icon
              label: Text('Go to Second Screen'),

            )

,      SizedBox(
              width: 100.0,
              height: 80.0,
            )
          ],
        ),
      ),
    );
  }


}