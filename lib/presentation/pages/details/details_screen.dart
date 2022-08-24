import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    this.itemConfiguration = -1,
  }) : super(key: key);

  final Item product;
  final int itemConfiguration;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ItemSettings? itemSettings;
  late final Item item;
  int selectedCount = 1;

  @override
  void initState() {
    super.initState();

    item = widget.product;
    if (widget.itemConfiguration != -1) {
      itemSettings = widget.product.itemSettings[widget.itemConfiguration];
    }
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(slivers: [
              SliverAppBar(
                leading: const SizedBox.shrink(),
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                collapsedHeight: adaptiveHeight(335),
                flexibleSpace: Stack(
                  children: [
                    Center(
                      child: CustomImageProvider(
                        imageFrom: ImageFrom.network,
                        imageLink: itemSettings?.imageLink ?? item.imageLink,
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: MediaQuery.of(context).padding.top + 18,
                      child: GestureDetector(
                        onTap: () {
                          context.popRoute();
                        },
                        child: Container(
                          width: adaptiveWidth(36),
                          height: adaptiveWidth(36),
                          child: Icon(
                            Icons.chevron_left,
                            color: theme.mainTextColor,
                          ),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: theme.fillColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      width: getScreenWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        boxShadow: [theme.appShadows.largeShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: theme.fontStyles.semiBold22.copyWith(color: theme.infoTextColor),
                          ),
                          SizedBox(height: adaptiveHeight(10)),
                          item is DisposablePodEntity
                              ? Text(
                                  "${Strings.puffs}: ${(widget.product as DisposablePodEntity).puffsCount}",
                                  style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
                                )
                              : const SizedBox.shrink(),
                          item is Snus
                              ? Text(
                                  "${Strings.strength}: ${(widget.product as Snus).strength}",
                                  style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(height: adaptiveHeight(10)),
                          itemSettings != null
                              ? Text(
                                  "${Strings.taste}: ${itemSettings!.name}",
                                  style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: adaptiveWidth(20),
                            runSpacing: adaptiveHeight(10),
                            children: item.itemSettings.map((e) {
                              final bool isSelected = (itemSettings?.uuid ?? 'null') == e.uuid;
                              final bool canBeDisplayed = e.count > 0 && e.isAvailable;
                              return GestureDetector(
                                onTap: () {
                                  if (!isSelected && e.count > 0 && e.isAvailable) {
                                    setState(() {
                                      itemSettings = e;
                                      selectedCount = 1;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: adaptiveWidth(70),
                                  height: adaptiveWidth(70),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                                          boxShadow: [theme.appShadows.baseShadow],
                                          border: Border.all(
                                            color: isSelected ? theme.secondaryAccentColor : theme.inactiveColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(14)),
                                          child:
                                              CustomImageProvider(imageLink: e.imageLink, imageFrom: ImageFrom.network),
                                        ),
                                      ),
                                      if (!canBeDisplayed)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: theme.inactiveColor.withOpacity(0.5),
                                            boxShadow: [theme.appShadows.baseShadow],
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(
                                              color: theme.inactiveColor,
                                              width: 1,
                                            ),
                                          ),
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Icon(Icons.clear, color: theme.wrongColor, size: adaptiveWidth(40)),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(adaptiveWidth(12)),
            child: Row(
              children: [
                Text(
                  "₴${item.price.toStringAsFixed(0)}",
                  style: theme.fontStyles.semiBold22.copyWith(color: theme.mainTextColor),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: adaptiveWidth(5)),
                      _RoundButton(
                          type: "-",
                          callback: () {
                            if (selectedCount > 1) {
                              selectedCount--;
                              setState(() {});
                            }
                          }),
                      SizedBox(
                        width: adaptiveWidth(5),
                      ),
                      Text(
                        selectedCount.toString(),
                        style: theme.fontStyles.semiBold14.copyWith(color: theme.infoTextColor),
                      ),
                      SizedBox(
                        width: adaptiveWidth(5),
                      ),
                      _RoundButton(
                          type: "+",
                          callback: () {
                            int countInCart = 0;
                            for (CartItem cartItem in cartBloc.cartItems) {
                              if (cartItem.itemSettings == itemSettings) {
                                countInCart = cartItem.count;
                              }
                            }
                            if (itemSettings == null) {
                              selectedCount++;
                              setState(() {});
                            } else if (selectedCount + countInCart < itemSettings!.count) {
                              selectedCount++;
                              setState(() {});
                            }
                          }),
                      SizedBox(
                        width: adaptiveWidth(5),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: adaptiveWidth(150),
                  height: adaptiveHeight(42),
                  child: MainRoundedButton(
                      text: Strings.addToCartButton,
                      color: theme.mainTextColor,
                      callback: () {
                        final bool isPicked = itemSettings != null || item.itemSettings.isEmpty;
                        if (isPicked) {
                          if (itemSettings != null) {
                            int countInCart = 0;
                            for (CartItem cartItem in cartBloc.cartItems) {
                              if (cartItem.itemSettings == itemSettings) {
                                countInCart = cartItem.count;
                              }
                            }
                            if (selectedCount + countInCart <= itemSettings!.count) {
                              cartBloc.add(AddToCartEvent(item, selectedCount, itemSettings!));
                              CustomSnackBar.showSnackNar(context, Strings.warning, Strings.productIsAdded);
                            } else {
                              CustomSnackBar.showSnackNar(context, Strings.warning, Strings.productIsOver);
                            }
                          } else {
                            cartBloc.add(
                              AddToCartEvent(
                                item,
                                selectedCount,
                                ItemSettings.empty(
                                  imageLink: item.imageLink,
                                  isAvailable: item.isAvailable,
                                  count: 0,
                                  uuid: item.uuid,
                                ),
                              ),
                            );
                            CustomSnackBar.showSnackNar(context, Strings.warning, Strings.productIsAdded);
                          }
                          selectedCount = 1;
                          setState(() {});
                        } else {
                          CustomSnackBar.showSnackNar(context, Strings.warning, Strings.firstChooseProduct);
                        }
                      },
                      theme: theme),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    Key? key,
    required this.type,
    required this.callback,
  }) : super(key: key);

  final String type;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(42)),
      child: Material(
        color: theme.cardColor,
        child: InkWell(
          onTap: callback,
          child: Container(
            height: adaptiveHeight(42),
            width: adaptiveWidth(42),
            decoration: BoxDecoration(
              border: Border.all(color: theme.mainTextColor, width: 1),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
              type,
              style: theme.fontStyles.regular18.copyWith(color: theme.mainTextColor),
            )),
          ),
        ),
      ),
    );
  }
}
