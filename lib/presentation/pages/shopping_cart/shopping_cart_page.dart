import 'package:flutter/material.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = Provider.of<ThemesBloc>(context).theme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: theme.backgroundColor)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // Expanded(
              //   child: ListView.separated(
              //     itemCount: demo_product.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return ProductCard(
              //         product: demo_product[index],
              //         theme: theme,
              //         width: screenSize.width,
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) =>
              //         const SizedBox(height: defaultPadding),
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color: theme.backgroundColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "Total: 1000\$",
                      style:
                          TextStyle(color: theme.infoTextColor, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: MainRoundedButton(
                        callback: () {},
                        color: theme.accentColor,
                        text: 'Check Out',
                        theme: theme,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
