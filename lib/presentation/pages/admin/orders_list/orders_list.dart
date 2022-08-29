import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_state.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

import 'admin_order_list_tile.dart';

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
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => AdminOrderListTile(order: orders[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        height: adaptiveHeight(8),
                      ),
                      itemCount: orders.length,
                    ),
                  )
                : const Text(Strings.emptyText);
          } else if (state is InProgressLoadingState) {
            return Center(child: CircularProgressIndicator(color: theme.mainTextColor));
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
