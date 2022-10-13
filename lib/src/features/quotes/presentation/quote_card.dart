import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final QuoteStyle? style;
  const QuoteCard(this.quote, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: AutoSizeText(
            quote.quote,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontFamily: style?.fontFamily,
                  color: style?.foregroundColor,
                ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '- ${quote.author.toUpperCase()}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
