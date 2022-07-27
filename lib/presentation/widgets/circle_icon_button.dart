import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: SvgPicture.asset(
          icon,
          height: height - 10,
          width: width - 10,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all(theme.cardColor),
      ),
    );
  }
}
