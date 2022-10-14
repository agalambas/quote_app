import 'package:flutter/material.dart';
import 'package:quote_app/src/utils/page_controller_current_page.dart';

class AnimatedFeedPage extends StatefulWidget {
  final PageController controller;
  final int index;
  final Color? backgroundColor;
  final Widget child;

  const AnimatedFeedPage({
    required this.controller,
    required this.index,
    required this.child,
    this.backgroundColor,
    super.key,
  });

  @override
  State<AnimatedFeedPage> createState() => _AnimatedQuotePageState();
}

class _AnimatedQuotePageState extends State<AnimatedFeedPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(refresh);
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(refresh);
    super.dispose();
  }

  bool get isCurrentPage => widget.controller.currentPage == widget.index;

  Offset get offset {
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = widget.controller.offset % screenWidth;
    final dx = isCurrentPage ? offset : offset - screenWidth;
    return Offset(dx, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        color: widget.backgroundColor,
        padding:
            EdgeInsets.fromLTRB(48, MediaQuery.of(context).padding.top, 48, 48),
        child: Transform.translate(
          offset: offset,
          child: widget.child,
        ),
      ),
    );
  }
}
