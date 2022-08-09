import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class CartProductCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;

  const CartProductCard({
    Key? key,
    required this.cartItem,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Item product = cartItem.item;
    final AbstractItemSettings settings = cartItem.itemSettings is ItemSettings
        ? (cartItem.itemSettings as ItemSettings)
        : (cartItem.itemSettings as NoItemSettings);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return InkWell(
      onTap: () {},
      child: Container(
        height: adaptiveHeight(120),
        width: adaptiveWidth(400),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: theme.mainTextColor, width: 1),
          boxShadow: [theme.appShadows.largeShadow],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(9.0), bottomLeft: Radius.circular(9.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: CustomImageProvider(
                    imageLink: (settings is ItemSettings) ? settings.imageLink : product.imageLink,
                    imageFrom: ImageFrom.network),
              ),
            ),
            SizedBox(height: adaptiveWidth(10)),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(adaptiveWidth(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: adaptiveHeight(5)),
                      SizedBox(
                        width: getScreenWidth - adaptiveWidth(180),
                        child: AutoSizeText(
                          (settings is ItemSettings) ? "${product.name} (${settings.name})" : product.name,
                          maxLines: 2,
                          minFontSize: 14,
                          maxFontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                        ),
                      ),
                      SizedBox(height: adaptiveHeight(5)),
                      Expanded(
                        child: Text(
                          "\$${product.price.toStringAsFixed(0)}",
                          style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                        ),
                      ),
                      SizedBox(height: adaptiveHeight(5)),
                      Row(
                        children: [
                          _RoundButton(
                            cartItem: cartItem,
                            type: "+",
                            index: index,
                          ),
                          SizedBox(
                            width: adaptiveWidth(5),
                          ),
                          Text(
                            "${cartItem.count}",
                            style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                          ),
                          SizedBox(
                            width: adaptiveWidth(5),
                          ),
                          _RoundButton(
                            cartItem: cartItem,
                            type: "-",
                            index: index,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({Key? key, required this.cartItem, required this.type, required this.index}) : super(key: key);
  final CartItem cartItem;
  final String type;
  final int index;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Material(
        color: theme.cardColor,
        child: InkWell(
          onTap: () {
            if (cartItem.itemSettings is ItemSettings) {
              final int totalAvailable = (cartItem.itemSettings as ItemSettings).count;

              if (type == "+" && totalAvailable > cartItem.count) {
                bloc.add(ChangeItemCountEvent(cartItem.copyWith(count: cartItem.count + 1), index));
              } else if (type == "-" && cartItem.count > 1) {
                bloc.add(ChangeItemCountEvent(cartItem.copyWith(count: cartItem.count - 1), index));
              }
            } else if (cartItem.itemSettings is NoItemSettings) {
              if (type == "+") {
                bloc.add(ChangeItemCountEvent(cartItem.copyWith(count: cartItem.count + 1), index));
              } else if (type == "-" && cartItem.count > 1) {
                bloc.add(ChangeItemCountEvent(cartItem.copyWith(count: cartItem.count - 1), index));
              }
            }
          },
          child: Container(
            height: adaptiveHeight(35),
            width: adaptiveWidth(35),
            decoration: BoxDecoration(
                border: Border.all(color: theme.mainTextColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Center(
                child: Text(
              type,
              style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
            )),
          ),
        ),
      ),
    );
  }
}
