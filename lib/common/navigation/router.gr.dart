// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../domain/entities/items/item.dart' as _i14;
import '../../presentation/pages/account/account_page.dart' as _i4;
import '../../presentation/pages/admin/create_category/create_category.dart'
    as _i9;
import '../../presentation/pages/admin/create_item/create_item.dart' as _i8;
import '../../presentation/pages/admin/orders_list/orders_list.dart' as _i10;
import '../../presentation/pages/admin/products_list/products_list.dart'
    as _i11;
import '../../presentation/pages/cart/shopping_cart_page.dart' as _i5;
import '../../presentation/pages/details/details_screen.dart' as _i7;
import '../../presentation/pages/home/home_page.dart' as _i6;
import '../../presentation/pages/home/home_page_wrapper.dart' as _i3;
import '../../presentation/screens/admin/admin_screen.dart' as _i2;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainScreen());
    },
    AdminRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.AdminScreen());
    },
    HomePageWrapper.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePageWrapper());
    },
    AccountRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.AccountPage());
    },
    CartRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ShoppingCartPage());
    },
    HomeRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.HomePage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.DetailsScreen(key: args.key, product: args.product));
    },
    CreateItemRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CreateItem());
    },
    CreateCategoryRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CreateCategory());
    },
    OrdersListRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.OrdersList());
    },
    ProductsListRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProductsList());
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(MainScreen.name, path: '/', children: [
          _i12.RouteConfig('#redirect',
              path: '',
              parent: MainScreen.name,
              redirectTo: 'homePageWrapper',
              fullMatch: true),
          _i12.RouteConfig(HomePageWrapper.name,
              path: 'homePageWrapper',
              parent: MainScreen.name,
              children: [
                _i12.RouteConfig(HomeRouter.name,
                    path: '', parent: HomePageWrapper.name),
                _i12.RouteConfig(DetailsRouter.name,
                    path: 'details', parent: HomePageWrapper.name)
              ]),
          _i12.RouteConfig(AccountRouter.name,
              path: 'account', parent: MainScreen.name),
          _i12.RouteConfig(CartRouter.name,
              path: 'cart', parent: MainScreen.name)
        ]),
        _i12.RouteConfig(AdminRouter.name, path: '/admin', children: [
          _i12.RouteConfig(CreateItemRouter.name,
              path: 'create_item', parent: AdminRouter.name),
          _i12.RouteConfig(CreateCategoryRouter.name,
              path: 'create_category', parent: AdminRouter.name),
          _i12.RouteConfig(OrdersListRouter.name,
              path: 'orders_list', parent: AdminRouter.name),
          _i12.RouteConfig(ProductsListRouter.name,
              path: 'products_list', parent: AdminRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i12.PageRouteInfo<void> {
  const MainScreen({List<_i12.PageRouteInfo>? children})
      : super(MainScreen.name, path: '/', initialChildren: children);

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.AdminScreen]
class AdminRouter extends _i12.PageRouteInfo<void> {
  const AdminRouter({List<_i12.PageRouteInfo>? children})
      : super(AdminRouter.name, path: '/admin', initialChildren: children);

  static const String name = 'AdminRouter';
}

/// generated route for
/// [_i3.HomePageWrapper]
class HomePageWrapper extends _i12.PageRouteInfo<void> {
  const HomePageWrapper({List<_i12.PageRouteInfo>? children})
      : super(HomePageWrapper.name,
            path: 'homePageWrapper', initialChildren: children);

  static const String name = 'HomePageWrapper';
}

/// generated route for
/// [_i4.AccountPage]
class AccountRouter extends _i12.PageRouteInfo<void> {
  const AccountRouter() : super(AccountRouter.name, path: 'account');

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i5.ShoppingCartPage]
class CartRouter extends _i12.PageRouteInfo<void> {
  const CartRouter() : super(CartRouter.name, path: 'cart');

  static const String name = 'CartRouter';
}

/// generated route for
/// [_i6.HomePage]
class HomeRouter extends _i12.PageRouteInfo<void> {
  const HomeRouter() : super(HomeRouter.name, path: '');

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i7.DetailsScreen]
class DetailsRouter extends _i12.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({_i13.Key? key, required _i14.Item product})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(key: key, product: product));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({this.key, required this.product});

  final _i13.Key? key;

  final _i14.Item product;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i8.CreateItem]
class CreateItemRouter extends _i12.PageRouteInfo<void> {
  const CreateItemRouter() : super(CreateItemRouter.name, path: 'create_item');

  static const String name = 'CreateItemRouter';
}

/// generated route for
/// [_i9.CreateCategory]
class CreateCategoryRouter extends _i12.PageRouteInfo<void> {
  const CreateCategoryRouter()
      : super(CreateCategoryRouter.name, path: 'create_category');

  static const String name = 'CreateCategoryRouter';
}

/// generated route for
/// [_i10.OrdersList]
class OrdersListRouter extends _i12.PageRouteInfo<void> {
  const OrdersListRouter() : super(OrdersListRouter.name, path: 'orders_list');

  static const String name = 'OrdersListRouter';
}

/// generated route for
/// [_i11.ProductsList]
class ProductsListRouter extends _i12.PageRouteInfo<void> {
  const ProductsListRouter()
      : super(ProductsListRouter.name, path: 'products_list');

  static const String name = 'ProductsListRouter';
}
