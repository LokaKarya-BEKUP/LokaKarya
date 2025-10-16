import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String categoryId;
  final int price;
  final String unit;
  final String? imageUrl;
  final String storeId;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.unit,
    this.imageUrl,
    required this.storeId,
    this.description,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      categoryId: data['categoryId'] ?? '',
      price: (data['price'] ?? 0).toInt(),
      unit: data['unit'] ?? '',
      imageUrl: data['imageUrl'],
      storeId: data['storeId'] ?? '',
      description: data['description'],
    );
  }

  String getStoreCity(List<Store> stores) {
    final store = stores.firstWhere(
      (s) => s.id == storeId,
      orElse: () => Store(id: "", name: "", city: "-", phone: ""),
    );
    return store.city;
  }

  Store? getStoreInfo(List<Store> stores) {
    try {
      return stores.firstWhere((s) => s.id == storeId);
    } catch (_) {
      return null;
    }
  }

  String getCategoryName(List<CategoryModel> categories) {
    final category = categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => CategoryModel(id: "", name: "-", imageUrl: ""),
    );
    return category.name;
  }
}