import 'package:auto_route/auto_route.dart';

import 'package:kurilki/presentation/pages/home/home_page.dart';
import 'package:kurilki/presentation/pages/home/home_page_wrapper.dart';
import 'package:kurilki/presentation/pages/shopping_cart/shopping_cart_page.dart';
import 'package:kurilki/presentation/screens/admin/admin_screen.dart';
import 'package:kurilki/presentation/screens/main_screen/main_screen.dart';

import '../../presentation/pages/account/account_page.dart';

import '../../presentation/pages/details/details_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: MainScreen,
      name: "MainScreen",
      initial: true,
      children: [
        AutoRoute(
          initial: true,
          path: 'homePageWrapper',
          name: "HomePageWrapper",
          page: HomePageWrapper,
          children: [
            AutoRoute(
              path: '',
              name: "HomeRouter",
              page: HomePage,
            ),
            AutoRoute(
              path: 'details',
              name: "DetailsRouter",
              page: DetailsScreen,
            ),
          ],
        ),
        AutoRoute(
          path: 'account',
          name: "AccountRouter",
          page: AccountPage,
        ),
        AutoRoute(
          path: 'cart',
          name: "CartRouter",
          page: ShoppingCartPage,
        ),
      ],
    ),
    /*AutoRoute(
      path: 'admin',
      name: "AdminRouter",
      page: AdminScreen,
    ),*/
  ],
)
class $AppRouter {}
