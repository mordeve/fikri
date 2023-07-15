import 'package:fikri/models/product_model.dart';

const host = "http://localhost:3001";
const gmailSignUpURI = "/api/signup/gmail";
const emailSignUpURI = "/api/signup";
const emailSignInURI = "/api/signin";

const List<Map<String, dynamic>> products = [
  {
    'name': 'Gummy Bears',
    'price': 2.99,
    'description': 'A bag of gummy bears',
    'category': 'candy',
    'image':
        'https://images.unsplash.com/photo-1582058091505-f87a2e55a40f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
  },
  {
    'name': 'Hershey Chocolate Bar',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://images.unsplash.com/photo-1629446061607-643b4c1e22d1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1471&q=80',
  },
  {
    'name': 'Twix',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://images.unsplash.com/photo-1529077246295-f6c7172c8165?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1392&q=80',
  },
  {
    'name': 'Snickers',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://images.unsplash.com/photo-1611250503393-9424f314d265?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1373&q=80',
  },
  {
    'name': 'M&Ms',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://images.unsplash.com/photo-1534705867302-2a41394d2a3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80',
  },
  {
    'name': 'Milky Way',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://images.unsplash.com/photo-1606312619070-d48b4c652a52?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  },
  {
    'name': 'Reese\'s Peanut Butter Cups',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://s7d2.scene7.com/is/image/hersheysassets/0_34000_43095_6_701_43095_013_Item_Front?fmt=png-alpha&hei=412&qlt=75',
  },
  {
    'name': 'Skittles',
    'price': 1.99,
    'description': 'A chocolate bar',
    'category': 'candy',
    'image':
        'https://www.ubuy.com.tr/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNjFPZ3FobTlBQUwuX1NMMTAwMF8uanBn.jpg',
  }
];

// create products list from productModel class according to above list of products
List<ProductModel> productsList =
    products.map((item) => ProductModel.fromJson(item)).toList();

const String sharedLogged = "isLogged";
const String sharedUserEmail = "userEmail";
const String sharedUserPassword = "userPassword";
