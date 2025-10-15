import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lokakarya/data/model/user.dart';

class FirestoreUserService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreUserService(FirebaseFirestore? firebaseFirestore)
    : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  CollectionReference get usersRef => _firebaseFirestore.collection('users');

  /// Menambah data user
  Future<void> createUser(UserModel user) async {
    await usersRef.doc(user.id).set(user.toJson());
  }

  /// Mendapatkan data user berdasarkan ID
  Future<UserModel?> getUserById(String userId) async {
    final doc = await usersRef.doc(userId).get();

    if (!doc.exists) return null;
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  /// Update nama user
  Future<void> updateUserName(String? userId, String newName) async {
    await usersRef.doc(userId).update({
      'name': newName,
      'updatedAt': Timestamp.now(),
    });
  }

  /// Cek user tersedia
  Future<bool> checkUserExists(String userId) async {
    final doc = await usersRef.doc(userId).get();
    return doc.exists;
  }
}
