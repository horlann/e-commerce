import 'package:flutter/material.dart';

import 'section_title.dart';

class NewArrivalProducts extends StatelessWidget {
  const NewArrivalProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "New Arrival",
          pressSeeAll: () {},
        ),
        // SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: List.generate(
        //       demo_product.length,
        //       (index) => Padding(
        //         padding: const EdgeInsets.only(right: defaultPadding),
        //         child: ProductCard(
        //           title: demo_product[index].title,
        //           image: demo_product[index].image,
        //           price: demo_product[index].price,
        //           bgColor: demo_product[index].bgColor,
        //           press: () {
        //             AutoRouter.of(context).push(DetailsRouter(product: demo_product[index]));
        //           },
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
