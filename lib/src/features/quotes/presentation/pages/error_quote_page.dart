import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/animated_quote_page.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_button.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';

class ErrorQuotePage extends StatelessWidget {
  final PageController controller;
  final int index;
  final bool loading;
  final VoidCallback? onRefresh;

  const ErrorQuotePage({
    required this.controller,
    required this.index,
    this.loading = false,
    this.onRefresh,
    super.key,
  });

  final quote = const Quote(
    id: 0,
    quote: 'When things go wrong don\'t go with them',
    author: 'Elvis Presley',
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
