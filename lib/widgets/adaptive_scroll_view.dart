// import '../widgets/adaptive_scroll_view.dart';
// AdaptiveScrollView(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.stretch, children: [...]))

import 'package:flutter/material.dart';

import 'app_scrollbar.dart';

class AdaptiveScrollView extends StatelessWidget {
  const AdaptiveScrollView({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.showScrollbar = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final bool showScrollbar;

  Widget _scrollView(BoxConstraints constraints, ScrollController? controller) {
    return SingleChildScrollView(
      controller: controller,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Padding(padding: padding, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!showScrollbar) return _scrollView(constraints, controller);

        return AppScrollbar(
          controller: controller,
          builder: (context, sc) => _scrollView(constraints, sc),
        );
      },
    );
  }
}
