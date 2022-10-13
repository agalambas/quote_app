import 'package:flutter/material.dart';

extension CurrentPage on PageController {
  int get currentPage {
    try {
      return page!.floor();
    } catch (_) {
      return 0;
    }
  }
}
