import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/admin/components/orders_list.dart';

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
      create: (_) => AdminBloc(getIt.call(), getIt.call())..add(const InitDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Admin Panel", style: TextStyle(color: theme.backgroundColor)),
          backgroundColor: theme.accentColor,
        ),
        body: Column(
          children: [
            const Expanded(child: OrdersList()),
            Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.navigateTo(const CreateItem());
                          },
                          child: Container(
                            color: theme.wrongColor,
                            child: Column(children: [
                              Text(
                                'Создать новый товар',
                                style: TextStyle(color: theme.infoTextColor),
                              )
                            ], mainAxisAlignment: MainAxisAlignment.center),
                          ),
                        ),
                      ),
                          Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.navigateTo(const AllItems());
                          },
                          child: Container(
                            color: theme.rightColor,
                            child: Column(children: [
                              Text(
                                'Список товаров',
                                style: TextStyle(color: theme.infoTextColor),
                              )
                            ], mainAxisAlignment: MainAxisAlignment.center),
                          ),
                        ),
                      )
                    ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: theme.rightColor,
                          child: Column(children: [
                            Text(
                              'Что-то',
                              style: TextStyle(color: theme.infoTextColor),
                            )
                          ], mainAxisAlignment: MainAxisAlignment.center),
                        ),
                          ),
                          Expanded(
                            child: Container(
                              color: theme.wrongColor,
                          child: Column(children: [
                            Text(
                              'Что-то',
                              style: TextStyle(color: theme.infoTextColor),
                            )
                          ], mainAxisAlignment: MainAxisAlignment.center),
                        ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
