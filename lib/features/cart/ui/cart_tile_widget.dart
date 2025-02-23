import 'package:flutter/material.dart';
import 'package:flutter_grocery_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_grocery_app/features/home/models/home_product_data_model.dart';

class CartTileWidget extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductDataModel productDataModel;

  const CartTileWidget({super.key,
    required this.cartBloc,
    required this.productDataModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    productDataModel.imageUrl,
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            child: Text(
              productDataModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              productDataModel.description,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  '\$ ${productDataModel.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      cartBloc.add(CartRemoveItemEvent(productDataModel: productDataModel));
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
