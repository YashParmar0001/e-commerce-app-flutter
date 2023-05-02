import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/product/base_product_repository.dart';

import 'dart:developer' as developer;

class ProductRepository extends BaseProductRepository {

  ProductRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<Product>> getAllProducts() {
    developer.log('Getting products from firestore...', name: 'ProductState');
    return _firestore.collection('products').snapshots().map((snapshot) {
      developer.log('Got product: ${snapshot.toString()}', name: 'ProductState');
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

}