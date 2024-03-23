import 'package:flutter/material.dart';
import '../models/food.dart';

class CartItem extends StatelessWidget {
  final Food food;
  final int quantity;

  const CartItem({required this.food, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(food.image),
      title: Text(food.name),
      subtitle: Text('Quantity: $quantity'),
    );
  }
}
