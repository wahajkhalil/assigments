import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterapp/Data/DataClass.dart';
import 'package:flutterapp/Screens/ShopingCartScreen.dart';
import 'package:provider/provider.dart';

import '../Provider/ProviderCart.dart';
import 'ItemDetailPage.dart';

class MenuPage extends StatelessWidget {
  List<String> list = [
    "assets/images/pizz.png",
    "assets/images/pizzaw.jpg",
    "assets/images/pizzas.jpg",
    "assets/images/food5.jpeg",
    "assets/images/food7.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Page')
            .animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(delay: 300.ms, duration: 600.ms)
        // runs after the above w/new duration
        ,
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
      body: ListView(
        children: [
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              scrollDirection: Axis.vertical,
              enlargeCenterPage: true,
            ),
            items: list
                .map((item) => Container(
                      child: Center(child: Image.asset(item)),
                      color: Colors.white,
                    ))
                .toList(),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please Select the Menu",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: "mainfont"),
            )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .fadeOut(curve: Curves.easeInOut),
          ),
          MenuItemCard(
              name: 'Chow mein',
              description:
                  'Chow mein is a Chinese dish made from stir-fried noodles with vegetables and sometimes meat or tofu. Over the centuries, variations of chǎomiàn were developed in',
              price: 10.99,
              image: 'assets/images/food1.jpeg'),
          MenuItemCard(
              name: 'Salad',
              description:
                  'A salad is a dish consisting of mixed ingredients, frequently vegetables. They are typically served chilled or at room',
              price: 12.99,
              image: 'assets/images/food4.jpeg'),
          MenuItemCard(
              name: 'Pizza',
              description:
                  'Pizza is a dish of Italian origin consisting of a usually round, flat base of leavened wheat-based dough topped with tomatoes, cheese, and often various other ingredients, which is then baked at a high',
              price: 8.99,
              image: 'assets/images/food7.jpeg'),
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
                    image: image,
                    cart: cart,
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
