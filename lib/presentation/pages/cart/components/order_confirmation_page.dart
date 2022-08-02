import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _deliveryTypes = [Strings.pickUp, Strings.deliveryNova];
  final List<String> _payTypes = [Strings.bankTransfer, Strings.cashOnDelivery];
  String _deliveryType = Strings.pickUp;
  String _payType = Strings.bankTransfer;
  String _name = "";
  String _phone = "";
  String _address = "";

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: adaptiveWidth(300),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInputField(
                  hint: "Name",
                  callback: (String callback) {
                    _name = callback;
                  },
                  validation: ValidationBuilder()
                      .minLength(10, Strings.min10Characters)
                      .maxLength(30, Strings.max30Characters)
                      .build(),
                ),
                SizedBox(height: adaptiveHeight(20)),
                RoundedInputField(
                  hint: "Phone number ",
                  callback: (String callback) {
                    _phone = callback;
                  },
                  inputType: TextInputType.phone,
                  validation: ValidationBuilder()
                      .minLength(10, Strings.min10Characters)
                      .maxLength(30, Strings.max30Characters)
                      .phone(Strings.onlyNumbers)
                      .build(),
                ),
                SizedBox(height: adaptiveHeight(20)),
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioGroup<String>.builder(
                      activeColor: theme.mainTextColor,
                      textStyle: TextStyle(color: theme.mainTextColor),
                      spacebetween: 40,
                      groupValue: _deliveryType,
                      onChanged: (value) => setState(() {
                        _deliveryType = value as String;
                      }),
                      items: _deliveryTypes,
                      itemBuilder: (item) => RadioButtonBuilder(item),
                    ),
                  ),
                ),
                SizedBox(height: adaptiveHeight(20)),
                _deliveryType != "Pick up"
                    ? Column(
                        children: [
                          RoundedInputField(
                            hint: "Address",
                            callback: (String callback) {
                              _address = callback;
                            },
                            validation: ValidationBuilder()
                                .minLength(10, Strings.min10Characters)
                                .maxLength(30, Strings.max30Characters)
                                .build(),
                          ),
                          SizedBox(height: adaptiveHeight(10)),
                        ],
                      )
                    : const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioGroup<String>.builder(
                      activeColor: theme.mainTextColor,
                      textStyle: TextStyle(color: theme.mainTextColor),
                      spacebetween: 40,
                      groupValue: _payType,
                      onChanged: (value) => setState(() {
                        _payType = value as String;
                      }),
                      items: _payTypes,
                      itemBuilder: (item) => RadioButtonBuilder(item),
                    ),
                  ),
                ),
                SizedBox(height: adaptiveHeight(10)),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: MainRoundedButton(
                        text: "Back",
                        color: theme.accentColor,
                        textStyle: TextStyle(color: theme.mainTextColor, fontWeight: FontWeight.w500, fontSize: 18),
                        callback: () => cartBloc.add(const InitCartEvent()), //TODO: implement loading CachedCartItems
                        theme: theme,
                      ),
                    ),
                    SizedBox(width: adaptiveHeight(5)),
                    Flexible(
                      flex: 2,
                      child: MainRoundedButton(
                        text: "Confirm",
                        color: theme.accentColor,
                        textStyle: TextStyle(color: theme.mainTextColor, fontWeight: FontWeight.w500, fontSize: 18),
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            if (_name.isNotEmpty && _phone.isNotEmpty) {
                              if (_deliveryType != Strings.pickUp && _address.isEmpty) {
                                cartBloc.add(ConfirmOrderEvent(
                                  deliveryType: _deliveryType,
                                  name: _name,
                                  payType: _payType,
                                  phone: _phone,
                                ));
                              } else {
                                cartBloc.add(ConfirmOrderEvent(
                                  deliveryType: _deliveryType,
                                  name: _name,
                                  payType: _payType,
                                  phone: _phone,
                                  address: _address,
                                ));
                              }
                            }
                          }
                        },
                        theme: theme,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
