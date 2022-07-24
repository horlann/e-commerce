import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/pages/account/components/product_card_history.dart';
import 'package:kurilki/presentation/pages/account/components/social_networks.dart';
import 'package:kurilki/presentation/pages/shopping_cart/products.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/scroll_behaviour.dart';
import 'package:kurilki/presentation/widgets/circle_icon_button.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

import '../../../resources/icons.dart';

class AuthorizatedPage extends StatelessWidget {
  const AuthorizatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = AccountBloc();
    final user = FirebaseAuth.instance.currentUser!;
    final screenSize = MediaQuery.of(context).size;
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Container(
      color: theme.backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CustomImageProvider(
                imageLink: user.photoURL ?? "",
                imageFrom: ImageFrom.network,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Center(
              child: AutoSizeText(
                user.displayName ?? "Google account",
                minFontSize: 12,
                maxFontSize: 20,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Purchase history",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ScrollConfiguration(
              behavior: ListViewScrollBehavior(),
              child: ListView.separated(
                itemCount: demo_product_history.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCardHistory(
                    product: demo_product_history[index],
                    theme: theme,
                    width: screenSize.width,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 2);
                },
              ),
            ),
          ),
          SocialNetworks(theme: theme, bloc: bloc),
        ],
      ),
    );
  }
}
