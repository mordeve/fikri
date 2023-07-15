import 'dart:convert';

import 'package:fikri/models/product_model.dart';
import 'package:fikri/models/shopping_list_item.dart';
import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/utils/colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fikri/widgets/shopping_list_cart.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingListPage extends StatefulWidget {
  final UserModelEmail user;
  const ShoppingListPage({Key? key, required this.user}) : super(key: key);

  @override
  ShoppingListPageState createState() => ShoppingListPageState();
}

class ShoppingListPageState extends State<ShoppingListPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController3;
  final List<String> _filterList = ["All", "Checked", "Unchecked"];

  int _selectedItem = 0;

  late ScrollController _controller;

  void _scrollListner() {
    if (_controller.offset >= 50) {
      setState(() {
        // _secDot = 10;
        _boxHeight = 250;
        _topPickHeight = 250;
        _imageSize = 0;
      });
    }
    if (_controller.offset <= 10) {
      setState(() {
        Future.delayed(const Duration(milliseconds: 10), () {
          setState(() {
            _boxHeight = 400;
            _topPickHeight = 450;
            _imageSize = 250;
          });
        });
      });
    }
  }

  double _boxHeight = 400;
  double _imageSize = 200;
  double _topPickHeight = 450;

  bool isInitialized = true;
  late Future<List<ShoppingListItem>> products;
  late List<ShoppingListItem> productsNotFuture;

  final TextEditingController _productController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();

