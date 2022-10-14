@Timeout(Duration(milliseconds: 500))
import 'package:flutter_test/flutter_test.dart';
import 'package:quote_app/src/features/saved_quotes/data/saved_quotes_repository.dart';
import 'package:quote_app/src/features/saved_quotes/domain/saved_quote.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final fakeSavedQuote = SavedQuote(quoteId: 0, styleId: 0);
  late SharedPreferences sharedPreferences;
  late SavedQuotesRepository savedQuotesRepository;
  Future<void> setUp({dynamic initialSavedQuotes}) async {
    SharedPreferences.setMockInitialValues(
        initialSavedQuotes != null ? {'saved-quotes': initialSavedQuotes} : {});
    sharedPreferences = await SharedPreferences.getInstance();
    savedQuotesRepository = SavedQuotesRepository(prefs: sharedPreferences);
  }

  group('savedQuotesRepository', () {
    group('getSavedQuote', () {
      test('getSavedQuote(quoteId) returns the quote', () async {
        // setup
        await setUp(initialSavedQuotes: [fakeSavedQuote.toString()]);
        // verify
        expect(
          savedQuotesRepository.getSavedQuote(fakeSavedQuote.quoteId),
          fakeSavedQuote,
        );
      });
      test('getSavedQuote(quoteId) returns null when prefs empty', () async {
        // setup
        await setUp(initialSavedQuotes: []);
        // verify
        expect(
          savedQuotesRepository.getSavedQuote(fakeSavedQuote.quoteId),
          null,
        );
      });
      test('getSavedQuote(quoteId) returns null list when prefs null',
          () async {
        // setup
        await setUp();
        // verify
        expect(
          savedQuotesRepository.getSavedQuote(fakeSavedQuote.quoteId),
          null,
        );
      });
      test('getSavedQuote(quoteId) returns null list when prefs are wrong',
          () async {
        // setup
        await setUp(initialSavedQuotes: 'wrong type');
        // verify
        expect(
          savedQuotesRepository.getSavedQuote(fakeSavedQuote.quoteId),
          null,
        );
      });
    });
    group('getSavedQuotes', () {
      test('getSavedQuotes() returns a list of saved quotes', () async {
        // setup
        final savedQuotes = [
          fakeSavedQuote,
          SavedQuote(quoteId: 1, styleId: 1),
          SavedQuote(quoteId: 2, styleId: 2),
        ];
        await setUp(
            initialSavedQuotes:
                savedQuotes.map((saved) => saved.toString()).toList());
        // verify

        expect(savedQuotesRepository.getSavedQuotes(), savedQuotes);
      });
      test('getSavedQuotes() returns empty list when prefs empty', () async {
        // setup
        await setUp(initialSavedQuotes: []);
        // verify
        expect(savedQuotesRepository.getSavedQuotes(), []);
      });
      test('getSavedQuotes() returns empty list when prefs null', () async {
        // setup
        await setUp();
        // verify
        expect(savedQuotesRepository.getSavedQuotes(), []);
      });
      test('getSavedQuotes() returns empty list when prefs are wrong',
          () async {
        // setup
        await setUp(initialSavedQuotes: 'wrong type');
        // verify
        expect(savedQuotesRepository.getSavedQuotes(), []);
      });
    });
    group('saveQuote', () {
      test('saveQuote() success', () async {
        // setup
        await setUp(initialSavedQuotes: []);
        // verify
        savedQuotesRepository.saveQuote(fakeSavedQuote);
        expect(savedQuotesRepository.getSavedQuotes(), [fakeSavedQuote]);
      });
      test('saveQuote() does not save quote if already saved', () async {
        // setup
        await setUp(initialSavedQuotes: [fakeSavedQuote.toString()]);
        // run
        savedQuotesRepository.saveQuote(fakeSavedQuote);
        // verify
        expect(savedQuotesRepository.getSavedQuotes(), [fakeSavedQuote]);
      });
    });
    group('removeQuote', () {
      test('removeQuote() success', () async {
        // setup
        await setUp(initialSavedQuotes: [fakeSavedQuote.toString()]);
        // run
        savedQuotesRepository.removeQuote(fakeSavedQuote.quoteId);
        // verify
        expect(savedQuotesRepository.getSavedQuotes(), []);
      });
      test('removeQuote() does not remove quote if not saved', () async {
        // setup
        await setUp(initialSavedQuotes: []);
        // run
        savedQuotesRepository.removeQuote(fakeSavedQuote.quoteId);
        // verify
        expect(savedQuotesRepository.getSavedQuotes(), []);
      });
    });
  });
}
