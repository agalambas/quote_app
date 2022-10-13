import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/saved_quotes/data/saved_quotes_repository.dart';

final savedQuotesFutureProvider =
    FutureProvider.autoDispose<List<Quote>>((ref) {
  final savedQuotesRepository = ref.read(savedQuotesRepositoryProvider);
  final quotesRepository = ref.read(quotesRepositoryProvider);
  final quoteIds = savedQuotesRepository.getSavedQuoteIds();
  return Future.wait(quoteIds.map(
    (id) => quotesRepository.fetchQuote(quoteId: id),
  ));
});
