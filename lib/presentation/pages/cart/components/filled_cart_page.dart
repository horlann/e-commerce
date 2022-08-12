import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/animations.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:lottie/lottie.dart';

import 'cart_product_card.dart';

class FilledCartPage extends StatelessWidget {
  const FilledCartPage({Key? key, required this.cartItems}) : super(key: key);
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Container(
      color: theme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: adaptiveWidth(8.0)),
                itemCount: cartItems.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: adaptiveWidth(16.0)),
                    child: Slidable(
                      key: ValueKey(index),
                      child: CartProductCard(
                        cartItem: cartItems[index],
                        index: index,
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: adaptiveWidth(0.32),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [theme.appShadows.largeShadow],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: Material(
                                  color: theme.wrongColor,
                                  child: InkWell(
                                    onTap: () {
                                      cartBloc.add(RemoveFromCartEvent(cartItems[index].item));
                                    },
                                    child: Container(
                                      height: adaptiveHeight(120),
                                      width: adaptiveWidth(100),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: theme.mainTextColor, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Center(
                                        child: SizedBox(
                                          height: adaptiveHeight(38),
                                          child: Lottie.asset(
                                            CustomAnimations.trashcan,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: adaptiveHeight(16));
                },
              ),
            ),
            SizedBox(height: adaptiveHeight(10)),
            _FilledCartPage(cartItems: cartItems),
          ],
        ),
      ),
    );
  }
}

class _FilledCartPage extends StatelessWidget {
  const _FilledCartPage({Key? key, required this.cartItems}) : super(key: key);
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: adaptiveWidth(16)),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                '${Strings.priceItems}:',
                style: theme.fontStyles.semiBold18.copyWith(color: theme.mainTextColor),
              ),
              SizedBox(width: adaptiveWidth(5)),
              Text(
                "₴${cartBloc.priceDetails.itemsPrice.toStringAsFixed(0)}",
                style: theme.fontStyles.semiBold18.copyWith(color: theme.mainTextColor),
              ),
            ],
          ),
          SizedBox(height: adaptiveHeight(10)),
          MainRoundedButton(
            callback: () {
              accountBloc.add(const LoadDataEvent());
              context.pushRoute(const OrderConfirmationRouter());
            },
            textStyle: TextStyle(color: theme.whiteTextColor, fontSize: 17, fontWeight: FontWeight.w500),
            color: theme.mainTextColor,
            text: Strings.checkOutButton,
            paddingVert: 14,
            round: 24,
            theme: theme,
          ),
          SizedBox(height: adaptiveHeight(10)),
        ],
      ),
    );
  }
}
