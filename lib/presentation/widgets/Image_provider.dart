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

    return CachedNetworkImage(
      imageUrl: imageLink,
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: (Colors.grey[300]) ?? Colors.white,
          highlightColor: (Colors.grey[100]) ?? Colors.green,
          child: Container(
            color: Colors.grey,
          )),
      errorWidget: (context, url, error) => Icon(
        Icons.error_outline,
        color: theme.wrongColor,
      ),
    );
  }
}

enum ImageFrom { network, asset, file }
