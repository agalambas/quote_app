import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/features/quotes/domain/styled_quote.dart';
import 'package:quote_app/src/features/quotes/presentation/pages/quote_page_controller.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_button.dart';
import 'package:quote_app/src/features/quotes/presentation/quote_card.dart';
import 'package:share_plus/share_plus.dart';

class QuotePage extends ConsumerWidget {
  final StyledQuote quote;
  final void Function(bool isSaved)? onSave;

  const QuotePage(this.quote, {super.key, this.onSave});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(quoteSaveControllerProvider(quote.id));
    return Column(
      children: [
        Expanded(child: QuoteCard(quote)),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuoteButton(
              onPressed: () {
                ref
                    .read(quoteSaveControllerProvider(quote.id).notifier)
                    .saveToggleQuote(quote.style.id);
                onSave?.call(!isSaved);
              },
              shape: const CircleBorder(),
              child: Icon(
                isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_outline_rounded,
              ),
            ),
            QuoteButton(
              onPressed: () => Share.share('${quote.quote} ~${quote.author}'),
              shape: const CircleBorder(),
              child: const Icon(Icons.share),
            ),
          ],
        )
      ],
    );
  }
}
