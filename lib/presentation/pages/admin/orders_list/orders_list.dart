import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_state.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.orders,
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.mainTextColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: BlocBuilder<AdminOrdersBloc, AdminOrdersState>(
        builder: (context, state) {
          if (state is NewOrderState) {
            List<OrderEntity> orders = state.orders;
            return orders.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _AdminOrderListTile(order: orders[index]),
                    itemCount: orders.length,
                  )
                : const Text(Strings.emptyText);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _AdminOrderListTile extends StatelessWidget {
  const _AdminOrderListTile({Key? key, required this.order}) : super(key: key);
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return Card(
      child: Row(
        children: [
          Text(
            order.number.toString(),
            style: theme.fontStyles.semiBold18.copyWith(color: theme.mainTextColor),
          ),
          SizedBox(width: adaptiveWidth(10)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: order.items
                .map((e) => Text(
                      '${e.item.name} *${e.count}',
                      style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
                    ))
                .toList(),
          ),
          const Spacer(),
          Text(
            order.deliveryDetails.deliveryType.name,
            style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
          ),
          SizedBox(width: adaptiveWidth(100)),
          Text(
            order.priceDetails.itemsPrice.toStringAsFixed(0),
            style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor),
          )
        ],
      ),
    );
  }
}
