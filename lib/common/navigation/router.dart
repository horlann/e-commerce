import 'package:auto_route/auto_route.dart';
import 'package:kurilki/presentation/pages/account/account_page.dart';
import 'package:kurilki/presentation/pages/admin/create_item/create_item.dart';
import 'package:kurilki/presentation/pages/admin/orders_list/orders_list.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/edit_item.dart';
import 'package:kurilki/presentation/pages/admin/products_list/products_list.dart';
import 'package:kurilki/presentation/pages/admin/products_list/products_list_wrapper.dart';
import 'package:kurilki/presentation/pages/cart/order_confirmation_page.dart';
import 'package:kurilki/presentation/pages/cart/shopping_cart_page.dart';
import 'package:kurilki/presentation/pages/cart/shopping_cart_wrapper.dart';
import 'package:kurilki/presentation/pages/details/details_screen.dart';
import 'package:kurilki/presentation/pages/home/home_page.dart';
import 'package:kurilki/presentation/pages/home/home_page_wrapper.dart';
import 'package:kurilki/presentation/screens/admin/admin_screen.dart';
import 'package:kurilki/presentation/screens/main_screen/main_screen.dart';

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
          name: "CartWrapper",
          page: ShoppingCartWrapper,
          children: [
            AutoRoute(
              path: '',
              name: "ShoppingCartRouter",
              page: ShoppingCartPage,
            ),
            AutoRoute(
              path: 'order_confirmation',
              name: "OrderConfirmationRouter",
              page: OrderConfirmationPage,
            ),
          ],
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
          path: 'orders_list',
          name: "OrdersListRouter",
          page: OrdersList,
          initial: true,
        ),
        AutoRoute(
          path: 'productsListWrapper',
          name: "ProductsListWrapper",
          page: ProductsListWrapper,
          children: [
            AutoRoute(
              path: '',
              name: "ProductsListRouter",
              page: ProductsListPage,
            ),
            AutoRoute(
              path: 'edit_item',
              name: "EditItemRouter",
              page: EditItem,
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
