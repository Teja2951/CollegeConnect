import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String uid;
  final String email;
  final String name;
  final String role;
  final String password;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.password,
  });


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "role": role,
      "password": password,
    };
  }


  Future<UserModel?> getUserData(String uid) async {
  DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

  if (doc.exists) {
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  } else {
    return null;
  }
}

}
