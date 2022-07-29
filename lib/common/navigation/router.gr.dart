// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../domain/entities/items/item.dart' as _i12;
import '../../presentation/pages/account/account_page.dart' as _i6;
import '../../presentation/pages/admin/all_items_page.dart' as _i4;
import '../../presentation/pages/admin/create_new_item_page.dart' as _i3;
import '../../presentation/pages/cart/shopping_cart_page.dart' as _i7;
import '../../presentation/pages/details/details_screen.dart' as _i9;
import '../../presentation/pages/home/home_page.dart' as _i8;
import '../../presentation/pages/home/home_page_wrapper.dart' as _i5;
import '../../presentation/screens/admin/admin_screen.dart' as _i2;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i1.MainScreen());
    },
    AdminRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i2.AdminScreen());
    },
    CreateItem.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i3.CreateNewItem());
    },
    AllItems.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i4.AllItemsPage());
    },
    HomePageWrapper.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i5.HomePageWrapper());
    },
    AccountRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i6.AccountPage());
    },
    CartRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i7.ShoppingCartPage());
    },
    HomeRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(routeData: routeData, child: const _i8.HomePage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.DetailsScreen(key: args.key, product: args.product));
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(MainScreen.name, path: '/', children: [
          _i10.RouteConfig('#redirect',
              path: '', parent: MainScreen.name, redirectTo: 'homePageWrapper', fullMatch: true),
          _i10.RouteConfig(HomePageWrapper.name, path: 'homePageWrapper', parent: MainScreen.name, children: [
            _i10.RouteConfig(HomeRouter.name, path: '', parent: HomePageWrapper.name),
            _i10.RouteConfig(DetailsRouter.name, path: 'details', parent: HomePageWrapper.name)
          ]),
          _i10.RouteConfig(AccountRouter.name, path: 'account', parent: MainScreen.name),
          _i10.RouteConfig(CartRouter.name, path: 'cart', parent: MainScreen.name)
        ]),
        _i10.RouteConfig(AdminRouter.name, path: 'admin'),
        _i10.RouteConfig(CreateItem.name, path: 'createItem'),
        _i10.RouteConfig(AllItems.name, path: 'allItems')
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i10.PageRouteInfo<void> {
  const MainScreen({List<_i10.PageRouteInfo>? children}) : super(MainScreen.name, path: '/', initialChildren: children);

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.AdminScreen]
class AdminRouter extends _i10.PageRouteInfo<void> {
  const AdminRouter() : super(AdminRouter.name, path: 'admin');

  static const String name = 'AdminRouter';
}

/// generated route for
/// [_i3.CreateNewItem]
class CreateItem extends _i10.PageRouteInfo<void> {
  const CreateItem() : super(CreateItem.name, path: 'createItem');

  static const String name = 'CreateItem';
}

/// generated route for
/// [_i4.AllItemsPage]
class AllItems extends _i10.PageRouteInfo<void> {
  const AllItems() : super(AllItems.name, path: 'allItems');

  static const String name = 'AllItems';
}

/// generated route for
/// [_i5.HomePageWrapper]
class HomePageWrapper extends _i10.PageRouteInfo<void> {
  const HomePageWrapper({List<_i10.PageRouteInfo>? children})
      : super(HomePageWrapper.name, path: 'homePageWrapper', initialChildren: children);

  static const String name = 'HomePageWrapper';
}

/// generated route for
/// [_i6.AccountPage]
class AccountRouter extends _i10.PageRouteInfo<void> {
  const AccountRouter() : super(AccountRouter.name, path: 'account');

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i7.ShoppingCartPage]
class CartRouter extends _i10.PageRouteInfo<void> {
  const CartRouter() : super(CartRouter.name, path: 'cart');

  static const String name = 'CartRouter';
}

/// generated route for
/// [_i8.HomePage]
class HomeRouter extends _i10.PageRouteInfo<void> {
  const HomeRouter() : super(HomeRouter.name, path: '');

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i9.DetailsScreen]
class DetailsRouter extends _i10.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({_i11.Key? key, required _i12.Item product})
      : super(DetailsRouter.name, path: 'details', args: DetailsRouterArgs(key: key, product: product));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({this.key, required this.product});

  final _i11.Key? key;

  final _i12.Item product;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product}';
  }
}
