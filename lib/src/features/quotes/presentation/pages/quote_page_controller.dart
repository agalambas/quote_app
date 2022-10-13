import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/saved_quotes/data/saved_quotes_repository.dart';
import 'package:share_plus/share_plus.dart';

final quoteSaveControllerProvider = StateNotifierProvider.family
    .autoDispose<QuoteSaveController, AsyncValue, int>(
  (ref, quoteId) => QuoteSaveController(
    quoteId: quoteId,
    savedQuotesRepository: ref.watch(savedQuotesRepositoryProvider),
  ),
);

class QuoteSaveController extends StateNotifier<AsyncValue> {
  final int quoteId;
  final SavedQuotesRepository savedQuotesRepository;
  QuoteSaveController({
    required this.quoteId,
    required this.savedQuotesRepository,
  }) : super(const AsyncValue.data(null));

  bool get isSaved =>
      savedQuotesRepository.getSavedQuoteIds().contains(quoteId);

  Future<void> saveToggleQuote() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => savedQuotesRepository.saveToggleQuote(quoteId),
    );
  }
}

final quoteShareControllerProvider = StateNotifierProvider.family
    .autoDispose<QuoteShareController, AsyncValue, int>(
  (ref, quoteId) => QuoteShareController(quoteId: quoteId),
);

class QuoteShareController extends StateNotifier<AsyncValue> {
  final int quoteId;
  QuoteShareController({
    required this.quoteId,
  }) : super(const AsyncValue.data(null));

  Future<void> share(Quote quote) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => Share.share('${quote.quote} ~${quote.author}'),
    );
  }
}
