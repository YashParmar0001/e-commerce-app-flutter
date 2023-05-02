part of 'checkout_bloc.dart';

class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  UpdateCheckout(
      {this.fullName,
      this.email,
      this.address,
      this.city,
      this.country,
      this.zipcode,
      this.cart});

  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipcode;
  final Cart? cart;

  @override
  List<Object?> get props =>
      [fullName, email, address, city, country, zipcode, cart];
}

class ConfirmCheckout extends CheckoutEvent {
  ConfirmCheckout({required this.checkout});

  final Checkout checkout;

  @override
  List<Object?> get props => [checkout];
}
