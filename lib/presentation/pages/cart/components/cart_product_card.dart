import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class CartProductCard extends StatelessWidget {
  final CartItem cartItem;

  const CartProductCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Item product = cartItem.item;
    final AbstractItemSettings settings = cartItem.itemSettings.type == ItemSettingsType.filled
        ? (cartItem.itemSettings as ItemSettings)
        : (cartItem.itemSettings as NoItemSettings);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 90.0,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: CustomImageProvider(
                imageLink: (settings is! NoItemSettings) ? (settings as ItemSettings).imageLink : product.imageLink,
                imageFrom: ImageFrom.network),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  AutoSizeText(
                    product.name,
                    maxLines: 2,
                    minFontSize: 15,
                    maxFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: theme.infoTextColor,
                    ),
                  ),
                  SizedBox(
                    width: adaptiveWidth(10),
                  ),
                  AutoSizeText(
                    settings.name,
                    maxLines: 2,
                    minFontSize: 15,
                    maxFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: theme.infoTextColor,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                "\$${product.price.toStringAsFixed(0)} * ${cartItem.count}=${(product.price * cartItem.count).toStringAsFixed(0)}",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: theme.infoTextColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
