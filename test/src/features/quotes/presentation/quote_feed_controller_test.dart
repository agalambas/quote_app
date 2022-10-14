import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_feed_controller.dart';

import '../../../../mocks.dart';

void main() {
  const fakeQuoteJson = {'id': 1, 'author': 'Anon', 'quote': 'Lorem ipsum....'};
  final fakeQuote = Quote.fromJson(fakeQuoteJson);
  late MockQuotesRepository quotesRepository;
  late QuoteFeedController controller;
  setUp(() {
    quotesRepository = MockQuotesRepository();
    when(() => quotesRepository.fetchRandomQuote(lastQuote: null))
        .thenAnswer((_) async => fakeQuote);
    when(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote))
        .thenAnswer((_) async => fakeQuote);
    controller = QuoteFeedController(repository: quotesRepository);
  });
  group('QuoteFeedController', () {
    test('fetchMore() success', () async {
      // verify
      expect(controller.showExtraPage, true);
      expect(controller.itemCount, 1);
      await expectLater(controller.stream, emits(PageState.data));
      expect(controller.showExtraPage, false);
      expect(controller.itemCount, controller.pageSize);
    });
    test('fetchMore() fails', () async {
      // setup
      await controller.stream.firstWhere((state) => state == PageState.data);
      when(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote))
          .thenThrow(Exception());
      // verify
      expectLater(
        controller.stream,
        emitsInOrder([PageState.loading, PageState.error]),
      );
      // run
      await controller.fetchMore();
      // verify
      expect(controller.showExtraPage, true);
      expect(controller.itemCount, controller.pageSize + 1);
      verify(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote))
          .called(controller.pageSize);
    });
    test('fetchMore() success after failure', () async {
      // setup
      await controller.stream.firstWhere((state) => state == PageState.data);
      when(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote))
          .thenThrow(Exception());
      // verify
      expectLater(
        controller.stream,
        emitsInOrder([
          PageState.loading,
          PageState.error,
          PageState.errorLoading,
          PageState.data,
        ]),
      );
      // run
      await controller.fetchMore();
      when(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote))
          .thenAnswer((_) async => fakeQuote);
      await controller.fetchMore();
      // verify
      expect(controller.showExtraPage, false);
      expect(controller.itemCount, controller.pageSize * 2);
      verify(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote))
          .called(controller.pageSize * 2);
    });
  });
}
