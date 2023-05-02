import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  const Wishlist({this.products = const <Product>[]});

  // Wishlist.newProduct(this.products) {
  //   print('New product wishlist is generating!');
  // }

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}