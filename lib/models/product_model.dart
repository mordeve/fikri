// create a class for the product model for name, price, description, category, and image
import 'dart:convert';

class ProductModel {
  String name;
  double price;
  String description;
  String category;
  String? image;

  ProductModel({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }

  String toJson() {
    return jsonEncode(
      {
        'name': name,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
      },
    );
  }

  // write toString() method to print the product model
  @override
  String toString() {
    return 'ProductModel{name: $name, price: $price, description: $description, category: $category, image: $image}';
  }
}
