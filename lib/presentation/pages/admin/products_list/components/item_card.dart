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

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return InkWell(
      onTap: () => AutoRouter.of(context).navigate(EditItemRouter(item: item)),
      child: Container(
        width: double.infinity,
        height: 90,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: theme.mainTextColor, width: 1),
            boxShadow: [theme.appShadows.largeShadow],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
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
                  child: CustomImageProvider(imageLink: item.imageLink, imageFrom: ImageFrom.network),
                ),
              ),
            ),
            SizedBox(
              width: adaptiveWidth(10),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "${Strings.nameItem}: ${item.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.fontStyles.semiBold16,
                  ),
                  const SizedBox(height: 2),
                  AutoSizeText(
                    "${Strings.priceItem}: ${item.price.toStringAsFixed(0)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: theme.mainTextColor, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
