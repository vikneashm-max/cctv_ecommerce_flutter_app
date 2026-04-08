import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final int price;
  final IconData icon;
  final double rating;
  final int popularity;
  final DateTime addedDate;
  final List<String>? _images;
  List<String> get images => _images ?? const [];

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
    required this.rating,
    required this.popularity,
    required this.addedDate,
    List<String>? images,
  }) : _images = images;
}
