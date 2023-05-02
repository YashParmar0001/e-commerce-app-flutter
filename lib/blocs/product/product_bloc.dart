import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/product/product_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepository productRepository}) : _productRepository = productRepository, super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen((products) {
      add(UpdateProducts(products: products));
    });
  }

  void _onUpdateProducts(UpdateProducts event, Emitter<ProductState> emit) {
    emit(ProductLoaded(products: event.products));
  }
}
