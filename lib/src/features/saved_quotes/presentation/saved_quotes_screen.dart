import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';
import 'package:quote_app/src/features/saved_quotes/presentation/saved_quotes_sheet_controller.dart';

class SavedQuotesScreen extends ConsumerWidget {
  const SavedQuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedQuotesValue = ref.watch(savedQuotesFutureProvider);
    final placeholderStyle = Theme.of(context).textTheme.bodyMedium;
    return savedQuotesValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, __) => Center(
        child: Text(
          'Something went wrong, please try again later!',
          textAlign: TextAlign.center,
          style: placeholderStyle,
        ),
      ),
      data: (savedQuotes) {
        if (savedQuotes.isEmpty) {
          return Center(
            child: Text(
              'Your favorite quotes will appear here',
              textAlign: TextAlign.center,
              style: placeholderStyle,
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: savedQuotes.length,
          itemBuilder: (context, index) {
            final quote = savedQuotes[index];
            final style = quote.style;
            return InkWell(
              onTap: () async {
                await Navigator.of(context)
                    .pushNamed('/quote', arguments: quote);
                ref.refresh(savedQuotesFutureProvider);
              },
              child: Container(
                key: Key('saved-${quote.id}'),
                color: style.backgroundColor,
                padding: const EdgeInsets.all(12),
                child: QuoteCard(quote),
              ),
            );
          },
        );
      },
    );
  }
}
