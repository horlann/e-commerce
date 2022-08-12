import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_event.dart';
import 'package:kurilki/presentation/bloc/products/products_state.dart';
import 'package:kurilki/presentation/pages/home/components/search_product.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/icons.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

import 'components/all_products.dart';
import 'components/popular_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsBloc bloc = BlocProvider.of<ProductsBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return Container(
      color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(adaptiveWidth(8.0)),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                const Expanded(
                    flex: 2, child: CustomImageProvider(imageFrom: ImageFrom.asset, imageLink: CustomIcons.logo)),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(adaptiveWidth(8.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [theme.appShadows.largeShadow],
                          borderRadius: const BorderRadius.all(Radius.circular(32))),
                      child: RoundedInputField(
                        icon: Icons.search,
                        hint: Strings.search,
                        callback: (String callback) {
                          if (callback.isNotEmpty) {
                            bloc.add(SearchProductEvent(callback));
                          } else {
                            bloc.add(const ShowPageEvent());
                            FocusScope.of(context).unfocus();
                          }
                        },
                        validation: (value) => null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: ((context, state) {
                if (state is ProductsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchProductState) {
                  return SearchProduct(items: state.items);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PopularProducts(),
                      AllProducts(),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
