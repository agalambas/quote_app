import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quote_app/src/common_widgets/swipe_left_indicator.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/animated_feed_page.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_page.dart';

class QuoteFeedPage extends StatelessWidget {
  final StyledQuote quote;
  final PageController controller;
  final int index;

  QuoteFeedPage(
    Quote quote, {
    required this.controller,
    required this.index,
    super.key,
  }) : quote = StyledQuote.fromQuote(quote, index);

  @override
  Widget build(BuildContext context) {
    final style = QuoteStyle.fromIndex(index);
    return AnimatedFeedPage(
      controller: controller,
      index: index,
      backgroundColor: style.backgroundColor,
      child: Column(
        children: [
          //! make a const
          if (index == 0 && !Platform.environment.containsKey('FLUTTER_TEST'))
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SwipeLeftIndicator(),
            ),
          Expanded(child: QuotePage(quote, key: Key('feedQuote-${quote.id}'))),
        ],
      ),
    );
  }
}
