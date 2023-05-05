import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(
      (event, emit) => _onAddProduct(event, state, emit),
    );
    on<RemoveProduct>(
      (event, emit) => _onRemoveProduct(event, state, emit),
    );
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    developer.log('Loading cart...', name: 'CartState');
    emit(CartLoading());
    try {
      emit(const CartLoaded(cart: Cart(products: <Product>[])));
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(
      AddProduct event, CartState state, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      developer.log('Adding product...', name: 'CartState');
      // state.cart.products.add(event.product);
      emit(CartLoaded(
          cart: Cart(
              products: List.from(state.cart.products)..add(event.product))));
    }
  }

  void _onRemoveProduct(
      RemoveProduct event, CartState state, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      emit(CartLoaded(
          cart: Cart(
              products: List.from(state.cart.products)
                ..remove(event.product))));
    }
  }
}
