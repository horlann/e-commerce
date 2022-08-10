import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class PopularProductCard extends StatelessWidget {
  final ItemSettings itemSettings;
  final Item item;

  const PopularProductCard({
    Key? key,
    required this.itemSettings,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return InkWell(
      onTap: () {
        final int itemConfiguration = item.itemSettings.indexWhere((element) => element == itemSettings);
        AutoRouter.of(context).push(DetailsRouter(product: item, itemConfiguration: itemConfiguration));
      },
      child: Container(
        height: adaptiveHeight(110),
        width: adaptiveWidth(220),
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
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomImageProvider(imageLink: itemSettings.imageLink, imageFrom: ImageFrom.network),
                ),
              ),
            ),
            SizedBox(height: adaptiveWidth(10)),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(adaptiveWidth(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        itemSettings.name,
                        maxLines: 2,
                        minFontSize: 15,
                        maxFontSize: 18,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
                      ),
                    ),
                    Divider(
                      color: theme.mainTextColor,
                      thickness: adaptiveHeight(0.6),
                      height: adaptiveHeight(10),
                    ),
                    Text(
                      "\₴${item.price.toStringAsFixed(0)}",
                      style: theme.fontStyles.semiBold16.copyWith(color: theme.infoTextColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
