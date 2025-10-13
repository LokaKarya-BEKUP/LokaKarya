// lib/provider/main/search_provider.dart
import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product.dart';

class SearchProvider extends ChangeNotifier {
  String _searchQuery = "";
  List<Product> _filteredProducts = [];

  String get searchQuery => _searchQuery;
  List<Product> get filteredProducts => _filteredProducts;

  void filterProducts(String query) {
    _searchQuery = query;
    _filteredProducts = dummyProductList
        .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    notifyListeners();
  }
}
