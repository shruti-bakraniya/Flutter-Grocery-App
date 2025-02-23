import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grocery_app/features/cart/ui/cart.dart';
import 'package:flutter_grocery_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_grocery_app/features/home/ui/product_tile_widget.dart';
import 'package:flutter_grocery_app/features/wishlist/ui/wishlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is !HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToWishlistPageActionState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Wishlist(),
              ),
            );
          } else if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ),
            );
          } else if (state is HomeProductItemCartedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added to cart")),
            );
          } else if (state is HomeProductItemWishlistedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added to wishlist")),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (HomeLoadingState):
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case const (HomeLoadedSuccessState):
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Grocery App',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                    ),
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      homeBloc: homeBloc,
                      productDataModel: successState.products[index],
                    );
                  },
                ),
              );
            case const (HomeErrorState):
              return const Scaffold(
                body: Center(
                  child: Text('Error'),
                ),
              );
            default:
              return const SizedBox();
          }
        });
  }
}
