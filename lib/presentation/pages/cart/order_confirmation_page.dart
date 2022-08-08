import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
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
    return BlocBuilder<CartBloc, CartState>(
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
  final List<String> _deliveryTypes = [Strings.pickUp, Strings.delivery];
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.ordering,
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.mainTextColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: adaptiveWidth(300),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedInputField(
                    hint: Strings.nameItem,
                    initialValue: _name,
                    callback: (String callback) {
                      _name = callback;
                    },
                    border: Border.all(color: theme.mainTextColor),
                    validation: ValidationBuilder()
                        .minLength(10, Strings.min10Characters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  ),
                  SizedBox(height: adaptiveHeight(20)),
                  RoundedInputField(
                    hint: Strings.phoneNumber,
                    initialValue: _phone,
                    callback: (String callback) {
                      _phone = callback;
                    },
                    border: Border.all(color: theme.mainTextColor),
                    inputType: TextInputType.phone,
                    validation: ValidationBuilder()
                        .minLength(10, Strings.min10Characters)
                        .maxLength(30, Strings.max30Characters)
                        .phone(Strings.onlyNumbers)
                        .build(),
                  ),
                  SizedBox(height: adaptiveHeight(20)),
                  _CategorySelector(
                    callback: (String type) {
                      setState(() {
                        _deliveryType = type;
                      });
                    },
                  ),
                  SizedBox(height: adaptiveHeight(20)),
                  _deliveryType != DeliveryType.pickUp.name
                      ? Column(
                          children: [
                            RoundedInputField(
                              hint: Strings.address,
                              initialValue: _address,
                              callback: (String callback) {
                                _address = callback;
                              },
                              border: Border.all(color: theme.mainTextColor),
                              validation: ValidationBuilder()
                                  .minLength(10, Strings.min10Characters)
                                  .maxLength(30, Strings.max30Characters)
                                  .build(),
                            ),
                            SizedBox(height: adaptiveHeight(10)),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(height: adaptiveHeight(10)),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: MainRoundedButton(
                          text: Strings.backButton,
                          color: theme.backgroundColor,
                          border: Border.all(color: theme.mainTextColor),
                          textStyle: TextStyle(color: theme.mainTextColor, fontWeight: FontWeight.w500, fontSize: 18),
                          callback: () {
                            cartBloc.add(const InitCartEvent());
                            context.popRoute();
                          },
                          theme: theme,
                        ),
                      ),
                      SizedBox(width: adaptiveHeight(8)),
                      Flexible(
                        flex: 2,
                        child: MainRoundedButton(
                          text: Strings.confirmButton,
                          color: theme.mainTextColor,
                          textStyle: TextStyle(color: theme.whiteTextColor, fontWeight: FontWeight.w500, fontSize: 18),
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
      ),
    );
  }
}

class _CategorySelector extends StatefulWidget {
  const _CategorySelector({Key? key, required this.callback}) : super(key: key);
  final Function(String type) callback;

  @override
  State<_CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<_CategorySelector> {
  int _selectedCategory = 1;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return SizedBox(
      height: adaptiveHeight(40),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MainRoundedButton(
              text: Strings.pickUp,
              border: Border.all(color: theme.mainTextColor, width: 2),
              color: _selectedCategory == 1 ? theme.mainTextColor : theme.cardColor,
              callback: () {
                _selectedCategory = 1;
                widget.callback('pickUp');
                setState(() {});
              },
              theme: theme,
              textStyle: theme.fontStyles.regular14.copyWith(
                color: _selectedCategory == 1 ? theme.whiteTextColor : theme.mainTextColor,
              ),
            ),
          ),
          SizedBox(width: adaptiveWidth(5)),
          Expanded(
            child: MainRoundedButton(
              text: Strings.delivery,
              border: Border.all(color: theme.mainTextColor, width: 2),
              color: _selectedCategory == 2 ? theme.mainTextColor : theme.cardColor,
              callback: () {
                _selectedCategory = 2;
                widget.callback('delivery');
                setState(() {});
              },
              theme: theme,
              textStyle: theme.fontStyles.regular14.copyWith(
                color: _selectedCategory == 2 ? theme.whiteTextColor : theme.mainTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
