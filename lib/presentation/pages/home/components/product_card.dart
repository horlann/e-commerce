import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
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
        height: adaptiveHeight(110),
        width: adaptiveWidth(400),
        decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: theme.mainTextColor, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: CustomImageProvider(imageLink: product.imageLink, imageFrom: ImageFrom.network),
                ),
              ),
            ),
            SizedBox(height: adaptiveWidth(10)),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: adaptiveHeight(10)),
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
                        SizedBox(height: adaptiveHeight(10)),
                        Text(
                          "\₴${product.price.toStringAsFixed(0)}",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: theme.infoTextColor),
                        ),
                        SizedBox(height: adaptiveHeight(10)),
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
