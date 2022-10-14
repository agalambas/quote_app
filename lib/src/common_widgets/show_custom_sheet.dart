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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: const Icon(
              Icons.horizontal_rule_rounded,
              color: Colors.black87,
              size: 32,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}
