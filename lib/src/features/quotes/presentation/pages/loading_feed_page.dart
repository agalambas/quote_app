import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/animated_feed_page.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';

class LoadingFeedPage extends StatelessWidget {
  final PageController controller;
  final int index;

  LoadingFeedPage({
    required this.controller,
    required this.index,
    super.key,
  });

  late final quote = StyledQuote(
    id: 0,
    quote: 'It is not the load that breaks you down,'
        ' it\'s the way you carry it',
    author: 'Lena Horne',
    styleId: index,
  );

  @override
  Widget build(BuildContext context) {
    final style = QuoteStyle.fromIndex(index);
    return AnimatedFeedPage(
      controller: controller,
      index: index,
      backgroundColor: style.backgroundColor,
      child: Column(
        children: [
          Expanded(child: QuoteCard(quote)),
          const SizedBox(height: 48),
          CircularProgressIndicator(color: style.foregroundColor),
        ],
      ),
    );
  }
}
