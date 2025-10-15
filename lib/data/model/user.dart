import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Membuat UserModel dari Firebase User
  factory UserModel.fromFirebaseUser(User? user) {
    if (user == null) return UserModel();
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
      createdAt: Timestamp.now(),
    );
  }

  /// Mapping data JSON menjadi objek UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt']
          : Timestamp.now(),
      updatedAt: json['updatedAt'] is Timestamp
          ? json['updatedAt']
          : Timestamp.now(),
    );
  }

  /// Mapping UserModel menjadi data JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': createdAt ?? Timestamp.now(),
      'updatedAt': updatedAt ?? Timestamp.now(),
    };
  }

  /// Method untuk update sebagian data user
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
