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
        children: [
          Image.asset(widget.image ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.name, style: TextStyle(fontSize: 20,fontFamily: "mainfont"),textAlign: TextAlign.end, ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.description),
          ),
          Text('Price: \$${widget.price.toStringAsFixed(2)}'),




          ElevatedButton(
            onPressed: () {
              final cartProvider = Provider.of<CartProvider>(context, listen: false);
              cartProvider.addToCart(MenuItem(name: widget.name, price: widget.price));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to cart'), duration: Duration(seconds: 1),
                ),
              );
            },
            child: Text('Add to Cart'),
          ),         ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );

             // widget.cart.addItem(MenuItem(name: widget.name, price: widget.price));
             },
            child: Text('show cart'),
          )
        ],
      ),
    );
  }
}