part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishlist extends WishlistEvent {

}

class AddWishlistProduct extends WishlistEvent {
  const AddWishlistProduct(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

class RemoveWishlistProduct extends WishlistEvent {
  const RemoveWishlistProduct(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}