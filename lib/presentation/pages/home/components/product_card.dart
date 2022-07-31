import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class ProductCard extends StatelessWidget {
  final Item product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(DetailsRouter(product: product));
      },
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: theme.inactiveColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: CustomImageProvider(imageLink: product.imageLink, imageFrom: ImageFrom.network),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                          "\₴${product.price.toStringAsFixed(0)}",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: theme.infoTextColor),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${product.itemSettings.length} доступных вкусов",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: theme.infoTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
