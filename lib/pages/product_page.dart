import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/utils/constants.dart';
import 'package:fikri/widgets/app_bar_widget.dart';
import 'package:fikri/widgets/menu_drawer.dart';
import 'package:fikri/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required UserModelEmail user})
      : _user = user,
        super(key: key);

  final UserModelEmail _user;

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  late UserModelEmail _user;

  @override
  void initState() {
    _user = widget._user;
    initialization();
    super.initState();
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 200));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: "Fikri"),
      drawer: menuDrawer(context, _user),
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List<Widget>.generate(
            productsList.length,
            (index) => productCard(productsList[index], _user),
          ),
        ),
      ]),
    );
  }
}
