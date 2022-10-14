import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quote_app/src/features/saved_quotes/domain/saved_quote.dart';

import '../../saved_quotes/collection_robot.dart';
import '../feed_robot.dart';

void main() {
  Future<void> tapClose(WidgetTester tester) async {
    final close = find.byIcon(Icons.close);
    await tester.tap(close);
    await tester.pump();
  }

  testWidgets('Scroll to next quote', (tester) async {
    final fr = FeedRobot(tester);
    await fr.pumpFeedScreen();
    fr.expectFeedQuoteFound(fakeQuote0.id);
    await fr.scrollLeft();
    fr.expectFeedQuoteFound(fakeQuote1.id);
  });
  testWidgets('Open collections sheet', (tester) async {
    final fr = FeedRobot(tester);
    await fr.pumpFeedScreen();
    await fr.tapCollectionsButton();
    final cr = CollectionsRobot(tester);
    cr.expectHandlebarFound();
    await cr.tapDismissibleBarrier();
    cr.expectHandlebarNotFound();
  });
  testWidgets('open a saved quote', (tester) async {
    final fr = FeedRobot(tester);
    await fr.pumpFeedScreen(initialPrefs: {
      'saved-quotes': [
        SavedQuote(quoteId: fakeQuote0.id, styleId: 0).toString(),
      ],
    });
    await fr.tapCollectionsButton();
    final cr = CollectionsRobot(tester);
    cr.expectQuoteFound(fakeQuote0.id);
    await cr.tapQuote(fakeQuote0.id);
    fr.expectQuoteFound(fakeQuote0.id);
    await tapClose(tester);
    fr.expectQuoteNotFound(fakeQuote0.id);
  });

  testWidgets('Save quote', (tester) async {
    final fr = FeedRobot(tester);
    await fr.pumpFeedScreen();
    fr.expectFeedQuoteFound(fakeQuote0.id);
    await fr.tapSaveButton();
    fr.expectSavedButtonFound();
    await fr.tapCollectionsButton();
    final cr = CollectionsRobot(tester);
    await cr.expectQuoteFound(fakeQuote0.id);
  });
}
