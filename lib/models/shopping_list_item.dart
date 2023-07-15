import 'dart:convert';

import 'package:fikri/models/product_model.dart';

class ShoppingListItem {
  final ProductModel product;
  final int quantity;
  bool isDone;

  ShoppingListItem({
    required this.product,
    required this.quantity,
    required this.isDone,
  });

  ShoppingListItem.fromJson(Map<String, dynamic> json)
      : product = ProductModel.fromJson(jsonDecode(json['product'])),
        quantity = json['quantity'],
        isDone = json['isDone'];

// to JSON with jsonEncode()
  String toJson() {
    return jsonEncode({
      'product': product.toJson(),
      'quantity': quantity,
      'isDone': isDone,
    });
  }

  ShoppingListItem.fromProductModel({
    required this.product,
    required this.quantity,
    required this.isDone,
  });

  bool isInList(List<ShoppingListItem> list) {
    for (var item in list) {
      if (item.product.name == product.name) {
        return true;
      }
    }
    return false;
  }
}
