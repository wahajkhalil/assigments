import 'package:flutter/material.dart';
import 'package:flutterapp/Data/DataClass.dart';
import 'package:flutterapp/Widget/MenuCard.dart';

import 'ItemDetailPage.dart';
 

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Please Select the Menu" ,textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontFamily: "mainfont"),),
          ),
          MenuItemCard(name: 'Chow mein', description: 'Chow mein is a Chinese dish made from stir-fried noodles with vegetables and sometimes meat or tofu. Over the centuries, variations of chǎomiàn were developed in', price: 10.99, image: 'assets/images/food1.jpeg'),
          MenuItemCard(name: 'Salad', description: 'A salad is a dish consisting of mixed ingredients, frequently vegetables. They are typically served chilled or at room', price: 12.99, image: 'assets/images/food4.jpeg'),
          MenuItemCard(name: 'Pizza', description: 'Pizza is a dish of Italian origin consisting of a usually round, flat base of leavened wheat-based dough topped with tomatoes, cheese, and often various other ingredients, which is then baked at a high', price: 8.99, image: 'assets/images/food7.jpeg'),
        ],
      ),
    );
  }
}
class MenuItemCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String image;
  ShoppingCart cart = ShoppingCart();

  MenuItemCard({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
   });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            image,
            height: 250, // Adjust the height as needed
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
             
         
             title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(description),
            ),
            trailing: Text('\$${price.toStringAsFixed(2)}'),
              onTap: () {
                // Call your method or navigate to the detail page here.
                // For example, you can use Navigator to navigate to the detail page.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuItemDetail(
                      name: name,
                      description: description,
                      price: price,
                      image: image, cart: cart,
                    ),
                  ),
                );
              },


            
          ),

        ],
      ),
    );
  }


}
