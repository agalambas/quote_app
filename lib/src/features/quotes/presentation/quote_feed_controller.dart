import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';

final quoteFeedControllerProvider =
    StateNotifierProvider<QuoteFeedController, PageState>((ref) {
  final repository = ref.watch(quotesRepositoryProvider);
  return QuoteFeedController(repository: repository);
});

enum PageState {
  data,
  loading,
  error,
  errorLoading;

  bool get hasError => this == error || this == errorLoading;
  bool get isLoading => this == loading || this == errorLoading;
}

//! switch form fetching 10 at a time to fetch i+10 at every i build
//! remove PageState and always present an extra loading page (or error if so)
class QuoteFeedController extends StateNotifier<PageState> {
  final QuotesRepository repository;
  final controller = PageController();
  final int pageSize = 10;

  QuoteFeedController({required this.repository}) : super(PageState.loading) {
    fetchMore();
  }

  var quotes = <Quote>[];

  int get itemCount => quotes.length + (showExtraPage ? 1 : 0);
  bool get showExtraPage => state != PageState.data;

  bool shouldFetchMore(int index) =>
      state == PageState.data && index >= quotes.length - pageSize / 2;

  Future<void> fetchMore() async {
    state = state.hasError ? PageState.errorLoading : PageState.loading;
    try {
      final newQuotes = [];
      for (var i = 0; i < pageSize; i++) {
        final quote = await repository.fetchRandomQuote(
          lastQuote: newQuotes.lastOrNull ?? quotes.lastOrNull,
        );
        newQuotes.add(quote);
      }
      quotes.addAll([...newQuotes]);
      state = PageState.data;
    } catch (_) {
      state = PageState.error;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
