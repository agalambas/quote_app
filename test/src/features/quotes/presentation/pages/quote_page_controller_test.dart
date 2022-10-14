import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/quote_page_controller.dart';
import 'package:quote_app/src/features/saved_quotes/domain/saved_quote.dart';

import '../../../../../mocks.dart';

void main() {
  final fakeSavedQuote = SavedQuote(quoteId: 0, styleId: 0);
  late MockSavedQuotesRepository savedQuotesRepository;
  late QuoteSaveController controller;
  group('QuotePageController', () {
    test('initial state is true then toggle', () async {
      // setup
      savedQuotesRepository = MockSavedQuotesRepository();
      when(() => savedQuotesRepository.getSavedQuote(fakeSavedQuote.quoteId))
          .thenReturn(fakeSavedQuote);
      controller = QuoteSaveController(
        quoteId: fakeSavedQuote.quoteId,
        savedQuotesRepository: savedQuotesRepository,
      );
      // verify
      expect(controller.debugState, true);
      // setup
      when(() => savedQuotesRepository.removeQuote(fakeSavedQuote.quoteId))
          .thenReturn(null);
      // run
      controller.saveToggleQuote(fakeSavedQuote.quoteId);
      // verify
      expect(controller.debugState, false);
    });
    test('initial state is false then toggle', () async {
      // setup
      savedQuotesRepository = MockSavedQuotesRepository();
      when(() => savedQuotesRepository.getSavedQuote(fakeSavedQuote.quoteId))
          .thenReturn(null);
      controller = QuoteSaveController(
        quoteId: fakeSavedQuote.quoteId,
        savedQuotesRepository: savedQuotesRepository,
      );
      // verify
      expect(controller.debugState, false);
      // setup
      when(() => savedQuotesRepository.saveQuote(fakeSavedQuote))
          .thenReturn(null);
      // run
      controller.saveToggleQuote(fakeSavedQuote.quoteId);
      // verify
      expect(controller.debugState, true);
    });
  });
}
