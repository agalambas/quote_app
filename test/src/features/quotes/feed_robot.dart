import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quote_app/src/features/quotes/data/quotes_repository.dart';
import 'package:quote_app/src/features/quotes/domain/quote.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_feed_screen.dart';
import 'package:quote_app/src/features/saved_quotes/presentation/quote_screen.dart';
import 'package:quote_app/src/utils/instance_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../mocks.dart';

const fakeQuote0 = Quote(id: 0, quote: 'quote', author: 'author');
const fakeQuote1 = Quote(id: 0, quote: 'quote', author: 'author');

class FeedRobot {
  final WidgetTester tester;
  FeedRobot(this.tester);

  Future<void> pumpFeedScreen({
    Map<String, Object> initialPrefs = const {},
  }) async {
    final quotesRepository = MockQuotesRepository();
    when(() => quotesRepository.fetchRandomQuote())
        .thenAnswer((_) => Future.value(fakeQuote0));
    when(() => quotesRepository.fetchRandomQuote(lastQuote: fakeQuote0))
        .thenAnswer((_) => Future.value(fakeQuote1));
    when(() => quotesRepository.fetchQuote(quoteId: 0))
        .thenAnswer((_) => Future.value(fakeQuote0));

    final container = ProviderContainer(overrides: [
      quotesRepositoryProvider.overrideWithValue(quotesRepository),
    ]);
    SharedPreferences.setMockInitialValues(initialPrefs);
    await container.read(sharedPreferencesFutureProvider.future);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const QuoteFeedScreen(),
          },
          onGenerateRoute: (settings) {
            final quote = settings.arguments as StyledQuote;
            return MaterialPageRoute(
              builder: (context) => QuoteScreen(quote),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle(); //!
  }

  Future<void> tapCollectionsButton() async {
    final collections = find.byIcon(Icons.collections_bookmark_rounded);
    expect(collections, findsOneWidget);
    await tester.tap(collections);
    await tester.pump();
    await tester.pumpAndSettle(); //!
  }

  Future<void> tapSaveButton() async {
    final save = find.byIcon(Icons.bookmark_outline_rounded);
    expect(save, findsOneWidget);
    await tester.tap(save);
    await tester.pump();
  }

  Future<void> tapUnsaveButton() async {
    final unsave = find.byIcon(Icons.bookmark_rounded);
    expect(unsave, findsOneWidget);
    await tester.tap(unsave);
    await tester.pump();
  }

  Future<void> scrollLeft() async {
    await tester.dragFrom(const Offset(1, 0.5), const Offset(0, 0.5));
    await tester.pump();
  }

  void expectSavedButtonFound() {
    final saved = find.byIcon(Icons.bookmark_rounded);
    expect(saved, findsOneWidget);
  }

  void expectFeedQuoteFound(int quoteId) {
    final quote = find.byKey(Key('feedQuote-$quoteId'));
    expect(quote, findsOneWidget);
  }

  void expectQuoteFound(int quoteId) {
    final quote = find.byKey(Key('quote-$quoteId'));
    expect(quote, findsOneWidget);
  }

  void expectQuoteNotFound(int quoteId) {
    final quote = find.byKey(Key('quote-$quoteId'));
    expect(quote, findsNothing);
  }
}
