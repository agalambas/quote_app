import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/common_widgets/swipe_left_indicator.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/animated_quote_page.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/quote_page_controller.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_button.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';

class QuotePage extends ConsumerWidget {
  final Quote quote;
  final PageController controller;
  final int index;

  const QuotePage(
    this.quote, {
    required this.controller,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final saveState = ref.watch(quoteSaveControllerProvider(quote.id));
    final quoteSaveController =
        ref.watch(quoteSaveControllerProvider(quote.id).notifier);
    final shareState = ref.watch(quoteShareControllerProvider(quote.id));
    final quoteShareController =
        ref.watch(quoteShareControllerProvider(quote.id).notifier);
    //
    final style = QuoteStyle.fromPosition(index);
    return AnimatedQuotePage(
      controller: controller,
      index: index,
      backgroundColor: style.backgroundColor,
      child: Column(
        children: [
          if (index == 0)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SwipeLeftIndicator(),
            ),
          Expanded(child: QuoteCard(quote, style: style)),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuoteButton(
                loading: saveState.isLoading,
                onPressed: () => quoteSaveController.saveToggleQuote(),
                shape: const CircleBorder(),
                child: Icon(
                  quoteSaveController.isSaved
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                ),
              ),
              QuoteButton(
                loading: shareState.isLoading,
                onPressed: () => quoteShareController.share(quote),
                shape: const CircleBorder(),
                child: const Icon(Icons.share),
              ),
            ],
          )
        ],
      ),
    );
  }
}
