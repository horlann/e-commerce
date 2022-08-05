import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_event.dart';
import 'package:kurilki/presentation/screens/admin/components/admin_bottom_bar.dart';

final _innerRouterKey = GlobalKey<AutoRouterState>();

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminOrdersBloc>(create: (_) => AdminOrdersBloc(getIt.call())..add(const InitOrdersEvent())),
        BlocProvider<AdminCategoryBloc>(create: (_) => AdminCategoryBloc(getIt.call())),
        BlocProvider<AdminItemBloc>(create: (_) => AdminItemBloc(getIt.call(), getIt.call())),
      ],
      child: AutoTabsRouter(
        key: _innerRouterKey,
        routes: const [
          CreateItemRouter(),
          ProductsListWrapper(),
          CreateCategoryRouter(),
          OrdersListRouter(),
        ],
        lazyLoad: true,
        builder: (context, child, animation) {
          return Scaffold(
            body: child,
            bottomNavigationBar: const AdminBottomBar(),
          );
        },
      ),
    );
  }
}
