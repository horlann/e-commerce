import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

class AdminOrderListTile extends StatefulWidget {
  const AdminOrderListTile({Key? key, required this.order}) : super(key: key);
  final OrderEntity order;

  @override
  State<AdminOrderListTile> createState() => _AdminOrderListTileState();
}

class _AdminOrderListTileState extends State<AdminOrderListTile> {
  final ExpandedTileController _expandedTileController = ExpandedTileController(isExpanded: false);
  late final OrderEntity _order;
  final DateFormat formatter = DateFormat(Const.longDateFormat);

  @override
  void initState() {
    super.initState();
    _order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminOrdersBloc ordersBloc = BlocProvider.of<AdminOrdersBloc>(context);

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
        content: ClipRRect(
          borderRadius: const BorderRadius.vertical(),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${Strings.orderCreatedAt}\n${formatter.format(_order.createdAt)}",
                    style: mainTextStyle(theme),
                  ),
                  if (_order.orderStatus == OrderStatus.completed)
                    Text(
                      "${Strings.orderCompletedAt}\n${formatter.format(_order.completedAt!)}",
                      style: mainTextStyle(theme),
                    )
                  else if (_order.orderStatus == OrderStatus.cancelled)
                    Text(
                      Strings.orderCanceled,
                      style: mainTextStyle(theme),
                    )
                  else
                    Column(
                      children: [
                        SizedBox(height: adaptiveHeight(5)),
                        Row(
                          children: [
                            if (_order.orderStatus == OrderStatus.created)
                              Flexible(
                                child: MainRoundedButton(
                                    text: Strings.inProgressOrderButton,
                                    textStyle: theme.fontStyles.regular16.copyWith(color: theme.whiteTextColor),
                                    color: theme.mainTextColor,
                                    callback: () {
                                      ordersBloc.add(
                                          ChangeOrderStatusEvent(_order.copyWith(orderStatus: OrderStatus.inProgress)));
                                    },
                                    theme: theme),
                              )
                            else if (_order.orderStatus == OrderStatus.inProgress)
                              Flexible(
                                child: MainRoundedButton(
                                    text: Strings.completeOrderButton,
                                    textStyle: theme.fontStyles.regular16.copyWith(color: theme.whiteTextColor),
                                    color: theme.mainTextColor,
                                    callback: () {
                                      ordersBloc.add(ChangeOrderStatusEvent(_order.copyWith(
                                        orderStatus: OrderStatus.completed,
                                        completedAt: DateTime.now(),
                                      )));
                                    },
                                    theme: theme),
                              ),
                            Flexible(child: SizedBox(width: adaptiveWidth(20))),
                            Flexible(
                              child: MainRoundedButton(
                                  text: Strings.cancelOrderButton,
                                  textStyle: theme.fontStyles.regular16.copyWith(color: theme.whiteTextColor),
                                  color: theme.mainTextColor,
                                  callback: () {
                                    ordersBloc.add(
                                        ChangeOrderStatusEvent(_order.copyWith(orderStatus: OrderStatus.cancelled)));
                                  },
                                  theme: theme),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const Divider(),
                  Text(
                    "${Strings.fullName}:\n${_order.deliveryDetails.name}",
                    style: mainTextStyle(theme),
                  ),
                  Text(
                    "${Strings.phoneNumber}:\n${_order.deliveryDetails.phone}",
                    style: mainTextStyle(theme),
                  ),
                  if (_order.deliveryDetails.deliveryType == DeliveryType.delivery)
                    Text(
                      "${Strings.orderDeliveryAddress}\n${_order.deliveryDetails.address}",
                      style: mainTextStyle(theme),
                    )
                  else if (_order.deliveryDetails.deliveryType == DeliveryType.pickUp)
                    Text(
                      Strings.orderPickUpAddress,
                      style: mainTextStyle(theme),
                    ),
                  const Divider(),
                  Text(
                    '${Strings.coupon}₴${_order.priceDetails.coupon.toStringAsFixed(0)}',
                    style: mainTextStyle(theme),
                  ),
                  Text(
                    '${Strings.deliveryPrice}₴${_order.priceDetails.deliveryPrice.toStringAsFixed(0)}',
                    style: mainTextStyle(theme),
                  ),
                  Text(
                    '${Strings.itemsPrice}₴${_order.priceDetails.itemsPrice.toStringAsFixed(0)}',
                    style: mainTextStyle(theme),
                  ),
                  Text(
                    '${Strings.totalPrice}: ₴${_order.priceDetails.totalPrice.toStringAsFixed(0)}',
                    style: mainTextStyle(theme),
                  ),
                ],
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              _order.number.toString(),
              style: theme.fontStyles.semiBold18.copyWith(color: theme.mainTextColor),
            ),
            SizedBox(width: adaptiveWidth(10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _order.items
                  .map((e) => SizedBox(
                        width: getScreenWidth - adaptiveWidth(135),
                        child: Row(
                          children: [
                            Text(
                              '${e.item.name}\n(${e.itemSettings.name}) ',
                              style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              '${e.count} x ${e.item.price.toStringAsFixed(0)}',
                              style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const Spacer(),
            if (_order.orderStatus == OrderStatus.created)
              const Icon(Icons.create)
            else if (_order.orderStatus == OrderStatus.inProgress)
              const Icon(Icons.update)
            else if (_order.orderStatus == OrderStatus.completed)
              const Icon(Icons.flag_circle_rounded)
            else if (_order.orderStatus == OrderStatus.cancelled)
              const Icon(Icons.cancel)
          ],
        ),
      ),
    );
  }

  TextStyle mainTextStyle(AbstractTheme theme) {
    return theme.fontStyles.regular16.copyWith(color: theme.mainTextColor);
  }
}
