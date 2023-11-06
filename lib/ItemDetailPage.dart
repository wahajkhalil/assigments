import 'package:flutter/material.dart';
import 'package:flutterapp/Data/DataClass.dart';
import 'package:flutterapp/ShopingCartScreen.dart';

import 'Widget/MenuCard.dart';

// class ItemDetailsPage extends StatelessWidget {
//   final MenuCard menuCard;
//
//   ItemDetailsPage(this.menuCard);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(menuCard.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("Item Detail Page" , style: TextStyle(fontFamily: "mainfont",fontSize: 20),textAlign: TextAlign.start,)
//             ,    SizedBox(
//               width: 100.0,
//               height:50.0,
//
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(menuCard.image),
//             ),
//             SizedBox(
//               width: 100.0,
//               height:50.0,
//
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(menuCard.description),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



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
              widget.cart.addItem(MenuItem(name: widget.name, price: widget.price));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to cart'),
                ),
              );
            },
            child: Text('Add to Cart'),
          ),         ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartPage(cart:   widget.cart),
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