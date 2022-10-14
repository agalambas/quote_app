@Timeout(Duration(milliseconds: 500))
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';

void main() {
  const fakeQuoteJson = {'id': 1, 'author': 'Anon', 'quote': 'Lorem ipsum....'};
  const fakeQuote2Json = {'id': 2, 'author': 'Bert', 'quote': 'Quote'};
  final fakeQuote = Quote.fromJson(fakeQuoteJson);
  late MockClient httpClient;
  late QuotesRepository quotesRepository;

  group('quotesRepository', () {
    group('fetchRandomQuote', () {
      test('fetchRandomQuote() returns a quote', () async {
        // setup
        httpClient = MockClient(
          (request) async => Response(jsonEncode(fakeQuoteJson), 200),
        );
        quotesRepository = QuotesRepository(client: httpClient);
        // verify
        expect(
          await quotesRepository.fetchRandomQuote(),
          fakeQuote,
        );
      });
      test('fetchRandomQuote(quote) does not return the same quote', () async {
        // setup
        bool firstTime = true;
        httpClient = MockClient(
          (request) async {
            if (firstTime) {
              firstTime = false;
              return Response(jsonEncode(fakeQuoteJson), 200);
            } else {
              return Response(jsonEncode(fakeQuote2Json), 200);
            }
          },
        );
        quotesRepository = QuotesRepository(client: httpClient);
        // verify
        expect(
          await quotesRepository.fetchRandomQuote(lastQuote: fakeQuote),
          isNot(fakeQuote),
        );
      });
      test('fetchRandomQuote() throws exception', () {
        // setup
        httpClient = MockClient(
          (request) async => Response(jsonEncode({}), 404),
        );
        quotesRepository = QuotesRepository(client: httpClient);
        // verify
        expect(
          () => quotesRepository.fetchRandomQuote(),
          throwsException,
        );
      });
    });
    group('fetchQuote', () {
      test('fetchQuote(id) returns the correct quote', () async {
        // setup
        httpClient = MockClient(
          (request) async => Response(jsonEncode(fakeQuoteJson), 200),
        );
        quotesRepository = QuotesRepository(client: httpClient);
        // verify
        expect(
          await quotesRepository.fetchQuote(quoteId: fakeQuote.id),
          fakeQuote,
        );
      });
      test('fetchQuote() throws exception', () {
        // setup
        httpClient = MockClient(
          (request) async => Response(jsonEncode({}), 404),
        );
        quotesRepository = QuotesRepository(client: httpClient);
        // verify
        expect(
          () => quotesRepository.fetchQuote(quoteId: fakeQuote.id),
          throwsException,
        );
      });
    });
  });
}
