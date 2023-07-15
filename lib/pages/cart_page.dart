import 'dart:convert';

import 'package:fikri/models/product_model.dart';
import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/widgets/app_bar_widget.dart';
import 'package:fikri/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fikri/utils/functions.dart' as functions;

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required UserModelEmail user})
      : _user = user,
        super(key: key);

  final UserModelEmail _user;

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late Future<List<ProductModel>> _products;
  late Map<String, dynamic> productQuantities;

  @override
  void initState() {
    // clearCart();
    _products = getCart();
    productQuantities = {};
    initialization();
    super.initState();
  }

  void initialization() async {
    productQuantities = await getCartQuantities();
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "My Cart",
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                clearCart();
                _products = getCart();
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Your cart is empty"),
              );
            }
            return ListView.builder(
              itemCount: productQuantities.length,
              itemBuilder: (context, index) {
                return CartItem(
                  product: snapshot.data![index],
                  quantity: productQuantities[snapshot.data![index].name]!,
                  onRemove: () {
                    setState(() {
                      _products = removeProductFromCart(
                        snapshot.data![index],
                      );
                    });
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred: ${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('${widget._user.email}_cart');
    prefs.remove('${widget._user.email}_quantities');
  }

  // Future<List<ProductModel>> getCart() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> cart = prefs.getStringList('${widget._user.email}_cart') ?? [];
  //   return cart
  //       .map((product) => ProductModel.fromJson(jsonDecode(product)))
  //       .toList();
  // }

  Future<List<ProductModel>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('${widget._user.email}_cart') ?? [];
    List<ProductModel> products = cart
        .map((product) => ProductModel.fromJson(jsonDecode(product)))
        .toList();
    return products;
  }

  Future<Map<String, dynamic>> getCartQuantities() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('${widget._user.email}_quantities') == null) {
      return {};
    }
    // print(prefs.getString('${widget._user.email}_quantities')!);
    Map<String, dynamic> quantities =
        json.decode(prefs.getString('${widget._user.email}_quantities')!);
    return quantities;
  }

  Future<List<ProductModel>> removeProductFromCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('${widget._user.email}_cart') ?? [];
    prefs.remove("${widget._user.email}_quantities");
    if (productQuantities[product.name] > 1) {
      productQuantities[product.name] = productQuantities[product.name]! - 1;
    } else {
      productQuantities.remove(product.name);
      cart.remove(product.toJson());

      prefs.setStringList('${widget._user.email}_cart', cart);
    }
    functions.setQuantities(productQuantities, widget._user.email);
    return cart
        .map((product) => ProductModel.fromJson(jsonDecode(product)))
        .toList();
  }
}
