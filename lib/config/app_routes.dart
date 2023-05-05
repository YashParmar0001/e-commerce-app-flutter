import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/auth_screen.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/catalog_screen.dart';
import 'package:ecommerce_app/screens/checkout_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/log_in_screen.dart';
import 'package:ecommerce_app/screens/payment_selection_screen.dart';
import 'package:ecommerce_app/screens/product_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:ecommerce_app/screens/register_screen.dart';
import 'package:ecommerce_app/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';

import 'dart:developer' as dev;

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    dev.log('This is route: ${settings.name}', name: 'Router');

    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case AuthScreen.routeName:
        return AuthScreen.route();
      case LogInScreen.routeName:
        return LogInScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case PaymentSelectionScreen.routeName:
        return PaymentSelectionScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(appBar: AppBar(title: Text('Error'),))
    );
  }
}