import 'package:flutter/material.dart';

class CategoryColor {
  static Color getColor(String category) {
    switch (category.toLowerCase()) {
      case 'music':
        return Colors.purple;

      case 'technology':
        return Colors.blue;

      case 'food':
        return Colors.orange;

      case 'art':
        return Colors.pink;

      case 'sports':
        return Colors.green;

      case 'entertainment':
        return Colors.redAccent;

      case 'business':
        return Colors.teal;

      case 'literature':
        return Colors.brown;

      case 'health':
        return Colors.lightGreen;

      case 'film':
        return Colors.deepOrange;

      case 'culture':
        return Colors.indigo;

      default:
        return Colors.grey; // For unknown category
    }
  }
}
