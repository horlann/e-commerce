import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(border: Border(top: BorderSide(width: 2, color: Colors.black))),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            child: const SizedBox(
              width: double.infinity,
              child: Center(
                  child: Icon(
                Icons.home,
                color: Colors.black,
              )),
            ),
          )),
          Expanded(
              child: GestureDetector(
            child: const SizedBox(
              width: double.infinity,
              child: Center(
                  child: Icon(
                Icons.account_circle_sharp,
                color: Colors.black,
              )),
            ),
          )),
          Expanded(
              child: GestureDetector(
            child: const SizedBox(
              width: double.infinity,
              child: Center(
                  child: Icon(
                Icons.shopping_cart_rounded,
                color: Colors.black,
              )),
            ),
          ))
        ],
      ),
    );
  }
}
