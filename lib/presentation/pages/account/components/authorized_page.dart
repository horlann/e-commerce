import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/presentation/pages/account/components/product_card_history.dart';
import 'package:kurilki/presentation/pages/account/components/social_networks.dart';
import 'package:kurilki/presentation/pages/account/product_history.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Container(
      color: theme.backgroundColor,
      child: Column(
        children: [
          SizedBox(height: adaptiveHeight(10)),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
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
                style: TextStyle(color: theme.mainTextColor, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: adaptiveHeight(10)),
          Text(
            "Purchase history",
            style: TextStyle(color: theme.mainTextColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: adaptiveHeight(20)),
          Expanded(
            child: ListView.separated(
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCardHistory(
                  item: productList[index],
                  theme: theme,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 2);
              },
            ),
          ),
        ],
      ),
    );
  }
}
