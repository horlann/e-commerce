import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/user_data.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
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
        if (state is InProgressAuthState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDataLoaded) {
          return _OrderConfirmation(user: state.user);
        } else if (state is LocalUserDataLoaded) {
          //TODO: Implement loading local user data
          return const _OrderConfirmation(user: null);
        } else {
          return const SizedBox(
            child: Center(child: Text("Error")),
          );
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
  String _deliveryType = Strings.pickUp;
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedInputField(
                    hint: Strings.fullName,
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
                    icon: Icons.phone_android,
                    hint: Strings.phoneNumber,
                    initialValue: _phone,
                    callback: (String callback) {
                      _phone = callback;
                    },
                    border: Border.all(color: theme.mainTextColor),
                    inputType: TextInputType.phone,
                    validation: ValidationBuilder()
                        .regExp(RegExp(r'(^(?:[+]38)?[0-9]{10,12}$)'), Strings.onlyPhone)
                        .minLength(10, Strings.min10Characters)
                        .maxLength(30, Strings.max12Characters)
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
                  _deliveryType != Strings.pickUp
                      ? Column(
                          children: [
                            RoundedInputField(
                              icon: Icons.location_on_sharp,
                              hint: Strings.address,
                              initialValue: _address,
                              callback: (String callback) {
                                _address = callback;
                              },
                              border: Border.all(color: theme.mainTextColor),
                              validation: ValidationBuilder()
                                  .minLength(10, Strings.min10Characters)
                                  .maxLength(50, Strings.max50Characters)
                                  .build(),
                            ),
                            SizedBox(height: adaptiveHeight(10)),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(height: adaptiveHeight(10)),
                  _PriceInformation(
                    title: Strings.priceItems,
                    price: cartBloc.priceDetails.itemsPrice.toStringAsFixed(0),
                  ),
                  _PriceInformation(
                    title: Strings.priceDelivety,
                    price: cartBloc.priceDetails.deliveryPrice.toStringAsFixed(0),
                  ),
                  if (cartBloc.priceDetails.coupon > 0)
                    _PriceInformation(
                      title: Strings.discount,
                      price: cartBloc.priceDetails.coupon.toStringAsFixed(0),
                    ),
                  _PriceInformation(
                    title: Strings.total,
                    price: cartBloc.priceDetails.totalPrice.toStringAsFixed(0),
                  ),
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
                            //TODO: Fix loading cart items
                            cartBloc.add(const InitCartEvent());
                            context.popRoute();
                          },
                          theme: theme,
                        ),
                      ),
                      SizedBox(width: adaptiveWidth(5)),
                      Flexible(
                        flex: 2,
                        child: MainRoundedButton(
                          text: Strings.confirmButton,
                          color: theme.mainTextColor,
                          callback: () {
                            if (_formKey.currentState!.validate()) {
                              if (_name.isNotEmpty && _phone.isNotEmpty) {
                                final UserData userData = UserData(
                                  deliveryType:
                                      _deliveryType == Strings.pickUp ? DeliveryType.pickUp : DeliveryType.delivery,
                                  name: _name,
                                  phone: _phone,
                                );
                                if (_deliveryType != Strings.pickUp && _address.isEmpty) {
                                  cartBloc.add(ConfirmOrderEvent(userData: userData));
                                  accountBloc.add(SaveDataEvent(
                                    userData: userData,
                                    cartItems: cartBloc.cartItems,
                                  ));
                                } else {
                                  cartBloc.add(ConfirmOrderEvent(userData: userData.copyWith(address: _address)));
                                  accountBloc.add(SaveDataEvent(
                                    userData: userData.copyWith(address: _address),
                                    cartItems: cartBloc.cartItems,
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

class _PriceInformation extends StatelessWidget {
  const _PriceInformation({Key? key, required this.title, required this.price}) : super(key: key);
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Text(
            title,
            style: theme.fontStyles.regular16.copyWith(color: theme.inactiveTextColor),
          ),
          const Expanded(child: SizedBox()),
          Text(
            "₴ $price",
            style: theme.fontStyles.semiBold16.copyWith(color: theme.mainTextColor),
          ),
        ],
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
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

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
                widget.callback(Strings.pickUp);
                cartBloc.add(const DeliveryChangedEvent(deliveryType: DeliveryType.pickUp));
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
            flex: 2,
            child: MainRoundedButton(
              text: Strings.delivery,
              border: Border.all(color: theme.mainTextColor, width: 2),
              color: _selectedCategory == 2 ? theme.mainTextColor : theme.cardColor,
              callback: () {
                _selectedCategory = 2;
                cartBloc.add(const DeliveryChangedEvent(deliveryType: DeliveryType.delivery));
                widget.callback(Strings.delivery);
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
