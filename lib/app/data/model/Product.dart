import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;

  Product(
      {required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.size,
      required this.id,
      required this.color});
  List<Product> products = [
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 1",
        description: "description 1",
        price: 12,
        size: 1,
        id: 1,
        color: Colors.pinkAccent),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 2",
        description: "description 2",
        price: 12,
        size: 2,
        id: 2,
        color: Colors.blue),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 3",
        description: "description 3",
        price: 12,
        size: 1,
        id: 3,
        color: Colors.red),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 4",
        description: "description 4",
        price: 12,
        size: 3,
        id: 4,
        color: Colors.yellow),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 5",
        description: "description 5",
        price: 12,
        size: 1,
        id: 5,
        color: Colors.indigo),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 6",
        description: "description 6",
        price: 12,
        size: 1,
        id: 6,
        color: Colors.lightGreenAccent),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 7",
        description: "description 7",
        price: 12,
        size: 1,
        id: 7,
        color: Colors.greenAccent),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 8",
        description: "description 8",
        price: 12,
        size: 1,
        id: 8,
        color: Colors.deepOrangeAccent),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 9",
        description: "description 9",
        price: 12,
        size: 1,
        id: 9,
        color: Colors.purpleAccent),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 10",
        description: "description 10",
        price: 12,
        size: 1,
        id: 10,
        color: Colors.tealAccent),
    Product(
        image: "/assets/images/product/productimage.png",
        title: "Product 11",
        description: "description 11",
        price: 12,
        size: 1,
        id: 11,
        color: Colors.brown),
  ];
}
