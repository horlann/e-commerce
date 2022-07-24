import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/item.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/Image_provider.dart';

class ProductCard extends StatelessWidget {
  final Item product;
  final AbstractTheme theme;
  final double width;

  const ProductCard({
    Key? key,
    required this.product,
    required this.theme,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
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
                SizedBox(
                  width: width - 180,
                  child: AutoSizeText(
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
                ),
                IconButton(
                  icon: const Icon((Icons.close)),
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: theme.backgroundColor),
                ),
                const SizedBox(width: 10),
                Text(
                  "x 1",
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: theme.inactiveTextColor),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
