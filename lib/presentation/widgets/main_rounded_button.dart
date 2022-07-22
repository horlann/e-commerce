import 'package:flutter/material.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';

class MainRoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final double round;
  final Border? border;
  final double textSize;
  final bool isActive;
  final TextStyle textStyle;
  final double padding;
  final double paddingVert;
  final VoidCallback callback;
  final AbstractTheme theme;
  final bool isLoading;

  const MainRoundedButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.callback,
      required this.theme,
      this.round = 24,
      this.isActive = true,
      this.textSize = 15,
      this.padding = 5,
      this.paddingVert = 10,
      this.border,
      this.isLoading = false,
      this.textStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(round)),
      child: Material(
        color: color,
        child: InkWell(
          onTap: callback,
          hoverColor: color.withOpacity(0.7),
          focusColor: color.withOpacity(0.7),
          highlightColor: color.withOpacity(0.7),
          child: Container(
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.all(Radius.circular(round)),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding, vertical: paddingVert),
                  child: Center(
                    child: Text(
                      text,
                      style: textStyle,
                    ),
                  ),
                ),
                if (isLoading)
                  Container(
                    height: 35,
                    width: 35,
                    margin: const EdgeInsets.only(right: 16.0),
                    child: CircularProgressIndicator(strokeWidth: 3, color: theme.infoTextColor),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
