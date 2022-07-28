import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_state.dart';
import 'package:kurilki/presentation/bloc/details/details_bloc.dart';
import 'package:kurilki/presentation/bloc/details/details_event.dart';
import 'package:kurilki/presentation/bloc/details/details_state.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/Image_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Item product;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    return BlocProvider(
      create: (context) => DetailsBloc(product, productsBloc, getIt.call())..add(const InitDetailsPageEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: theme.whiteTextColor),
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final int countInCart = cartBloc.countOfItemsInCart(product.uuid);
                return ElevatedButton(
                  onPressed: () {
                    cartBloc.add(AddToCartEvent(product, countInCart + 1));
                  },
                  style: ElevatedButton.styleFrom(primary: theme.accentColor, shape: const StadiumBorder()),
                  child: Text(countInCart == 0 ? "Add to Cart" : countInCart.toString()),
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
                imageUrl: product.imageLink,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
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
                            product.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "\$" + product.price.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Tastes",
                      style: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    product is DisposablePodEntity
                        ? Text(
                            "Puffs ${(product as DisposablePodEntity).puffsCount}",
                            style: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    product is Snus
                        ? Text(
                            "Strenght ${(product as Snus).strength}",
                            style: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        : const SizedBox.shrink(),
                    BlocBuilder<DetailsBloc, DetailsState>(
                      builder: (context, state) {
                        if (state is DetailsLoadedState) {
                          List<Item> items = state.list;
                          return Center(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              runSpacing: 10,
                              spacing: 10,
                              children: items
                                  .map((e) => Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(border: Border.all()),
                                        child:
                                            CustomImageProvider(imageLink: e.imageLink, imageFrom: ImageFrom.network),
                                      ))
                                  .toList(),
                            ),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
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
