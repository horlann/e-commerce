import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/item.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';
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
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return InkWell(
      onTap: () {
        // AutoRouter.of(context).push(DetailsRouter(product: product));
      },
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
            child: CustomImageProvider(imageLink: product.imageLink, imageFrom: ImageFrom.network),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  AutoSizeText(
                    product.name,
                    maxLines: 2,
                    minFontSize: 14,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: theme.infoTextColor,
                    ),
                  ),
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
