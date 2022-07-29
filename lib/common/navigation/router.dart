import 'package:auto_route/auto_route.dart';
import 'package:kurilki/presentation/pages/admin/create_category/create_category.dart';
import 'package:kurilki/presentation/pages/admin/create_item/create_item.dart';
import 'package:kurilki/presentation/pages/admin/orders_list/orders_list.dart';
import 'package:kurilki/presentation/pages/admin/products_list/products_list.dart';
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
          maintainState: true,
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
    //admin route

    AutoRoute(
      path: '/admin',
      name: "AdminRouter",
      page: AdminScreen,
      maintainState: true,
      children: [
        AutoRoute(
          path: 'create_item',
          name: "CreateItemRouter",
          page: CreateItem,
        ),
        AutoRoute(
          path: 'create_category',
          name: "CreateCategoryRouter",
          page: CreateCategory,
        ),
        AutoRoute(
          path: 'orders_list',
          name: "OrdersListRouter",
          page: OrdersList,
        ),
        AutoRoute(
          path: 'products_list',
          name: "ProductsListRouter",
          page: ProductsList,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
