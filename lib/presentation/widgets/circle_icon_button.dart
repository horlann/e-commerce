import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kurilki/presentation/resources/icons.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';

class CircleIconButton extends StatelessWidget {
  final String icon;
  final double height;
  final double width;
  final VoidCallback callback;
  final AbstractTheme theme;

  const CircleIconButton({
    Key? key,
    required this.icon,
    this.height = 48,
    this.width = 48,
    required this.callback,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(icon),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all(theme.cardColor),
      ),
    );
  }
}
