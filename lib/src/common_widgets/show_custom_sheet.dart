import 'package:flutter/material.dart';

void showCustomSheet({
  required BuildContext context,
  required Widget child,
}) {
  final mediaQuery = MediaQuery.of(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => SizedBox(
      height: mediaQuery.size.height - mediaQuery.padding.top - kToolbarHeight,
      child: Column(
        children: [
          Container(
            height: 48,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Container(
              height: 4,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Expanded(
            child: Container(color: Colors.white, child: child),
          ),
        ],
      ),
      // child: BottomSheet(
      //   onClosing: () {},
      //   builder: (context) => Container(
      //       // margin: const EdgeInsets.only(top: 100),
      //       ),
      // ),
    ),
  );
}
