import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/common_widgets/show_custom_sheet.dart';
import 'package:quote_app/src/features/saved_quotes/presentation/saved_quotes_screen.dart';
import 'package:quote_app/src/utils/page_controller_current_page.dart';

import 'pages/error_quote_page.dart';
import 'pages/loading_quote_page.dart';
import 'pages/quote_page.dart';
import 'quote_screen_controller.dart';

class QuoteScreen extends ConsumerStatefulWidget {
  const QuoteScreen({super.key});

  @override
  ConsumerState<QuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends ConsumerState<QuoteScreen> {
  final pageController = PageController();
  var swiping = false;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final controller = ref.read(quoteScreenControllerProvider);
      final page = pageController.currentPage;
      if (controller.shouldFetchMore(page)) controller.fetchMore();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(quoteScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IconButton(
          onPressed: () {
            showCustomSheet(
              context: context,
              child: const SavedQuotesScreen(),
            );
          },
          icon: const Icon(
            Icons.collections_bookmark_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: pageController,
        itemCount: controller.itemCount,
        itemBuilder: (context, index) {
          final quotes = controller.quotes;
          if (index == controller.itemCount - 1) {
            return controller.hasError
                ? ErrorQuotePage(
                    controller: pageController,
                    index: index,
                    loading: controller.isLoading,
                    onRefresh: controller.fetchMore,
                  )
                : LoadingQuotePage(controller: pageController, index: index);
          }
          final quote = quotes[index];
          return QuotePage(quote, controller: pageController, index: index);
        },
      ),
    );
  }
}
