import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';
import 'package:kurilki/presentation/bloc/cart/cart_state.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'components/cart_product_card.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = Provider.of<ThemesBloc>(context).theme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: theme.backgroundColor)),
        centerTitle: true,
        backgroundColor: theme.accentColor,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is InProgressCartState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoadedState) {
            List<CartItem> cartItems = state.cartItems;
            if (cartItems.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Lottie.asset('assets/animations/empty_cart.json'),
                    flex: 2,
                  ),
                  Expanded(
                    child: Text(
                      'Cart is Empty',
                      style: TextStyle(color: theme.infoTextColor, fontSize: 21, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cartItems.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: ValueKey(index),
                          child: CartProductCard(
                            cartItem: cartItems[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _FilledCartPage(
                    cartItems: cartItems,
                  )
                ],
              );
            }
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}

class _FilledCartPage extends StatelessWidget {
  _FilledCartPage({Key? key, required this.cartItems}) : super(key: key);
  final List<CartItem> cartItems;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = Provider.of<ThemesBloc>(context).theme;
    for (var element in cartItems) {
      totalPrice += element.count * element.item.price;
    }
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: theme.backgroundColor,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                "Total: ${totalPrice.toStringAsFixed(0)}\$",
                style: TextStyle(color: theme.infoTextColor, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: MainRoundedButton(
                  callback: () {},
                  color: theme.accentColor,
                  text: 'Check Out',
                  paddingVert: 14,
                  round: 24,
                  theme: theme,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
