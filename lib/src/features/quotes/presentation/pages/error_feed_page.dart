import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/animated_feed_page.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_button.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';

class ErrorFeedPage extends StatelessWidget {
  final PageController controller;
  final int index;
  final bool loading;
  final VoidCallback? onRefresh;

  ErrorFeedPage({
    required this.controller,
    required this.index,
    this.loading = false,
    this.onRefresh,
    super.key,
  });

  late final quote = StyledQuote(
    id: 0,
    quote: 'When things go wrong don\'t go with them',
    author: 'Elvis Presley',
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
          loading
              ? CircularProgressIndicator(color: style.foregroundColor)
              : QuoteButton(
                  onPressed: onRefresh,
                  child: const Text('Refresh'),
                ),
        ],
      ),
    );
  }
}
