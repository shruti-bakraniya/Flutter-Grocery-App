import 'package:flutter/material.dart';
import 'package:flutter_grocery_app/data/grocery_data.dart';
import 'package:flutter_grocery_app/features/home/models/home_product_data_model.dart';
import 'package:flutter_grocery_app/features/home/ui/product_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductDataModel> listOfProductDataModel =
  GroceryData.groceryProducts.map((e) => ProductDataModel(
    id: e['id'],
    name: e['name'],
    description: e['description'],
    imageUrl: e['imageUrl'],
    price: e['price'],
  )).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grocery App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: GroceryData.groceryProducts.length,
        itemBuilder: (context, index) {
          return ProductTileWidget(
            productDataModel: listOfProductDataModel[index],
          );
        },
      ),
    );
  }
}
