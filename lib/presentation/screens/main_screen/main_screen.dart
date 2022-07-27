import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kurilki/common/navigation/router.gr.dart';

import 'bottom_bar.dart';

final _innerRouterKey = GlobalKey<AutoRouterState>();

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      key: _innerRouterKey,

      routes: const [
        HomePageWrapper(),
        AccountRouter(),
        CartRouter(),
      ],
      //TODO:should be false
      lazyLoad: true,
      builder: (context, child, animation) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const BottomBar(),
        );
      },
    );
  }
}
