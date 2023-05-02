import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../models/product_model.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      key: UniqueKey(),
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if (state is CartLoaded) {
          print('Rebuilding the CartLoaded state!');
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 7),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  height: 90,
                  width: 130,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(RemoveProduct(product));
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Removed from cart!'))
                    );
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$quantity',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(AddProduct(product));
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart!'))
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          );
        }else {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
      },
    );
  }
}
