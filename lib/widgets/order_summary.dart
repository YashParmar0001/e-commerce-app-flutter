import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if (state is CartLoaded) {
          return Column(
            children: [
              Divider(
                thickness: 3,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUBTOTAL',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      state.cart.subtotalString,
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DELIVERY FEE',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      state.cart.deliveryFeeString,
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Stack(
                  children: [
                    Container(
                      height: 60,
                      color: Colors.black.withAlpha(50),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 50,
                      color: Colors.black,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TOTAL',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              state.cart.totalString,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }else {
          return Center(
            child: Text('Something went wrong!'),
          );
        }
      },
    );
  }
}
