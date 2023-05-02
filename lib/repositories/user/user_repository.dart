import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/repositories/user/base_user_repository.dart';
import 'dart:developer' as developer;

class UserRepository extends BaseUserRepository {
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toDocument());
  }

  @override
  Stream<User> getUser(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((
        snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> updateUser(User user) async {
    return _firestore.collection('users').doc(user.id).update(user.toDocument())
        .then((value) => developer.log('Updated successfully'));
  }
}
