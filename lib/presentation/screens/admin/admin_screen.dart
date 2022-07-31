import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
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
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return BlocProvider(
      create: (_) => AdminBloc(getIt.call(), getIt.call())..add(const InitCategoriesEvent()),
      child: AutoTabsRouter(
        key: _innerRouterKey,
        homeIndex: 3,
        routes: const [
          CreateItemRouter(),
          ProductsListRouter(),
          CreateCategoryRouter(),
          OrdersListRouter(),
        ],
        lazyLoad: true,
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(_appBarText(tabsRouter.activeIndex), style: TextStyle(color: theme.mainTextColor)),
              foregroundColor: theme.accentColor,
              backgroundColor: theme.backgroundColor,
            ),
            body: child,
            bottomNavigationBar: const AdminBottomBar(),
          );
        },
      ),
    );
  }

  String _appBarText(int index) {
    switch (index) {
      case 0:
        return 'Добавить товар';
      case 1:
        return 'Товары';
      case 2:
        return 'Категории';
      case 3:
        return 'Заказы';
    }
    return '';
  }
}
