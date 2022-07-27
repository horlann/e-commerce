// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../domain/entities/items/item.dart' as _i10;
import '../../presentation/pages/account/account_page.dart' as _i4;
import '../../presentation/pages/details/details_screen.dart' as _i7;
import '../../presentation/pages/home/home_page.dart' as _i6;
import '../../presentation/pages/home/home_page_wrapper.dart' as _i3;
import '../../presentation/pages/shopping_cart/shopping_cart_page.dart' as _i5;
import '../../presentation/screens/admin/admin_screen.dart' as _i2;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainScreen());
    },
    AdminRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.AdminScreen());
    },
    HomePageWrapper.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePageWrapper());
    },
    AccountRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.AccountPage());
    },
    CartRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ShoppingCartPage());
    },
    HomeRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.HomePage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.DetailsScreen(key: args.key, product: args.product));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(MainScreen.name, path: '/', children: [
          _i8.RouteConfig('#redirect',
              path: '',
              parent: MainScreen.name,
              redirectTo: 'homePageWrapper',
              fullMatch: true),
          _i8.RouteConfig(HomePageWrapper.name,
              path: 'homePageWrapper',
              parent: MainScreen.name,
              children: [
                _i8.RouteConfig(HomeRouter.name,
                    path: '', parent: HomePageWrapper.name),
                _i8.RouteConfig(DetailsRouter.name,
                    path: 'details', parent: HomePageWrapper.name)
              ]),
          _i8.RouteConfig(AccountRouter.name,
              path: 'account', parent: MainScreen.name),
          _i8.RouteConfig(CartRouter.name,
              path: 'cart', parent: MainScreen.name)
        ]),
        _i8.RouteConfig(AdminRouter.name, path: 'admin')
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i8.PageRouteInfo<void> {
  const MainScreen({List<_i8.PageRouteInfo>? children})
      : super(MainScreen.name, path: '/', initialChildren: children);

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.AdminScreen]
class AdminRouter extends _i8.PageRouteInfo<void> {
  const AdminRouter() : super(AdminRouter.name, path: 'admin');

  static const String name = 'AdminRouter';
}

/// generated route for
/// [_i3.HomePageWrapper]
class HomePageWrapper extends _i8.PageRouteInfo<void> {
  const HomePageWrapper({List<_i8.PageRouteInfo>? children})
      : super(HomePageWrapper.name,
            path: 'homePageWrapper', initialChildren: children);

  static const String name = 'HomePageWrapper';
}

/// generated route for
/// [_i4.AccountPage]
class AccountRouter extends _i8.PageRouteInfo<void> {
  const AccountRouter() : super(AccountRouter.name, path: 'account');

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i5.ShoppingCartPage]
class CartRouter extends _i8.PageRouteInfo<void> {
  const CartRouter() : super(CartRouter.name, path: 'cart');

  static const String name = 'CartRouter';
}

/// generated route for
/// [_i6.HomePage]
class HomeRouter extends _i8.PageRouteInfo<void> {
  const HomeRouter() : super(HomeRouter.name, path: '');

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i7.DetailsScreen]
class DetailsRouter extends _i8.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({_i9.Key? key, required _i10.Item product})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(key: key, product: product));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({this.key, required this.product});

  final _i9.Key? key;

  final _i10.Item product;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product}';
  }
}
