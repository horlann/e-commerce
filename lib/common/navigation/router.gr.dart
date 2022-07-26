// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../domain/entities/items/item.dart' as _i9;
import '../../presentation/pages/account/account_page.dart' as _i3;
import '../../presentation/pages/details/details_screen.dart' as _i5;
import '../../presentation/pages/home/home_page.dart' as _i6;
import '../../presentation/pages/home/home_page_wrapper.dart' as _i2;
import '../../presentation/pages/shopping_cart/shopping_cart_page.dart' as _i4;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainScreen());
    },
    HomePageWrapper.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePageWrapper());
    },
    AccountRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.AccountPage());
    },
    CartRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ShoppingCartPage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.DetailsScreen(key: args.key, product: args.product));
    },
    HomeRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.HomePage());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(MainScreen.name, path: '/', children: [
          _i7.RouteConfig('#redirect',
              path: '',
              parent: MainScreen.name,
              redirectTo: 'homePageWrapper',
              fullMatch: true),
          _i7.RouteConfig(HomePageWrapper.name,
              path: 'homePageWrapper',
              parent: MainScreen.name,
              children: [
                _i7.RouteConfig('#redirect',
                    path: '',
                    parent: HomePageWrapper.name,
                    redirectTo: 'home',
                    fullMatch: true),
                _i7.RouteConfig(DetailsRouter.name,
                    path: 'details', parent: HomePageWrapper.name),
                _i7.RouteConfig(HomeRouter.name,
                    path: 'home', parent: HomePageWrapper.name)
              ]),
          _i7.RouteConfig(AccountRouter.name,
              path: 'account', parent: MainScreen.name),
          _i7.RouteConfig(CartRouter.name,
              path: 'cart', parent: MainScreen.name)
        ])
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i7.PageRouteInfo<void> {
  const MainScreen({List<_i7.PageRouteInfo>? children})
      : super(MainScreen.name, path: '/', initialChildren: children);

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.HomePageWrapper]
class HomePageWrapper extends _i7.PageRouteInfo<void> {
  const HomePageWrapper({List<_i7.PageRouteInfo>? children})
      : super(HomePageWrapper.name,
            path: 'homePageWrapper', initialChildren: children);

  static const String name = 'HomePageWrapper';
}

/// generated route for
/// [_i3.AccountPage]
class AccountRouter extends _i7.PageRouteInfo<void> {
  const AccountRouter() : super(AccountRouter.name, path: 'account');

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i4.ShoppingCartPage]
class CartRouter extends _i7.PageRouteInfo<void> {
  const CartRouter() : super(CartRouter.name, path: 'cart');

  static const String name = 'CartRouter';
}

/// generated route for
/// [_i5.DetailsScreen]
class DetailsRouter extends _i7.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({_i8.Key? key, required _i9.Item product})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(key: key, product: product));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({this.key, required this.product});

  final _i8.Key? key;

  final _i9.Item product;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i6.HomePage]
class HomeRouter extends _i7.PageRouteInfo<void> {
  const HomeRouter() : super(HomeRouter.name, path: 'home');

  static const String name = 'HomeRouter';
}
