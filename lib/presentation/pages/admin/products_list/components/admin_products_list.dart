import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_event.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/item_card.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key, required this.items}) : super(key: key);
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminItemBloc itemBloc = BlocProvider.of<AdminItemBloc>(context);
    bool confirmDeletion = false;

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(index),
          child: ItemCard(
            item: items[index],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: adaptiveWidth(0.3),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [theme.appShadows.largeShadow],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Material(
                      color: theme.cardColor,
                      child: InkWell(
                        onTap: () {
                          if (!confirmDeletion) {
                            CustomSnackBar.showSnackNar(context, Strings.warning, Strings.clickDoubleTapToConfirm);
                            confirmDeletion = !confirmDeletion;
                          }
                        },
                        onDoubleTap: () {
                          if (confirmDeletion) {
                            itemBloc.add(RemoveItemEvent(items[index]));
                            confirmDeletion = !confirmDeletion;
                          }
                        },
                        child: Container(
                          height: adaptiveHeight(95),
                          width: adaptiveWidth(95),
                          decoration: BoxDecoration(
                              border: Border.all(color: theme.mainTextColor, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              Strings.removeButton,
                              style: theme.fontStyles.semiBold14.copyWith(color: theme.mainTextColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
