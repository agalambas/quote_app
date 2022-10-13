import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/animated_quote_page.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';

class LoadingQuotePage extends StatelessWidget {
  final PageController controller;
  final int index;

  const LoadingQuotePage({
    required this.controller,
    required this.index,
    super.key,
  });

  final quote = const Quote(
    id: 0,
    quote: 'It is not the load that breaks you down,'
        ' it\'s the way you carry it',
    author: 'Lena Horne',
  );

  @override
  Widget build(BuildContext context) {
    final style = QuoteStyle.fromPosition(index);
    return AnimatedQuotePage(
      controller: controller,
      index: index,
      backgroundColor: style.backgroundColor,
      child: Column(
        children: [
          Expanded(child: QuoteCard(quote, style: style)),
          const SizedBox(height: 48),
          CircularProgressIndicator(color: style.foregroundColor),
        ],
      ),
    );
  }
}
