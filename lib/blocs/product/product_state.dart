part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  ProductLoaded({this.products = const <Product>[]});

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}