import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/DataClass.dart';

// class MenuCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String image;
//
//   MenuCard({required this.title, required this.description, required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: <Widget>[
//           Image.asset(image),
//           ListTile(
//             title: Text(title),
//             subtitle: Text(description),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// class MenuItemCard extends StatelessWidget {
//   final MenuItem menuItem;
//
//   MenuItemCard({required this.menuItem});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Image.network(menuItem.imageURL),
//         title: Text(menuItem.name),
//         subtitle: Text(menuItem.description),
//         trailing: Text('\$${menuItem.price.toStringAsFixed(2)}'),
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return MenuItemDetail(menuItem: menuItem);
//           }));
//         },
//       ),
//     );
//   }
// }