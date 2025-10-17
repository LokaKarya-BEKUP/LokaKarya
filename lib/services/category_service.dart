import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lokakarya/data/model/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CategoryModel>> getCategoriesStream() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<CategoryModel?> getCategoryById(String categoryId) async {
    try {
      final doc = await _firestore
          .collection('categories')
          .doc(categoryId)
          .get();
      if (doc.exists) {
        return CategoryModel.fromFirestore(doc);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
