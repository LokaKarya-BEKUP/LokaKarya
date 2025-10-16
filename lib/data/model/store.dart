import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String id;
  final String name;
  final String city;
  final String phone;
  final String? imageUrl;

  Store({
    required this.id,
    required this.name,
    required this.city,
    required this.phone,
    this.imageUrl,
  });

  factory Store.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Store(
      id: doc.id,
      name: data['name'] ?? '',
      city: data['city'] ?? '',
      phone: data['phone'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }
}
