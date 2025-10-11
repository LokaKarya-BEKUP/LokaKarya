// lib/provider/main/favorite_provider.dart
import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }

  void addFavorite(Product product) {
    if (!isFavorite(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    _favoriteProducts.remove(product);
    notifyListeners();
  }
}
