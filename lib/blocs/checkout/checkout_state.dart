part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  CheckoutLoaded(
      {this.fullName,
      this.email,
      this.address,
      this.city,
      this.country,
      this.zipcode,
      this.products,
      this.subtotal,
      this.deliveryFee,
      this.total})
      : checkout = Checkout(
            fullName: fullName,
            email: email,
            address: address,
            city: city,
            country: country,
            zipcode: zipcode,
            products: products,
            subtotal: subtotal,
            deliveryFee: deliveryFee,
            total: total);

  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipcode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final Checkout checkout;

  @override
  List<Object?> get props => [
    fullName,
    email,
    address,
    city,
    country,
    zipcode,
    products,
    subtotal,
    deliveryFee,
    total
  ];
}
