import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/local_storage/local_storage_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../models/wishlist_model.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/models/product_model.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<StartWishlist>(onStartWishlist);
    on<AddWishlistProduct>(
      (event, emit) => onAddWishlist(event, state, emit),
    );
    on<RemoveWishlistProduct>(
      (event, emit) {
        onRemoveWishlist(event, state, emit);
      },
    );
  }

  final LocalStorageRepository _localStorageRepository;

  Future<void> onStartWishlist(
      StartWishlist event, Emitter<WishlistState> emit) async {
    print('Wishlist is loading...');
    emit(WishlistLoading());
    try {
      Hive.registerAdapter(ProductAdapter());
      Box box = await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishlist(box);

      await Future<void>.delayed(const Duration(seconds: 1));
      emit(WishlistLoaded(wishlist: Wishlist(products: products)));
    } catch (_) {}
  }

  Future<void> onAddWishlist(AddWishlistProduct event, WishlistState state,
      Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        print('Adding new product...');
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishlist(box, event.product);

        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..add(event.product))));
        print('Added new product!');
      } catch (_) {}
    }
  }

  Future<void> onRemoveWishlist(RemoveWishlistProduct event,
      WishlistState state, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductFromWishlist(box, event.product);
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..remove(event.product))));
      } catch (_) {}
    }
  }

  @override
  void onChange(Change<WishlistState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onTransition(Transition<WishlistEvent, WishlistState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
