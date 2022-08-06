import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

import 'cart_product_card.dart';

class FilledCartPage extends StatelessWidget {
  const FilledCartPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final List<CartItem> cartItems = cartBloc.cartItems;

    return Container(
      color: theme.backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cartItems.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(adaptiveWidth(16.0)),
                  child: Slidable(
                    key: ValueKey(index),
                    child: CartProductCard(
                      cartItem: cartItems[index],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
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
                                color: theme.cardColor,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: adaptiveHeight(120),
                                    width: adaptiveWidth(100),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: theme.mainTextColor, width: 1),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        Strings.removeButton,
                                        style: theme.fontStyles.semiBold14.copyWith(color: theme.mainTextColor),
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
          _FilledCartPage(cartItems: cartItems),
        ],
      ),
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
    final bloc = BlocProvider.of<CartBloc>(context);

    for (var element in widget.cartItems) {
      totalPrice += element.count * element.item.price;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: adaptiveWidth(16)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                Strings.total,
                style: theme.fontStyles.regular18.copyWith(color: theme.inactiveTextColor),
              ),
              SizedBox(width: adaptiveWidth(5)),
              Expanded(
                  child: SizedBox(
                child: Divider(
                  color: theme.inactiveTextColor,
                  thickness: adaptiveHeight(0.4),
                  height: adaptiveHeight(10),
                ),
              )),
              SizedBox(width: adaptiveWidth(5)),
              Text(
                "\$${totalPrice.toStringAsFixed(0)}",
                style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
              ),
            ],
          ),
          SizedBox(height: adaptiveHeight(10)),
          MainRoundedButton(
            callback: () {
              bloc.add(const LoadDataEvent());
              AutoRouter.of(context).push(const OrderConfirmationRouter());
            },
            textStyle: TextStyle(color: theme.whiteTextColor, fontSize: 17, fontWeight: FontWeight.w500),
            color: theme.infoTextColor,
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
