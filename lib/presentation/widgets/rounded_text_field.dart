import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:provider/provider.dart';

class RoundedInputField extends StatefulWidget {
  final IconData? icon;
  final IconData? suffixIcon;
  final String? hint;
  final bool isPassword;
  final bool isPasswordCanBeVisible;
  final Function(String callback) callback;
  final String? initialValue;
  final int maxLength;
  final int maxLines;
  final TextInputType inputType;
  final Border? border;
  final String? Function(String? value)? validation;

  const RoundedInputField({
    Key? key,
    this.icon = Icons.person,
    this.hint = '',
    required this.callback,
    this.isPassword = false,
    this.isPasswordCanBeVisible = true,
    this.maxLength = 30,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.suffixIcon,
    this.validation,
    this.initialValue,
    this.border,
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool isPasswordHiden = false;

  @override
  void initState() {
    super.initState();
    isPasswordHiden = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = Provider.of<ThemesBloc>(context).theme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: widget.border,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        initialValue: widget.initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validation,
        keyboardType: widget.inputType,
        cursorColor: Colors.green,
        obscureText: isPasswordHiden,
        onChanged: widget.callback,
        maxLines: widget.maxLines,
        textAlign: TextAlign.start,
        inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
        style: TextStyle(color: theme.mainTextColor),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          icon: Icon(widget.icon, color: theme.mainTextColor),
          hintText: widget.hint,
          hintStyle: TextStyle(color: theme.mainTextColor, fontSize: 15),
          contentPadding: EdgeInsets.zero,
          alignLabelWithHint: true,
          isCollapsed: true,
          suffixIcon: (widget.isPassword && widget.isPasswordCanBeVisible)
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordHiden = !isPasswordHiden;
                    });
                  },
                  child: Icon(
                    isPasswordHiden ? Icons.visibility : Icons.visibility_off,
                    color: theme.mainTextColor,
                  ))
              : Icon(
                  widget.suffixIcon,
                  color: theme.mainTextColor,
                ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
