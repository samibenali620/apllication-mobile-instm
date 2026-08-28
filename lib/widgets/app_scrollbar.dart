// import '../widgets/app_scrollbar.dart';
// AppScrollbar(builder: (context, controller) => ListView(controller: controller, children: [...]))

import 'package:flutter/material.dart';

class AppScrollbar extends StatefulWidget {
  const AppScrollbar({
    super.key,
    required this.builder,
    this.controller,
    this.alwaysVisible = false,
    this.color,
  });

  final Widget Function(BuildContext context, ScrollController controller)
  builder;
  final ScrollController? controller;
  final bool alwaysVisible;
  final Color? color;

  @override
  State<AppScrollbar> createState() => _AppScrollbarState();
}

class _AppScrollbarState extends State<AppScrollbar> {
  ScrollController? _ownedController;

  ScrollController get _controller =>
      widget.controller ?? (_ownedController ??= ScrollController());

  @override
  void dispose() {
    _ownedController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thumbColor = widget.color ?? Colors.green.shade700;
    return RawScrollbar(
      controller: _controller,
      thumbVisibility: widget.alwaysVisible,
      trackVisibility: widget.alwaysVisible,
      thickness: 5,
      radius: const Radius.circular(12),
      minThumbLength: 48,
      thumbColor: thumbColor.withValues(alpha: 0.55),
      trackColor: Colors.black.withValues(alpha: 0.04),
      child: widget.builder(context, _controller),
    );
  }
}
