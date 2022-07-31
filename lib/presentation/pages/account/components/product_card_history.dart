import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kurilki/presentation/pages/account/product_history.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/widgets/Image_provider.dart';

class ProductCardHistory extends StatelessWidget {
  final ProductHistory item;
  final AbstractTheme theme;
  final double width;
  const ProductCardHistory({
    Key? key,
    required this.item,
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
                imageLink: item.image,
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
                  item.name,
                  maxLines: 2,
                  minFontSize: 14,
                  maxFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: theme.mainTextColor,
                  ),
                ),
              ),
              Text(
                "\$" + (item.price * item.count).toString(),
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: theme.secondaryTextColor,
                ),
              ),
              Text(
                item.data,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: theme.secondaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
