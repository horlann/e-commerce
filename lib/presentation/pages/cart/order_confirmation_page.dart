import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/user_data.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_state.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is InProgressCartState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDataLoaded) {
          return _OrderConfirmation(user: state.user);
        } else {
          return const Center(child: Text('error'));
        }
      },
    );
  }
}

class _OrderConfirmation extends StatefulWidget {
  const _OrderConfirmation({Key? key, required this.user}) : super(key: key);
  final UserEntity? user;

  @override
  State<_OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<_OrderConfirmation> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _deliveryTypes = [Strings.pickUp, Strings.deliveryNova];
  final List<String> _payTypes = [Strings.bankTransfer, Strings.cashOnDelivery];
  String _deliveryType = Strings.pickUp;
  String _payType = Strings.bankTransfer;
  UserEntity? _user;
  String _name = "";
  String _phone = "";
  String _address = "";

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    if (_user != null) {
      _name = _user!.deliveryDetails.name;
      _phone = _user!.deliveryDetails.phone;
      _address = _user!.deliveryDetails.address;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);

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
                  hint: Strings.fullName,
                  initialValue: _name,
                  callback: (String callback) => _name = callback,
                  validation: ValidationBuilder()
                      .minLength(10, Strings.min10Characters)
                      .maxLength(30, Strings.max30Characters)
                      .build(),
                ),
                SizedBox(height: adaptiveHeight(20)),
                RoundedInputField(
                  icon: Icons.phone_android,
                  hint: Strings.phoneNumber,
                  initialValue: _phone,
                  callback: (String callback) => _phone = callback,
                  inputType: TextInputType.phone,
                  validation: ValidationBuilder()
                      .phone(Strings.onlyNumbers)
                      .minLength(10, Strings.min10Characters)
                      .maxLength(12, Strings.max12Characters)
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
                _deliveryType != Strings.pickUp
                    ? Column(
                        children: [
                          RoundedInputField(
                            hint: Strings.address,
                            initialValue: _address,
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
                        text: Strings.backButton,
                        color: theme.accentColor,
                        textStyle: TextStyle(color: theme.mainTextColor, fontWeight: FontWeight.w500, fontSize: 18),
                        callback: () {
                          cartBloc.add(const InitCartEvent());
                          context.popRoute();
                        },
                        theme: theme,
                      ),
                    ),
                    SizedBox(width: adaptiveHeight(5)),
                    Flexible(
                      flex: 2,
                      child: MainRoundedButton(
                        text: Strings.confirmButton,
                        color: theme.accentColor,
                        textStyle: TextStyle(color: theme.mainTextColor, fontWeight: FontWeight.w500, fontSize: 18),
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            if (_name.isNotEmpty && _phone.isNotEmpty) {
                              final UserData userData = UserData(
                                deliveryType: _deliveryType == Strings.pickUp
                                    ? DeliveryType.pickUp
                                    : DeliveryType.deliveryNovaPost,
                                name: _name,
                                payType: _payType,
                                phone: _phone,
                              );
                              if (_deliveryType != Strings.pickUp && _address.isEmpty) {
                                cartBloc.add(ConfirmOrderEvent(userData: userData));
                                accountBloc.add(SaveDataEvent(userData: userData));
                              } else {
                                cartBloc.add(ConfirmOrderEvent(userData: userData.copyWith(address: _address)));
                                accountBloc.add(SaveDataEvent(userData: userData.copyWith(address: _address)));
                              }
                              AutoRouter.of(context).pop();
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
