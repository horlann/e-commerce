import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/screens/product_history.dart';
import 'package:kurilki/presentation/widgets/Image_provider.dart';

class ProductCardHistory extends StatelessWidget {
  final ProductHistory product;
  final AbstractTheme theme;
  final double width;
  const ProductCardHistory({
    Key? key,
    required this.product,
    required this.theme,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: CustomImageProvider(
                imageLink: product.image,
                imageFrom: ImageFrom.network,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              SizedBox(
                width: width - 180,
                child: AutoSizeText(
                  product.title,
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
              Text(
                "\$" + (product.price * product.count).toString(),
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: theme.inactiveTextColor),
              ),
              Text(
                product.data,
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: theme.inactiveTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
