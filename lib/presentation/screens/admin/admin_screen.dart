import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/admin/components/orders_list.dart';
import 'package:uuid/uuid.dart';

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
                            // context.navigateTo(const CreateItem());
                            //todo:удалить это
                            AdminBloc bloc = AdminBloc(getIt.call(), getIt.call());
                            bloc.add(AddNewItemEvent(DisposablePodEntity(
                                uuid: const Uuid().v4(),
                                id: '1',
                                name: 'ElfBar 1500',
                                price: 330,
                                oldPrice: 0,
                                category: 'disposablePod',
                                imageLink: 'https://www.elfbar.com.ua/wp-content/uploads/2021/01/reverseside-2.jpg',
                                tags: [],
                                isAvailable: true,
                                itemSettings: [
                                  ItemSettings(
                                      name: 'Blue Razz',
                                      imageLink:
                                          'https://www.elfbarvape.eu/img/74401/2138118996316028/440x440,r/2138118996316028.webp?time=1655067470',
                                      isAvailable: true,
                                      count: 10),
                                  ItemSettings(
                                      name: 'Pink Lemonade',
                                      imageLink:
                                          'https://www.elfbarvape.eu/img/74401/2138118996316033/440x440,r/2138118996316033.webp?time=1655067595',
                                      isAvailable: true,
                                      count: 10),
                                  ItemSettings(
                                      name: 'Spearmint',
                                      imageLink:
                                          'https://www.elfbarvape.eu/img/74401/2138119009274025/275x275,r/2138119009274025.webp?time=1655383789',
                                      isAvailable: false,
                                      count: 10),
                                  ItemSettings(
                                      name: 'Mango',
                                      imageLink:
                                          'https://www.elfbarvape.eu/img/74401/2138119009274035/440x440,r/2138119009274035.webp?time=1655066997',
                                      isAvailable: true,
                                      count: 10)
                                ],
                                puffsCount: 1500)));
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
