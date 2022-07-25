import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/domain/entities/item.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/Image_provider.dart';

class ProductCard extends StatelessWidget {
  final Item product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(DetailsRouter(product: product));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 90.0,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: CustomImageProvider(imageLink: product.imageLink, imageFrom: ImageFrom.network),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  SizedBox(
                    child: AutoSizeText(
                      product.name,
                      maxLines: 2,
                      minFontSize: 14,
                      maxFontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: theme.infoTextColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon((Icons.close)),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: theme.backgroundColor),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "x 1",
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: theme.inactiveTextColor),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
