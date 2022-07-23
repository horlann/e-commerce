import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kurilki/common/navigation/router.gr.dart';

import '../../widgets/bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomePageWrapper(),
        AccountRouter(),
        CartRouter(),
      ],
      duration: const Duration(milliseconds: 1),
      builder: (context, child, animation) {
        return Scaffold(
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: const BottomBar(),
        );
      },
    );
  }
}