// create
  @override
  void initState() {
    super.initState();
    products = getList();
    products.then((value) {
      productsNotFuture = value;
    });
    _controller = ScrollController();
    _controller.addListener(_scrollListner);

    _animationController3 = AnimationController(
        //
        vsync: this,
        duration: const Duration(milliseconds: 1500),
        animationBehavior: AnimationBehavior.preserve)
      ..addListener(() {
        setState(() {});
      });
    Future.delayed(const Duration(seconds: 1), () {
      _animationController3.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListner);
    _controller.dispose();
    _productController.dispose();
    _productQuantityController.dispose();
    _animationController3.removeListener(() {});
    _animationController3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            height: _boxHeight,
            width: double.infinity,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: _topPickHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          // Color.fromARGB(255, 37, 110, 39),
                          kPrimaryAppColor.withOpacity(1),
                          kPrimaryAppColor.withOpacity(1),
                        ]),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(
                        60,
                      ),
                    ),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "Fikri",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(.3)),
                                child: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        "Shopping\nList",
                        style: TextStyle(
                            color: kSignUpCardColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 100,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: _imageSize,
                        width: _imageSize,
                        child: Image.asset("assets/images/logo.png"),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              itemCount: _filterList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (index == 1) {
                          showOnlyDone();
                        } else if (index == 2) {
                          showOnlyNotDone();
                        } else {
                          products = getList();
                        }
                        _selectedItem = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: 60,
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      decoration: BoxDecoration(
                          color: kPrimaryAppColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          _filterList[index],
                          style: TextStyle(
                              color: _selectedItem == index
                                  ? kSignUpCardColor
                                  : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          FutureBuilder(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: isInitialized
                          ? textMessageWidget()
                          : const CircularProgressIndicator(
                              color: kPrimaryAppColor,
                            ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return startWithAnimation(snapshot.data![index], index);
                      }),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryAppColor,
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30, right: 30, bottom: 30),
            child: GestureDetector(
              onTap: () {
                addItemToListDialog(context);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryAppColor,
                    borderRadius: BorderRadius.circular(50)),
                child: const Center(
                  child: Text(
                    "Add New Product",
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> addItemToListDialog(BuildContext context) {
    _productQuantityController.text = "1";
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryAppColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Add New Product",
                    style: TextStyle(
                        color: kPrimaryAppColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _productController,
                      decoration: InputDecoration(
                          hintText: "Product Name",
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _productQuantityController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        products = addNewProductToList(
                          ShoppingListItem.fromProductModel(
                              product: ProductModel(
                                  name: _productController.text,
                                  price: 12.4,
                                  description: "description",
                                  category: "test"),
                              quantity:
                                  int.parse(_productQuantityController.text),
                              isDone: false),
                          widget.user,
                        ).then(
                          (value) => productsNotFuture = value,
                        );
                        _productController.clear();
                        _productQuantityController.clear();
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kPrimaryAppColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          "Add Product",
                          style: TextStyle(
                              color: kSignUpCardColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget startWithAnimation(ShoppingListItem item, int index) {
    if (index == 0) {
      return FadeInRight(
        duration: const Duration(milliseconds: 0),
        child: ShoppingListTileWidget(
          product: item,
          index: index,
          onRemove: () {
            setState(() {
              products = removeProductFromList(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
          onUpdate: () {
            setState(() {
              products = updateListProduct(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
        ),
      );
    } else if (index == 1) {
      return FadeInLeft(
        duration: const Duration(milliseconds: 0),
        child: ShoppingListTileWidget(
          product: item,
          index: index,
          onRemove: () {
            setState(() {
              products = removeProductFromList(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
          onUpdate: () {
            setState(() {
              products = updateListProduct(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
        ),
      );
    } else if (index == 2) {
      return FadeInUp(
        duration: const Duration(milliseconds: 0),
        child: ShoppingListTileWidget(
          product: item,
          index: index,
          onRemove: () {
            setState(() {
              products = removeProductFromList(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
          onUpdate: () {
            setState(() {
              products = updateListProduct(item)
                  .then((value) => productsNotFuture = value);
            });
          },
        ),
      );
    } else if (index == 3) {
      return FadeInDown(
        duration: const Duration(milliseconds: 0),
        child: ShoppingListTileWidget(
          product: item,
          index: index,
          onRemove: () {
            setState(() {
              products = removeProductFromList(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
          onUpdate: () {
            setState(() {
              products = updateListProduct(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
        ),
      );
    } else {
      return FadeInLeft(
        duration: const Duration(milliseconds: 0),
        child: ShoppingListTileWidget(
          product: item,
          index: index,
          onRemove: () {
            setState(() {
              products = removeProductFromList(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
          onUpdate: () {
            setState(() {
              products = updateListProduct(item).then(
                (value) => productsNotFuture = value,
              );
            });
          },
        ),
      );
    }
  }

  Future<List<ShoppingListItem>> getList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart =
        prefs.getStringList('${widget.user.email}_shopping_list') ?? [];
    List<ShoppingListItem> products = cart
        .map((product) => ShoppingListItem.fromJson(jsonDecode(product)))
        .toList();
    isInitialized = true;
    return products;
  }

  Future<List<ShoppingListItem>> addNewProductToList(
      ShoppingListItem product, UserModelEmail user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart =
        prefs.getStringList('${user.email}_shopping_list') ?? [];
    if (!product.isInList(productsNotFuture)) {
      cart.add(product.toJson());
      prefs.setStringList('${user.email}_shopping_list', cart);
    } else {
      print("already in list");
    }
    return cart
        .map((product) => ShoppingListItem.fromJson(jsonDecode(product)))
        .toList();
  }

  Future<List<ShoppingListItem>> updateListProduct(
      ShoppingListItem product) async {
    final prefs = await SharedPreferences.getInstance();

    if (product.isDone) {
      product.isDone = false;
    } else {
      product.isDone = true;
    }

    productsNotFuture
        .where((element) => element.product.name == product.product.name)
        .single
        .isDone = product.isDone;
    prefs.setStringList('${widget.user.email}_shopping_list',
        productsNotFuture.map((e) => e.toJson()).toList());

    if (_selectedItem == 1) {
      showOnlyDone();
    } else if (_selectedItem == 2) {
      showOnlyNotDone();
    }
    return productsNotFuture; // ToDo check if I need to return the list or it change itself
  }

  Future<List<ShoppingListItem>> removeProductFromList(
      ShoppingListItem product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart =
        prefs.getStringList('${widget.user.email}_shopping_list') ?? [];

    cart.remove(product.toJson());
    prefs.setStringList('${widget.user.email}_shopping_list', cart);

    return cart
        .map((product) => ShoppingListItem.fromJson(jsonDecode(product)))
        .toList();
  }

  void showOnlyDone() {
    products = getList();
    products = products.then(
        (value) => value.where((element) => element.isDone == true).toList());
  }

  void showOnlyNotDone() {
    products = getList();
    products = products.then(
        (value) => value.where((element) => element.isDone == false).toList());
  }

  Widget textMessageWidget() {
    if (_selectedItem == 1) {
      return const Text(
        "No items are checked",
        style: TextStyle(
            color: kPrimaryAppColor, fontSize: 20, fontWeight: FontWeight.w600),
      );
    } else if (_selectedItem == 2) {
      return const Text(
        "All items are checked",
        style: TextStyle(
            color: kPrimaryAppColor, fontSize: 20, fontWeight: FontWeight.w600),
      );
    } else {
      return const Text(
        "No Products in the list",
        style: TextStyle(
            color: kPrimaryAppColor, fontSize: 20, fontWeight: FontWeight.w600),
      );
    }
  }
}
