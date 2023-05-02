import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/widgets/custom_appbar.dart';
import 'package:ecommerce_app/widgets/google_pay.dart';
import 'package:ecommerce_app/widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/checkout/checkout_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => CheckoutScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CheckoutLoaded) {
            return SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildHeader(context, 'CUSTOMER INFORMATION'),
                    _buildTextField(
                        context,
                        'Email',
                        (value) => context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(email: value))),
                    _buildTextField(
                        context,
                        'Full name',
                        (value) => context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(fullName: value))),
                    _buildHeader(context, 'DELIVERY INFORMATION'),
                    _buildTextField(
                        context,
                        'Address',
                        (value) => context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(address: value))),
                    _buildTextField(
                        context,
                        'City',
                        (value) => context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(city: value))),
                    _buildTextField(
                        context,
                        'Country',
                        (value) => context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(country: value))),
                    _buildTextField(
                        context,
                        'Zip code',
                        (value) => context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(zipcode: value))),
                    _buildHeader(context, 'ORDER SUMMARY'),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/payment-selection');
                      },
                      child: Container(
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
                              color: Colors.black.withAlpha(170),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'SELECT PAYMENT METHOD',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.double_arrow_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    OrderSummary(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CheckoutLoaded) {
                return Center(
                    child: GooglePay(
                  total: state.total!,
                  products: state.products!,
                ));
              } else {
                return const Text(
                  'Error',
                  style: TextStyle(color: Colors.white),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context, String title, Function(String)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
              width: 75,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              )),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
