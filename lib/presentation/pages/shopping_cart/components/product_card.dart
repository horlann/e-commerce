import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/product.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
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
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: SizedBox(
            width: 100,
            height: 100,
            child: CustomImageProvider(
              imageLink: product.image,
              imageFrom: ImageFrom.network,
            ),
          ),
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
                    product.title,
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
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: theme.inactiveTextColor),
                ),
                const SizedBox(width: 5),
                Text(
                  "x ${product.count}",
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
