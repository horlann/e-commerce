import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_state.dart';
import 'package:kurilki/presentation/pages/cart/components/empty_cart_page.dart';
import 'package:kurilki/presentation/pages/cart/components/filled_cart_page.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = Provider.of<ThemesBloc>(context).theme;

    return BlocConsumer<CartBloc, CartState>(
       listener: (context, state) {
        if (state is OrderCreated) {
          CustomSnackBar.showSnackNar(context, 'Success!', 'Order Created');
        }
      },
      builder: (context, state) {
        if (state is InProgressCartState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoadedState) {
          if (state.cartItems.isEmpty) {
            return const EmptyCartPage();
          } else {
            return const FilledCartPage();
          }
        } else {
          return const Text('error');
        }
      },
    );
  }
}
