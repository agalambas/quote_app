import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';

final quoteScreenControllerProvider =
    ChangeNotifierProvider<QuoteScreenController>((ref) {
  final repository = ref.watch(quotesRepositoryProvider);
  return QuoteScreenController(repository);
});

class QuoteScreenController extends ChangeNotifier {
  final QuotesRepository repository;
  final controller = PageController();
  final int _pageSize = 10;

  QuoteScreenController(this.repository) {
    fetchMore();
  }

  bool isLoading = false;
  bool hasError = false;
  var quotes = <Quote>[];

  int get itemCount => quotes.length + (showExtraPage ? 1 : 0);
  bool get showExtraPage => isLoading || hasError;

  bool shouldFetchMore(int index) =>
      !isLoading && !hasError && index >= quotes.length - _pageSize / 2;

  Future<void> fetchMore() async {
    isLoading = true;
    notifyListeners();
    try {
      final newQuotes = [];
      for (var i = 0; i < _pageSize; i++) {
        final quote = await repository.fetchRandomQuote(
          lastQuote: newQuotes.lastOrNull ?? quotes.lastOrNull,
        );
        newQuotes.add(quote);
      }
      quotes.addAll([...newQuotes]);
      isLoading = false;
      hasError = false;
    } catch (_) {
      isLoading = false;
      hasError = true;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
