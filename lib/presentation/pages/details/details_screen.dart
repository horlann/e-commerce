import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_state.dart';
import 'package:kurilki/presentation/bloc/details/details_bloc.dart';
import 'package:kurilki/presentation/bloc/details/details_event.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.itemConfiguration != -1) {
      itemSettings = widget.product.itemSettings[widget.itemConfiguration];
    }
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    return BlocProvider(
      create: (context) => DetailsBloc(widget.product, productsBloc, getIt.call())..add(const InitDetailsPageEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: theme.accentColor),
          backgroundColor: theme.backgroundColor,
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final int countInCart = cartBloc.countOfItemsInCart(widget.product.uuid);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (itemSettings != null) {
                        if (widget.product is DisposablePodEntity) {}
                        cartBloc.add(AddToCartEvent(widget.product, countInCart + 1, itemSettings!));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: itemSettings != null ? theme.secondaryAccentColor : theme.inactiveColor,
                        shape: const StadiumBorder()),
                    child: Text(countInCart == 0 ? "Add to Cart" : countInCart.toString()),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  "assets/icons/Heart.svg",
                  height: 20,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: itemSettings?.imageLink ?? widget.product.imageLink,
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "₴" + widget.product.price.toStringAsFixed(0),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    widget.product is DisposablePodEntity
                        ? Text(
                            "Puffs ${(widget.product as DisposablePodEntity).puffsCount}",
                            style: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    widget.product is Snus
                        ? Text(
                            "Strenght ${(widget.product as Snus).strength}",
                            style: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 12),
                    itemSettings != null
                        ? Text(
                            "Taste: ${itemSettings!.name}",
                            style: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 12),
                    if (widget.product is DisposablePodEntity)
                      Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 10,
                        spacing: 10,
                        children: (widget.product as DisposablePodEntity).itemSettings.map((e) {
                          final bool isSelected = (itemSettings?.uuid ?? 'null') == e.uuid;
                          final bool canBeDisplayed = e.count > 0 && e.isAvailable;
                          return GestureDetector(
                            onTap: () {
                              if (!isSelected && e.count > 0 && e.isAvailable) {
                                setState(() {
                                  itemSettings = e;
                                });
                              }
                            },
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: isSelected ? theme.secondaryAccentColor : theme.inactiveColor,
                                            width: 2.5)),
                                    child: CustomImageProvider(imageLink: e.imageLink, imageFrom: ImageFrom.network),
                                  ),
                                  if (!canBeDisplayed)
                                    Container(
                                      color: theme.inactiveColor.withOpacity(0.6),
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Icon(Icons.clear, color: theme.wrongColor, size: 40),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
