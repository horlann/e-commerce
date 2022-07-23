// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../presentation/pages/account/account_page.dart' as _i3;
import '../../presentation/pages/home/home_page.dart' as _i2;
import '../../presentation/pages/shopping_cart/shopping_cart_page.dart' as _i4;
import '../../presentation/screens/details/details_screen.dart' as _i5;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;
import '../../presentation/screens/product.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainScreen());
    },
    HomeRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    AccountRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.AccountPage());
    },
    CartRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ShoppingCartPage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.DetailsScreen(key: args.key, product: args.product));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(MainScreen.name, path: '/', children: [
          _i6.RouteConfig(HomeRouter.name,
              path: 'home',
              parent: MainScreen.name,
              children: [
                _i6.RouteConfig(DetailsRouter.name,
                    path: 'details', parent: HomeRouter.name)
              ]),
          _i6.RouteConfig(AccountRouter.name,
              path: 'account', parent: MainScreen.name),
          _i6.RouteConfig(CartRouter.name,
              path: 'cart', parent: MainScreen.name)
        ])
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i6.PageRouteInfo<void> {
  const MainScreen({List<_i6.PageRouteInfo>? children})
      : super(MainScreen.name, path: '/', initialChildren: children);

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.HomePage]
class HomeRouter extends _i6.PageRouteInfo<void> {
  const HomeRouter({List<_i6.PageRouteInfo>? children})
      : super(HomeRouter.name, path: 'home', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.AccountPage]
class AccountRouter extends _i6.PageRouteInfo<void> {
  const AccountRouter() : super(AccountRouter.name, path: 'account');

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i4.ShoppingCartPage]
class CartRouter extends _i6.PageRouteInfo<void> {
  const CartRouter() : super(CartRouter.name, path: 'cart');

  static const String name = 'CartRouter';
}

/// generated route for
/// [_i5.DetailsScreen]
class DetailsRouter extends _i6.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({_i7.Key? key, required _i8.Product product})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(key: key, product: product));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({this.key, required this.product});

  final _i7.Key? key;

  final _i8.Product product;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product}';
  }
}
