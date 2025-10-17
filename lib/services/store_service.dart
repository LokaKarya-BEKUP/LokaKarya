import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lokakarya/data/model/store.dart';

class StoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Store>> getStoresStream() {
    return _firestore.collection('stores').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Store.fromFirestore(doc)).toList();
    });
  }

  Future<Store?> getStoreById(String storeId) async {
    try {
      final doc = await _firestore.collection('stores').doc(storeId).get();
      if (doc.exists) {
        return Store.fromFirestore(doc);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
