// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;

import '../../domain/entities/items/item.dart' as _i17;
import '../../presentation/pages/account/account_page.dart' as _i4;
import '../../presentation/pages/admin/create_item/create_item.dart' as _i10;
import '../../presentation/pages/admin/orders_list/orders_list.dart' as _i11;
import '../../presentation/pages/admin/products_list/components/edit_item.dart'
    as _i14;
import '../../presentation/pages/admin/products_list/products_list.dart'
    as _i13;
import '../../presentation/pages/admin/products_list/products_list_wrapper.dart'
    as _i12;
import '../../presentation/pages/cart/order_confirmation_page.dart' as _i9;
import '../../presentation/pages/cart/shopping_cart_page.dart' as _i8;
import '../../presentation/pages/cart/shopping_cart_wrapper.dart' as _i5;
import '../../presentation/pages/details/details_screen.dart' as _i7;
import '../../presentation/pages/home/home_page.dart' as _i6;
import '../../presentation/pages/home/home_page_wrapper.dart' as _i3;
import '../../presentation/screens/admin/admin_screen.dart' as _i2;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    AdminRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AdminScreen(),
      );
    },
    HomePageWrapper.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePageWrapper(),
      );
    },
    AccountRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.AccountPage(),
      );
    },
    CartWrapper.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ShoppingCartWrapper(),
      );
    },
    HomeRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.DetailsScreen(
          key: args.key,
          product: args.product,
          itemConfiguration: args.itemConfiguration,
        ),
      );
    },
    ShoppingCartRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.ShoppingCartPage(),
      );
    },
    OrderConfirmationRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.OrderConfirmationPage(),
      );
    },
    CreateItemRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.CreateItem(),
      );
    },
    OrdersListRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.OrdersList(),
      );
    },
    ProductsListWrapper.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.ProductsListWrapper(),
      );
    },
    ProductsListRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.ProductsListPage(),
      );
    },
    EditItemRouter.name: (routeData) {
      final args = routeData.argsAs<EditItemRouterArgs>();
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.EditItem(
          key: args.key,
          item: args.item,
        ),
      );
    },
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          MainScreen.name,
          path: '/',
          children: [
            _i15.RouteConfig(
              '#redirect',
              path: '',
              parent: MainScreen.name,
              redirectTo: 'homePageWrapper',
              fullMatch: true,
            ),
            _i15.RouteConfig(
              HomePageWrapper.name,
              path: 'homePageWrapper',
              parent: MainScreen.name,
              children: [
                _i15.RouteConfig(
                  HomeRouter.name,
                  path: '',
                  parent: HomePageWrapper.name,
                ),
                _i15.RouteConfig(
                  DetailsRouter.name,
                  path: 'details',
                  parent: HomePageWrapper.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              AccountRouter.name,
              path: 'account',
              parent: MainScreen.name,
            ),
            _i15.RouteConfig(
              CartWrapper.name,
              path: 'cart',
              parent: MainScreen.name,
              children: [
                _i15.RouteConfig(
                  ShoppingCartRouter.name,
                  path: '',
                  parent: CartWrapper.name,
                ),
                _i15.RouteConfig(
                  OrderConfirmationRouter.name,
                  path: 'order_confirmation',
                  parent: CartWrapper.name,
                ),
              ],
            ),
          ],
        ),
        _i15.RouteConfig(
          AdminRouter.name,
          path: '/admin',
          children: [
            _i15.RouteConfig(
              '#redirect',
              path: '',
              parent: AdminRouter.name,
              redirectTo: 'orders_list',
              fullMatch: true,
            ),
            _i15.RouteConfig(
              CreateItemRouter.name,
              path: 'create_item',
              parent: AdminRouter.name,
            ),
            _i15.RouteConfig(
              OrdersListRouter.name,
              path: 'orders_list',
              parent: AdminRouter.name,
            ),
            _i15.RouteConfig(
              ProductsListWrapper.name,
              path: 'productsListWrapper',
              parent: AdminRouter.name,
              children: [
                _i15.RouteConfig(
                  ProductsListRouter.name,
                  path: '',
                  parent: ProductsListWrapper.name,
                ),
                _i15.RouteConfig(
                  EditItemRouter.name,
                  path: 'edit_item',
                  parent: ProductsListWrapper.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i15.PageRouteInfo<void> {
  const MainScreen({List<_i15.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.AdminScreen]
class AdminRouter extends _i15.PageRouteInfo<void> {
  const AdminRouter({List<_i15.PageRouteInfo>? children})
      : super(
          AdminRouter.name,
          path: '/admin',
          initialChildren: children,
        );

  static const String name = 'AdminRouter';
}

/// generated route for
/// [_i3.HomePageWrapper]
class HomePageWrapper extends _i15.PageRouteInfo<void> {
  const HomePageWrapper({List<_i15.PageRouteInfo>? children})
      : super(
          HomePageWrapper.name,
          path: 'homePageWrapper',
          initialChildren: children,
        );

  static const String name = 'HomePageWrapper';
}

/// generated route for
/// [_i4.AccountPage]
class AccountRouter extends _i15.PageRouteInfo<void> {
  const AccountRouter()
      : super(
          AccountRouter.name,
          path: 'account',
        );

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i5.ShoppingCartWrapper]
class CartWrapper extends _i15.PageRouteInfo<void> {
  const CartWrapper({List<_i15.PageRouteInfo>? children})
      : super(
          CartWrapper.name,
          path: 'cart',
          initialChildren: children,
        );

  static const String name = 'CartWrapper';
}

/// generated route for
/// [_i6.HomePage]
class HomeRouter extends _i15.PageRouteInfo<void> {
  const HomeRouter()
      : super(
          HomeRouter.name,
          path: '',
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i7.DetailsScreen]
class DetailsRouter extends _i15.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({
    _i16.Key? key,
    required _i17.Item product,
    int itemConfiguration = -1,
  }) : super(
          DetailsRouter.name,
          path: 'details',
          args: DetailsRouterArgs(
            key: key,
            product: product,
            itemConfiguration: itemConfiguration,
          ),
        );

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({
    this.key,
    required this.product,
    this.itemConfiguration = -1,
  });

  final _i16.Key? key;

  final _i17.Item product;

  final int itemConfiguration;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product, itemConfiguration: $itemConfiguration}';
  }
}

/// generated route for
/// [_i8.ShoppingCartPage]
class ShoppingCartRouter extends _i15.PageRouteInfo<void> {
  const ShoppingCartRouter()
      : super(
          ShoppingCartRouter.name,
          path: '',
        );

  static const String name = 'ShoppingCartRouter';
}

/// generated route for
/// [_i9.OrderConfirmationPage]
class OrderConfirmationRouter extends _i15.PageRouteInfo<void> {
  const OrderConfirmationRouter()
      : super(
          OrderConfirmationRouter.name,
          path: 'order_confirmation',
        );

  static const String name = 'OrderConfirmationRouter';
}

/// generated route for
/// [_i10.CreateItem]
class CreateItemRouter extends _i15.PageRouteInfo<void> {
  const CreateItemRouter()
      : super(
          CreateItemRouter.name,
          path: 'create_item',
        );

  static const String name = 'CreateItemRouter';
}

/// generated route for
/// [_i11.OrdersList]
class OrdersListRouter extends _i15.PageRouteInfo<void> {
  const OrdersListRouter()
      : super(
          OrdersListRouter.name,
          path: 'orders_list',
        );

  static const String name = 'OrdersListRouter';
}

/// generated route for
/// [_i12.ProductsListWrapper]
class ProductsListWrapper extends _i15.PageRouteInfo<void> {
  const ProductsListWrapper({List<_i15.PageRouteInfo>? children})
      : super(
          ProductsListWrapper.name,
          path: 'productsListWrapper',
          initialChildren: children,
        );

  static const String name = 'ProductsListWrapper';
}

/// generated route for
/// [_i13.ProductsListPage]
class ProductsListRouter extends _i15.PageRouteInfo<void> {
  const ProductsListRouter()
      : super(
          ProductsListRouter.name,
          path: '',
        );

  static const String name = 'ProductsListRouter';
}

/// generated route for
/// [_i14.EditItem]
class EditItemRouter extends _i15.PageRouteInfo<EditItemRouterArgs> {
  EditItemRouter({
    _i16.Key? key,
    required _i17.Item item,
  }) : super(
          EditItemRouter.name,
          path: 'edit_item',
          args: EditItemRouterArgs(
            key: key,
            item: item,
          ),
        );

  static const String name = 'EditItemRouter';
}

class EditItemRouterArgs {
  const EditItemRouterArgs({
    this.key,
    required this.item,
  });

  final _i16.Key? key;

  final _i17.Item item;

  @override
  String toString() {
    return 'EditItemRouterArgs{key: $key, item: $item}';
  }
}
