import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Data/DataClass.dart';

class CartListItem extends StatelessWidget {
  final MenuItem menuItem;

  CartListItem({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        title: Text(menuItem.name),

        trailing: Text('\$${menuItem.price.toStringAsFixed(2)}'),
      ),
    );
  }
}
