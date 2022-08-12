import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class AdminOrderListTile extends StatefulWidget {
  const AdminOrderListTile({Key? key, required this.order}) : super(key: key);
  final OrderEntity order;

  @override
  State<AdminOrderListTile> createState() => _AdminOrderListTileState();
}

class _AdminOrderListTileState extends State<AdminOrderListTile> {
  final ExpandedTileController _expandedTileController = ExpandedTileController(isExpanded: false);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return Container(
      decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: theme.mainTextColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: ExpandedTile(
        theme: const ExpandedTileThemeData(
            headerPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            leadingPadding: EdgeInsets.zero,
            contentRadius: 16,
            headerRadius: 16,
            trailingPadding: EdgeInsets.zero),
        leading: const SizedBox.shrink(),
        contentSeperator: 0,
        controller: _expandedTileController,
        content: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: SizedBox(
            height: 300,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                widget.order.number.toString(),
                style: theme.fontStyles.semiBold18.copyWith(color: theme.mainTextColor),
              ),
              SizedBox(width: adaptiveWidth(10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.order.items
                    .map((e) => Row(
                          children: [
                            Text(
                              '${e.item.name} \n(${e.itemSettings.name}) ',
                              style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
                            ),
                            Text(
                              '${e.count} * ${e.item.price.toStringAsFixed(0)}',
                              style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
                            ),
                          ],
                        ))
                    .toList(),
              ),
              const Spacer(),
              Text(
                widget.order.deliveryDetails.deliveryType.name,
                style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
              ),
              const Spacer(),
              Text(
                '₴${widget.order.priceDetails.itemsPrice.toStringAsFixed(0)}',
                style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
