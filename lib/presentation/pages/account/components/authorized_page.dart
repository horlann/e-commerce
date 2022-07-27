import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/presentation/pages/account/components/product_card_history.dart';
import 'package:kurilki/presentation/pages/account/components/social_networks.dart';
import 'package:kurilki/presentation/pages/account/product_history.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class AuthorizedPage extends StatelessWidget {
  final AccountEntity user;

  const AuthorizedPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final scale = byWithScale(context);

    return Container(
      color: theme.backgroundColor,
      child: Column(
        children: [
          SizedBox(height: scale * 10),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CustomImageProvider(
                imageLink: user.imageLink,
                imageFrom: ImageFrom.network,
              ),
            ),
          ),
          SizedBox(height: scale * 10),
          SizedBox(
            width: scale * 200,
            child: Center(
              child: AutoSizeText(
                user.name,
                minFontSize: 16,
                maxFontSize: 20,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: scale * 20),
          const Text(
            "Purchase history",
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: scale * 10),
          Expanded(
            child: ListView.separated(
              itemCount: product_list.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCardHistory(
                  item: product_list[index],
                  theme: theme,
                  width: screenSize.width,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 2);
              },
            ),
          ),
          const SocialNetworks(),
        ],
      ),
    );
  }
}
