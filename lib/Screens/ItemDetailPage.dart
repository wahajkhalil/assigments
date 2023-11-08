import 'package:flutter/material.dart';
import 'package:flutterapp/Data/DataClass.dart';
import 'package:flutterapp/Provider/ProviderCart.dart';
import 'package:flutterapp/Screens/ShopingCartScreen.dart';
import 'package:provider/provider.dart';

class MenuItemDetail extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String image;
  final ShoppingCart cart;

  MenuItemDetail({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.cart,
  });

  @override
  _MenuItemDetailState createState() => _MenuItemDetailState();
}

class _MenuItemDetailState extends State<MenuItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align at the bottom
        children: [
          Image.asset(widget.image),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 20, fontFamily: "mainfont"),
                  textAlign: TextAlign.start,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Price: \$${widget.price.toStringAsFixed(2)}',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontFamily: "mainfont", fontSize: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.description, style: TextStyle(fontSize: 20, fontFamily: "")),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Adjust the corner radius as needed
            ),
            elevation: 4, // Add elevation for a shadow effect
            margin: EdgeInsets.all(8.0), // Add margin for spacing
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);
                      cartProvider.addToCart(MenuItem(name: widget.name, price: widget.price));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text('Add to Cart'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text('Show Cart'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
