import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_page.dart';

class QuoteScreen extends StatelessWidget {
  final StyledQuote quote;
  QuoteScreen(this.quote) : super(key: Key('quote-${quote.id}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const CloseButton(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: quote.style.backgroundColor,
      body: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              48, MediaQuery.of(context).padding.top, 48, 48),
          child: QuotePage(quote, onSave: (_) => Navigator.of(context).pop()),
        );
      }),
    );
  }
}
