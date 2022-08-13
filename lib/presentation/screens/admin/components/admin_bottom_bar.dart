import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_event.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_event.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_event.dart';
import 'package:kurilki/presentation/resources/icons.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({Key? key}) : super(key: key);

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int activePage = 4;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminItemBloc itemBloc = BlocProvider.of<AdminItemBloc>(context);
    final AdminOrdersBloc ordersBloc = BlocProvider.of<AdminOrdersBloc>(context);
    final AdminCategoryBloc categoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
    final tabsRouter = AutoTabsRouter.of(context);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(width: 1.5, color: Colors.black)),
        color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  activePage = 0;
                });
                categoryBloc.add(const InitCategoriesEvent());
                tabsRouter.setActiveIndex(0);
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: SvgPicture.asset(
                      CustomIcons.newItem,
                  width: 26,
                  color: activePage == 0 ? theme.infoTextColor : theme.inactiveTextColor,
                )),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  activePage = 1;
                });
                itemBloc.add(const InitItemsEvent());
                tabsRouter.setActiveIndex(1);
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: SvgPicture.asset(
                      CustomIcons.redactItem,
                  width: 24,
                  color: activePage == 1 ? theme.infoTextColor : theme.inactiveTextColor,
                )),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  activePage = 2;
                });
                ordersBloc.add(const InitOrdersEvent());
                tabsRouter.setActiveIndex(2);
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: SvgPicture.asset(
                      CustomIcons.orders,
                  width: 26,
                  color: activePage == 2 ? theme.infoTextColor : theme.inactiveTextColor,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
