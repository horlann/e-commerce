import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';
import 'package:kurilki/presentation/bloc/cart/cart_state.dart';
import 'package:kurilki/presentation/pages/shopping_cart/components/empty_cart_page.dart';
import 'package:kurilki/presentation/pages/shopping_cart/components/filled_cart_page.dart';
import 'package:kurilki/presentation/pages/shopping_cart/components/order_confirmation_page.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'components/cart_product_card.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = Provider.of<ThemesBloc>(context).theme;
    Size screenSize = MediaQuery.of(context).size;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: theme.backgroundColor)),
        centerTitle: true,
        backgroundColor: theme.accentColor,
      ),
      body: BlocConsumer<CartBloc, CartState>(
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
          } else if (state is ConfigureOrderState) {
            return const OrderConfirmationPage();
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}
