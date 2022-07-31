import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final List<String> _deliveryTypes = [Const.pickUp, Const.deliveryNova];
  final List<String> _payTypes = [Const.bankTransfer, Const.cashOnDelivery];
  String _deliveryType = Const.pickUp;
  String _payType = Const.bankTransfer;
  String _name = "";
  String _phone = "";
  String _address = "";

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final scale = byWithScale(context);
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: scale * 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedInputField(
                hint: "Name",
                callback: (String callback) {
                  _name = callback;
                },
              ),
              SizedBox(height: scale * 10),
              RoundedInputField(
                hint: "Phone number ",
                callback: (String callback) {
                  _phone = callback;
                },
                inputType: TextInputType.phone,
              ),
              SizedBox(height: scale * 10),
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
              SizedBox(height: scale * 10),
              _deliveryType != "Pick up"
                  ? Column(
                      children: [
                        RoundedInputField(
                          hint: "Address",
                          callback: (String callback) {
                            _address = callback;
                          },
                        ),
                        SizedBox(height: scale * 10),
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
              SizedBox(height: scale * 10),
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
                  SizedBox(width: scale * 5),
                  Flexible(
                    flex: 2,
                    child: MainRoundedButton(
                      text: "Confirm",
                      color: theme.accentColor,
                      textStyle: TextStyle(color: theme.mainTextColor, fontWeight: FontWeight.w500, fontSize: 18),
                      callback: () {
                        if (_name.isNotEmpty && _phone.isNotEmpty) {
                          if (_deliveryType != Const.pickUp && _address.isEmpty) {
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
    );
  }
}
