import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
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
        height: adaptiveHeight(120),
        width: adaptiveWidth(400),
        decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: theme.mainTextColor, width: 1),
            boxShadow: [theme.appShadows.largeShadow],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(9.0), bottomLeft: Radius.circular(9.0)),
                child: Container(
                    color: theme.whiteTextColor,
                    child: CustomImageProvider(imageLink: product.imageLink, imageFrom: ImageFrom.network)),
              ),
            ),
            SizedBox(height: adaptiveWidth(10)),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(adaptiveWidth(8.0)),
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
                              style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                            ),
                          ],
                        ),
                        SizedBox(height: adaptiveHeight(10)),
                        Text(
                          "₴${product.price.toStringAsFixed(0)}",
                          style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                        ),
                        SizedBox(height: adaptiveHeight(10)),
                        Text(
                          "${product.itemSettings.length} ${Strings.availableTastes}",
                          style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
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
