import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is NewOrderState) {
          List<OrderEntity> orders = state.orders;
          return orders.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _AdminOrderListTile(order: orders[index]),
                  itemCount: orders.length,
                )
              : Text('empty');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
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
            style: TextStyle(color: theme.infoTextColor),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: order.items
                .map((e) => Text(
                      '${e.item.name} *${e.count}',
                      style: TextStyle(color: theme.infoTextColor),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
