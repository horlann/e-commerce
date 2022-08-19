import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageProvider extends StatelessWidget {
  const CustomImageProvider({Key? key, required this.imageFrom, required this.imageLink}) : super(key: key);
  final ImageFrom imageFrom;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    if (imageFrom == ImageFrom.network) {
      return CachedNetworkImage(
        imageUrl: imageLink,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
            baseColor: (Colors.grey[300]) ?? Colors.white,
            highlightColor: (Colors.grey[100]) ?? Colors.white,
            child: Container(
              color: Colors.grey,
            )),
        errorWidget: (context, url, error) => Container(
          color: theme.backgroundColor,
          height: double.infinity,
          child: Icon(
            Icons.error_outline,
            color: theme.wrongColor,
          ),
        ),
      );
    } else {
      return Image.asset(imageLink);
    }
  }
}

enum ImageFrom { network, asset, file }
