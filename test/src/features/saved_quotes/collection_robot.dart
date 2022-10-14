import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CollectionsRobot {
  final WidgetTester tester;
  CollectionsRobot(this.tester);

  Future<void> tapDismissibleBarrier() async {
    await tester.tapAt(const Offset(0.5, 0));
    await tester.pumpAndSettle(); //!
  }

  Future<void> tapQuote(int quoteId) async {
    final quote = find.byKey(Key('saved-$quoteId'));
    await tester.tap(quote);
    await tester.pump();
  }

  void expectHandlebarFound() {
    final handle = find.byIcon(Icons.horizontal_rule_rounded);
    expect(handle, findsOneWidget);
  }

  void expectHandlebarNotFound() {
    final handle = find.byIcon(Icons.horizontal_rule_rounded);
    expect(handle, findsNothing);
  }

  Future<void> expectQuoteFound(int quoteId) async {
    final quote = find.byKey(Key('saved-$quoteId'));
    expect(quote, findsOneWidget);
  }
}
