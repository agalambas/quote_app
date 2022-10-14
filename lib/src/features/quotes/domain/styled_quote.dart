import 'quote.dart';
import 'quote_style.dart';

class StyledQuote extends Quote {
  final QuoteStyle style;

  StyledQuote({
    required super.id,
    required super.quote,
    required super.author,
    required int styleId,
  }) : style = QuoteStyle.fromIndex(styleId);

  StyledQuote.fromQuote(Quote quote, int styleId)
      : style = QuoteStyle.fromIndex(styleId),
        super(
          id: quote.id,
          quote: quote.quote,
          author: quote.author,
        );
}
