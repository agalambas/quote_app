import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/domain/quote_style.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';
import 'package:quote_app/src/features/saved_quotes/presentation/saved_quotes_sheet_controller.dart';

class SavedQuotesScreen extends ConsumerWidget {
  const SavedQuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedQuotesValue = ref.watch(savedQuotesFutureProvider);
    return savedQuotesValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, __) => const Center(
        child: Text(
          'Something went wrong, please try again later!',
          textAlign: TextAlign.center,
        ),
      ),
      data: (savedQuotes) => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: savedQuotes.length,
        itemBuilder: (context, index) {
          final style = QuoteStyle.fromPosition(index);
          return Container(
            padding: const EdgeInsets.all(8),
            color: style.backgroundColor,
            child: QuoteCard(
              savedQuotes[index],
              style: style,
            ),
          );
        },
      ),
    );
  }
}
