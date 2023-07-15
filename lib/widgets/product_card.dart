import 'dart:convert';

import 'package:fikri/models/product_model.dart';
import 'package:fikri/models/user_model_email.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fikri/utils/functions.dart' as functions;

Widget productCard(ProductModel product, UserModelEmail user) {
  return Container(
    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
    child: productInfo(product, user),
  );
}

Widget productInfo(ProductModel product, UserModelEmail user) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Image.network(
            product.image!,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${product.price}₺',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            addProductToCart(product, user);
          },
          child: const Text('Add to cart'),
        ),
      ],
    ),
  );
}

Future<void> addProductToCart(ProductModel product, UserModelEmail user) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> cart = prefs.getStringList('${user.email}_cart') ?? [];
  if (!cart.contains(product.toJson())) {
    cart.add(product.toJson());
    prefs.setStringList('${user.email}_cart', cart);
  }
  Map<String, dynamic> sharedQuantities = {};

  if (prefs.getString('${user.email}_quantities') != null) {
    sharedQuantities =
        json.decode(prefs.getString('${user.email}_quantities')!);

    if (sharedQuantities.containsKey(product.name)) {
      sharedQuantities[product.name] = sharedQuantities[product.name]! + 1;
    } else {
      sharedQuantities[product.name] = 1;
    }
  } else {
    sharedQuantities[product.name] = 1;
  }
  functions.setQuantities(sharedQuantities, user.email);
}
