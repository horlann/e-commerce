import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/domain/entities/user/history_item.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class HistoryProductCard extends StatelessWidget {
  const HistoryProductCard({Key? key, required this.product}) : super(key: key);
  final HistoryItem product;

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Padding(
      padding: EdgeInsets.only(bottom: adaptiveHeight(5)),
      child: Container(
        height: adaptiveHeight(70),
        width: adaptiveWidth(350),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: theme.mainTextColor, width: 1),
          boxShadow: [theme.appShadows.largeShadow],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(9.0), bottomLeft: Radius.circular(9.0)),
                child: Container(
                  color: theme.whiteTextColor,
                  child: CustomImageProvider(imageLink: product.itemSettings.imageLink, imageFrom: ImageFrom.network),
                ),
              ),
            ),
            SizedBox(height: adaptiveWidth(10)),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(adaptiveWidth(8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: adaptiveWidth(260),
                          child: AutoSizeText(
                            product.itemSettings.name != Const.empty
                                ? "${product.item.name} (${product.itemSettings.name})"
                                : product.item.name,
                            maxLines: 2,
                            minFontSize: 14,
                            maxFontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                          ),
                        ),
                        Text("₴ ${product.item.price.toStringAsFixed(0)}",
                            style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor)),
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
