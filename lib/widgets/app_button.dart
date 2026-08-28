// import '../widgets/app_button.dart';
// AppButton(label: 'Login', onPressed: _handleLogin, variant: AppButtonVariant.primary, icon: LucideIcons.logIn)

import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, text, danger }

enum AppButtonSize { large, small }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.expanded = true,
    this.size = AppButtonSize.large,
    this.pill = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool loading;
  final bool expanded;
  final AppButtonSize size;
  final bool pill;

  _ButtonPalette get _palette {
    switch (variant) {
      case AppButtonVariant.primary:
        return _ButtonPalette(Colors.green.shade800, Colors.white);
      case AppButtonVariant.secondary:
        return _ButtonPalette(Colors.green.shade100, Colors.green.shade900);
      case AppButtonVariant.outline:
        return _ButtonPalette(Colors.green.shade600, Colors.green.shade700);
      case AppButtonVariant.text:
        return _ButtonPalette(Colors.transparent, Colors.green.shade700);
      case AppButtonVariant.danger:
        return _ButtonPalette(Colors.red.shade600, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = _palette;
    final isLarge = size == AppButtonSize.large;
    final padding = EdgeInsets.symmetric(
      vertical: isLarge ? 16 : 11,
      horizontal: isLarge ? 20 : 16,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(pill ? 999 : 14),
    );

    final content = loading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation(palette.foreground),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: isLarge ? 16 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );

    final effectiveOnPressed = loading ? null : onPressed;

    Widget button;
    switch (variant) {
      case AppButtonVariant.outline:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: palette.foreground,
            side: BorderSide(color: palette.background, width: 1.4),
            padding: padding,
            shape: shape,
          ),
          child: content,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: palette.foreground,
            padding: padding,
            shape: shape,
          ),
          child: content,
        );
        break;
      case AppButtonVariant.primary:
      case AppButtonVariant.secondary:
      case AppButtonVariant.danger:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: palette.background,
            foregroundColor: palette.foreground,
            disabledBackgroundColor: palette.background.withValues(
              alpha: 0.5,
            ),
            elevation: 0,
            padding: padding,
            shape: shape,
          ),
          child: content,
        );
        break;
    }

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class _ButtonPalette {
  const _ButtonPalette(this.background, this.foreground);

  final Color background;
  final Color foreground;
}
