import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';

import 'base_category_repository.dart';
import 'dart:developer' as developer;

class CategoryRepository extends BaseCategoryRepository {
  CategoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<Category>> getAllCategories() {
    developer.log('Getting category data from firestore: ${_firestore.collection('khkjhk').toString()}', name: 'CategoryState');
    // _firestore.collection('categories').doc('demo').set(
    //   <String, dynamic>{
    //     'name' : 'demo'
    //   }
    // );
    return _firestore.collection('categories').snapshots().map((snapshot) {
      developer.log('Got data from firestore: $snapshot', name: 'CategoryState');
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
}
