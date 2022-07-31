import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

import 'cart_product_card.dart';

class FilledCartPage extends StatelessWidget {
  const FilledCartPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final List<CartItem> cartItems = cartBloc.cartItems;

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
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.monitor_heart,
                      label: 'add_to_favorite',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      onPressed: (context) {
                        cartBloc.add(RemoveFromCartEvent(cartItems[index].item));
                      },
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.remove,
                      label: 'Remove',
                    ),
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: 'Save',
                    ),
                  ],
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
        ),
      ],
    );
  }
}

class _FilledCartPage extends StatefulWidget {
  const _FilledCartPage({Key? key, required this.cartItems}) : super(key: key);
  final List<CartItem> cartItems;

  @override
  State<_FilledCartPage> createState() => _FilledCartPageState();
}

class _FilledCartPageState extends State<_FilledCartPage> {
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    for (var element in widget.cartItems) {
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
                  callback: () {
                    BlocProvider.of<CartBloc>(context).add(const CheckoutEvent());
                  },
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
