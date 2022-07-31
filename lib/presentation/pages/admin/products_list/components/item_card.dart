import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';

import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);

    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: theme.inactiveColor),
          boxShadow: [theme.appShadows.mediumShadow]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Material(
          color: theme.accentColor,
          child: SizedBox(
            height: 50,
            child: InkWell(
              onTap: () => AutoRouter.of(context).push(EditItemRouter(item: item)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "Name: ${item.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.fontStyles.semiBold16,
                  ),
                  const SizedBox(height: 2),
                  AutoSizeText(
                    "Price: ${item.price.toStringAsFixed(0)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: theme.mainTextColor, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
