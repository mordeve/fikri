import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/pages/cart_page.dart';
import 'package:fikri/pages/product_page.dart';
import 'package:fikri/pages/profile_page.dart';
import 'package:fikri/pages/shopping_list_page.dart';
import 'package:fikri/utils/colors.dart';
import 'package:flutter/material.dart';

Drawer menuDrawer(BuildContext context, UserModelEmail user) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 275,
          child: DrawerHeader(
            decoration: const BoxDecoration(
              color: kPrimaryAppColor,
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'FİKRİ',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: kPrimaryAppColor,
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: kPrimaryAppColor,
            ),
          ),
          subtitle: const Text('View and edit your profile'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(user: user)));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.shopping_cart,
            color: kPrimaryAppColor,
          ),
          title: const Text(
            'Products',
            style: TextStyle(
              color: kPrimaryAppColor,
            ),
          ),
          subtitle: const Text('View products'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductPage(user: user)));
          },
        ),
        // a list tile for the cart page
        ListTile(
          leading: const Icon(
            Icons.list,
            color: kPrimaryAppColor,
          ),
          title: const Text(
            'Shopping List',
            style: TextStyle(
              color: kPrimaryAppColor,
            ),
          ),
          subtitle: const Text('View your shopping list'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShoppingListPage(user: user)));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.shopping_basket,
            color: kPrimaryAppColor,
          ),
          title: const Text(
            'Cart',
            style: TextStyle(
              color: kPrimaryAppColor,
            ),
          ),
          subtitle: const Text('View your cart'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CartPage(user: user)));
          },
        ),
      ],
    ),
  );
}
