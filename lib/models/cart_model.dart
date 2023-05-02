import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({this.products = const <Product>[]});

  final List<Product> products;

  Map productQuantity(List<Product> products) {
    var quantity = Map();

    for (var product in products) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    }

    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, product) => total + product.price);

  String get subtotalString => '\$${subtotal.toStringAsFixed(2)}';

  double deliveryFee(subtotal) {
    if (subtotal >= 30) {
      return 0;
    } else {
      return 10;
    }
  }

  String get deliveryFeeString =>
      '\$${deliveryFee(subtotal).toStringAsFixed(2)}';

  String freeDelivery(subtotal) {
    if (subtotal >= 30) {
      return 'You have Free Delivery';
    } else {
      double missing = 30.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  double get total => subtotal + deliveryFee(subtotal);

  String get totalString => '\$${total.toStringAsFixed(2)}';

  String get freeDeliveryString => freeDelivery(subtotal);

  static List<Product> demoProducts = [
    Product(
      id: '0',
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
      //https://unsplash.com/photos/Viy_8zHEznk
      price: 24.02,
      isRecommended: false,
      isPopular: true,
    ),
    Product(
        id: '1',
        name: 'Water #1',
        category: 'Water',
        imageUrl:
            'https://media.istockphoto.com/id/1453888693/photo/modern-water-bottle-with-snail-shell-on-white-background.jpg?s=2048x2048&w=is&k=20&c=lDcbVQfPOIeqxASPNDXGjBrIw2D1W2wMkV99ZC4ThrE=',
        price: 3.00,
        isRecommended: true,
        isPopular: true)
  ];

  @override
  List<Object?> get props => [products];
}
