import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/saved_quotes/data/saved_quotes_repository.dart';

final savedQuotesFutureProvider =
    FutureProvider.autoDispose<List<StyledQuote>>((ref) {
  final savedQuotesRepository = ref.read(savedQuotesRepositoryProvider);
  final quotesRepository = ref.read(quotesRepositoryProvider);
  final savedQuotes = savedQuotesRepository.getSavedQuotes();
  return Future.wait(savedQuotes.map(
    (saved) async {
      final quote = await quotesRepository.fetchQuote(quoteId: saved.quoteId);
      return StyledQuote.fromQuote(quote, saved.styleId);
    },
  ));
});
