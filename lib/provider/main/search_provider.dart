// lib/provider/main/search_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lokakarya/data/model/product.dart';

class SearchProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _searchQuery = "";
  List<Product> _filteredProducts = [];

  String get searchQuery => _searchQuery;
  List<Product> get filteredProducts => _filteredProducts;

  Future<void> filterProducts(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredProducts = [];
      notifyListeners();
      return;
    }

    try {
      final snapshot = await _firestore.collection('products').get();
      final allProducts =
          snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();

      _filteredProducts = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error filtering products: $e');
    }
  }
}
