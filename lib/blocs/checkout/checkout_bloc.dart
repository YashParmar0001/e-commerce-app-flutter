import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/checkout/checkout_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';
import '../../models/checkout_model.dart';
import '../../models/product_model.dart';
import '../cart/cart_bloc.dart';

import 'dart:developer' as developer;

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(
      {required CartBloc cartBloc,
      required CheckoutRepository checkoutRepository})
      : _cartBloc = cartBloc, _checkoutRepository = checkoutRepository, super(
      (cartBloc.state is CartLoaded) ? CheckoutLoaded(
        products: (cartBloc.state as CartLoaded).cart.products,
        subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
        deliveryFee: (cartBloc.state as CartLoaded).cart.deliveryFeeString,
        total: (cartBloc.state as CartLoaded).cart.totalString
      ) : CheckoutLoading()
  ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _cartSubscription = cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(UpdateCheckout(cart: state.cart));
      }
    });
  }

  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  void _onUpdateCheckout(UpdateCheckout event, Emitter<CheckoutState> emit) {
    if (state is CheckoutLoaded) {
      final loadedState = (state as CheckoutLoaded);
      emit(CheckoutLoaded(
        fullName: event.fullName ?? loadedState.fullName,
        email: event.email ?? loadedState.email,
        address: event.address ?? loadedState.address,
        city: event.city ?? loadedState.city,
        country: event.country ?? loadedState.country,
        zipcode: event.zipcode ?? loadedState.zipcode,
        products: event.cart?.products ?? loadedState.products,
        subtotal: event.cart?.subtotalString ?? loadedState.subtotal,
        deliveryFee: event.cart?.deliveryFeeString ?? loadedState.deliveryFee,
        total: event.cart?.totalString ?? loadedState.total
      ));
    }
  }

  Future<void> _onConfirmCheckout(ConfirmCheckout event, Emitter<CheckoutState> emit) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        developer.log('Added checkout', name: 'CheckoutState');
      } catch (_) {}
    }
  }
}
