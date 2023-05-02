import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/checkout_model.dart';
import 'package:ecommerce_app/repositories/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  CheckoutRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firestore.collection('checkout').add(checkout.toDocument());
  }
}
