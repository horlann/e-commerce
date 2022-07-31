// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import '../../domain/entities/items/item.dart' as _i16;
import '../../presentation/pages/account/account_page.dart' as _i4;
import '../../presentation/pages/admin/create_category/create_category.dart'
    as _i9;
import '../../presentation/pages/admin/create_item/create_item.dart' as _i8;
import '../../presentation/pages/admin/orders_list/orders_list.dart' as _i10;
import '../../presentation/pages/admin/products_list/components/edit_item.dart'
    as _i13;
import '../../presentation/pages/admin/products_list/products_list.dart'
    as _i12;
import '../../presentation/pages/admin/products_list/products_list_wrapper.dart'
    as _i11;
import '../../presentation/pages/cart/shopping_cart_page.dart' as _i5;
import '../../presentation/pages/details/details_screen.dart' as _i7;
import '../../presentation/pages/home/home_page.dart' as _i6;
import '../../presentation/pages/home/home_page_wrapper.dart' as _i3;
import '../../presentation/screens/admin/admin_screen.dart' as _i2;
import '../../presentation/screens/main_screen/main_screen.dart' as _i1;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainScreen());
    },
    AdminRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.AdminScreen());
    },
    HomePageWrapper.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePageWrapper());
    },
    AccountRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.AccountPage());
    },
    CartRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ShoppingCartPage());
    },
    HomeRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.HomePage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.DetailsScreen(key: args.key, product: args.product));
    },
    CreateItemRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CreateItem());
    },
    CreateCategoryRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CreateCategory());
    },
    OrdersListRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.OrdersList());
    },
    ProductsListRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProductsListWrapper());
    },
    ProductsList.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.ProductsList());
    },
    EditItemRouter.name: (routeData) {
      final args = routeData.argsAs<EditItemRouterArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.EditItem(key: args.key, item: args.item));
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(MainScreen.name, path: '/', children: [
          _i14.RouteConfig('#redirect',
              path: '',
              parent: MainScreen.name,
              redirectTo: 'homePageWrapper',
              fullMatch: true),
          _i14.RouteConfig(HomePageWrapper.name,
              path: 'homePageWrapper',
              parent: MainScreen.name,
              children: [
                _i14.RouteConfig(HomeRouter.name,
                    path: '', parent: HomePageWrapper.name),
                _i14.RouteConfig(DetailsRouter.name,
                    path: 'details', parent: HomePageWrapper.name)
              ]),
          _i14.RouteConfig(AccountRouter.name,
              path: 'account', parent: MainScreen.name),
          _i14.RouteConfig(CartRouter.name,
              path: 'cart', parent: MainScreen.name)
        ]),
        _i14.RouteConfig(AdminRouter.name, path: '/admin', children: [
          _i14.RouteConfig(CreateItemRouter.name,
              path: 'create_item', parent: AdminRouter.name),
          _i14.RouteConfig(CreateCategoryRouter.name,
              path: 'create_category', parent: AdminRouter.name),
          _i14.RouteConfig(OrdersListRouter.name,
              path: 'orders_list', parent: AdminRouter.name),
          _i14.RouteConfig(ProductsListRouter.name,
              path: 'productsListWrapper',
              parent: AdminRouter.name,
              children: [
                _i14.RouteConfig(ProductsList.name,
                    path: '', parent: ProductsListRouter.name),
                _i14.RouteConfig(EditItemRouter.name,
                    path: 'edit_item', parent: ProductsListRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i14.PageRouteInfo<void> {
  const MainScreen({List<_i14.PageRouteInfo>? children})
      : super(MainScreen.name, path: '/', initialChildren: children);

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.AdminScreen]
class AdminRouter extends _i14.PageRouteInfo<void> {
  const AdminRouter({List<_i14.PageRouteInfo>? children})
      : super(AdminRouter.name, path: '/admin', initialChildren: children);

  static const String name = 'AdminRouter';
}

/// generated route for
/// [_i3.HomePageWrapper]
class HomePageWrapper extends _i14.PageRouteInfo<void> {
  const HomePageWrapper({List<_i14.PageRouteInfo>? children})
      : super(HomePageWrapper.name,
            path: 'homePageWrapper', initialChildren: children);

  static const String name = 'HomePageWrapper';
}

/// generated route for
/// [_i4.AccountPage]
class AccountRouter extends _i14.PageRouteInfo<void> {
  const AccountRouter() : super(AccountRouter.name, path: 'account');

  static const String name = 'AccountRouter';
}

/// generated route for
/// [_i5.ShoppingCartPage]
class CartRouter extends _i14.PageRouteInfo<void> {
  const CartRouter() : super(CartRouter.name, path: 'cart');

  static const String name = 'CartRouter';
}

/// generated route for
/// [_i6.HomePage]
class HomeRouter extends _i14.PageRouteInfo<void> {
  const HomeRouter() : super(HomeRouter.name, path: '');

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i7.DetailsScreen]
class DetailsRouter extends _i14.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter({_i15.Key? key, required _i16.Item product})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(key: key, product: product));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs({this.key, required this.product});

  final _i15.Key? key;

  final _i16.Item product;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i8.CreateItem]
class CreateItemRouter extends _i14.PageRouteInfo<void> {
  const CreateItemRouter() : super(CreateItemRouter.name, path: 'create_item');

  static const String name = 'CreateItemRouter';
}

/// generated route for
/// [_i9.CreateCategory]
class CreateCategoryRouter extends _i14.PageRouteInfo<void> {
  const CreateCategoryRouter()
      : super(CreateCategoryRouter.name, path: 'create_category');

  static const String name = 'CreateCategoryRouter';
}

/// generated route for
/// [_i10.OrdersList]
class OrdersListRouter extends _i14.PageRouteInfo<void> {
  const OrdersListRouter() : super(OrdersListRouter.name, path: 'orders_list');

  static const String name = 'OrdersListRouter';
}

/// generated route for
/// [_i11.ProductsListWrapper]
class ProductsListRouter extends _i14.PageRouteInfo<void> {
  const ProductsListRouter({List<_i14.PageRouteInfo>? children})
      : super(ProductsListRouter.name,
            path: 'productsListWrapper', initialChildren: children);

  static const String name = 'ProductsListRouter';
}

/// generated route for
/// [_i12.ProductsList]
class ProductsList extends _i14.PageRouteInfo<void> {
  const ProductsList() : super(ProductsList.name, path: '');

  static const String name = 'ProductsList';
}

/// generated route for
/// [_i13.EditItem]
class EditItemRouter extends _i14.PageRouteInfo<EditItemRouterArgs> {
  EditItemRouter({_i15.Key? key, required _i16.Item item})
      : super(EditItemRouter.name,
            path: 'edit_item', args: EditItemRouterArgs(key: key, item: item));

  static const String name = 'EditItemRouter';
}

class EditItemRouterArgs {
  const EditItemRouterArgs({this.key, required this.item});

  final _i15.Key? key;

  final _i16.Item item;

  @override
  String toString() {
    return 'EditItemRouterArgs{key: $key, item: $item}';
  }
}
