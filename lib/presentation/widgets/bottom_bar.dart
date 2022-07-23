import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/resources/icons.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int activePage = 1;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(width: 1.5, color: Colors.black)),
        color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  activePage = 1;
                });
                context.navigateTo(const HomePageWrapper());
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: SvgPicture.asset(
                  CustomIcons.home,
                  width: 26,
                  color: activePage == 1 ? theme.infoTextColor : theme.inactiveTextColor,
                )),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  activePage = 2;
                });
                context.navigateTo(const AccountRouter());
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: SvgPicture.asset(
                  CustomIcons.profile,
                  width: 24,
                  color: activePage == 2 ? theme.infoTextColor : theme.inactiveTextColor,
                )),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  activePage = 3;
                });
                context.navigateTo(const CartRouter());
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: SvgPicture.asset(
                  CustomIcons.cart,
                  width: 26,
                  color: activePage == 3 ? theme.infoTextColor : theme.inactiveTextColor,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
