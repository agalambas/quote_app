import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_app/src/common_widgets/show_custom_sheet.dart';
import 'package:quote_app/src/features/saved_quotes/presentation/saved_quotes_screen.dart';
import 'package:quote_app/src/utils/page_controller_current_page.dart';

import 'pages/error_feed_page.dart';
import 'pages/loading_feed_page.dart';
import 'pages/quote_feed_page.dart';
import 'quote_feed_controller.dart';

class QuoteFeedScreen extends ConsumerStatefulWidget {
  const QuoteFeedScreen({super.key});

  @override
  ConsumerState<QuoteFeedScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends ConsumerState<QuoteFeedScreen> {
  final pageController = PageController();
  var swiping = false;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final controller = ref.read(quoteFeedControllerProvider.notifier);
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
    final state = ref.watch(quoteFeedControllerProvider);
    final controller = ref.watch(quoteFeedControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IconButton(
          onPressed: () => showCustomSheet(
            context: context,
            child: const SavedQuotesScreen(),
          ),
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
            return state.hasError
                ? ErrorFeedPage(
                    controller: pageController,
                    index: index,
                    loading: state.isLoading,
                    onRefresh: controller.fetchMore,
                  )
                : LoadingFeedPage(controller: pageController, index: index);
          }
          final quote = quotes[index];
          return QuoteFeedPage(
            quote,
            controller: pageController,
            index: index,
          );
        },
      ),
    );
  }
}
