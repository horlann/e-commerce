import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/common/services/connection/custom_connection_checker.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';
import 'package:sized_context/sized_context.dart';

import 'bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    CustomConnectionChecker().internetConnectionStream.listen((InternetConnectionStatus data) {
      if (data == InternetConnectionStatus.disconnected) {
        CustomSnackBar.showSnackNar(context, "Warning", "No internet connection");
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setScreenHeight(MediaQuery.of(context).size.height);
    setScreenWidth(MediaQuery.of(context).size.width);
    Strings.isSmallPhone = context.diagonalInches <= 4.5;
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
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
