import 'package:flutter/material.dart';

class QuoteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final OutlinedBorder? shape;

  const QuoteButton({
    super.key,
    this.onPressed,
    this.shape,
    required this.child,
  });

  double get dimension => 16 + 24; // padding + icon size

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      margin: const EdgeInsets.all(8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          shape: shape,
          side: const BorderSide(color: Colors.white54),
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
