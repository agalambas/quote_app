import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/saved_quotes/data/saved_quotes_repository.dart';
import 'package:quote_app/src/features/saved_quotes/domain/saved_quote.dart';

final quoteSaveControllerProvider =
    StateNotifierProvider.family.autoDispose<QuoteSaveController, bool, int>(
  (ref, quoteId) => QuoteSaveController(
    quoteId: quoteId,
    savedQuotesRepository: ref.watch(savedQuotesRepositoryProvider),
  ),
);

class QuoteSaveController extends StateNotifier<bool> {
  final int quoteId;
  final SavedQuotesRepository savedQuotesRepository;

  QuoteSaveController({
    required this.quoteId,
    required this.savedQuotesRepository,
  })  : styleId = savedQuotesRepository.getSavedQuote(quoteId)?.styleId,
        super(savedQuotesRepository.getSavedQuote(quoteId) != null);

  int? styleId;

  void saveToggleQuote(int quoteStyleId) async {
    state
        ? savedQuotesRepository.removeQuote(quoteId)
        : savedQuotesRepository
            .saveQuote(SavedQuote(quoteId: quoteId, styleId: quoteStyleId));
    state = !state;
    if (state) styleId = quoteStyleId;
  }
}
