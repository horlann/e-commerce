import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/pages/account/components/history_product_card.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class AuthorizedPage extends StatelessWidget {
  final UserEntity user;

  const AuthorizedPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AccountBloc bloc = BlocProvider.of<AccountBloc>(context);

    return Expanded(
        child: CustomScrollView(
      slivers: [
        _FlexibleAppBar(user: user),
        SliverToBoxAdapter(
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  user.items.length,
                  (index) {
                    return HistoryProductCard(product: user.items.reversed.toList()[index]);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class _FlexibleAppBar extends StatelessWidget {
  const _FlexibleAppBar({Key? key, required this.user}) : super(key: key);
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return SliverAppBar(
      expandedHeight: adaptiveHeight(200),
      backgroundColor: theme.backgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              right: 10,
              top: MediaQuery.of(context).padding.top + adaptiveHeight(30),
              child: GestureDetector(
                onTap: () {
                  accountBloc.add(const LogoutFromAccountEvent());
                },
                child: Container(
                  width: adaptiveWidth(36),
                  height: adaptiveWidth(36),
                  child: Icon(
                    Icons.logout_outlined,
                    color: theme.mainTextColor,
                  ),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: adaptiveHeight(70)),
                  Container(
                    width: adaptiveWidth(100),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      border: Border.all(color: theme.mainTextColor, width: 1),
                      boxShadow: [theme.appShadows.largeShadow],
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(29)),
                      child: CustomImageProvider(
                        imageLink: user.imageLink,
                        imageFrom: ImageFrom.network,
                      ),
                    ),
                  ),
                  SizedBox(height: adaptiveHeight(10)),
                  SizedBox(
                    width: adaptiveWidth(200),
                    child: Center(
                      child: AutoSizeText(
                        user.name,
                        minFontSize: 16,
                        maxFontSize: 20,
                        style: theme.fontStyles.semiBold18.copyWith(color: theme.mainTextColor),
                      ),
                    ),
                  ),
                  SizedBox(height: adaptiveHeight(10)),
                  Text(
                    Strings.purchaseHistory,
                    style: theme.fontStyles.semiBold16.copyWith(color: theme.mainTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
