import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DesktopFrame extends StatelessWidget {
  final Widget child;
  const DesktopFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // True on Android and iOS devices
        final bool isNativeMobile = defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS;
        
        // Also adapt if window width is narrow like a phone
        final bool isMobileWidth = constraints.maxWidth < 650;

        // Native full-screen edge-to-edge experience for Android & mobile screens
        if (isNativeMobile || isMobileWidth) {
          return child;
        }

        // On Windows and desktop wide screens, provide an adaptive, centered frame
        // that scales height dynamically with the window so it never overflows.
        final double maxHeight = constraints.maxHeight;
        final double frameHeight = maxHeight > 860
            ? 820
            : (maxHeight - 32).clamp(480.0, 820.0);

        return Scaffold(
          backgroundColor: const Color(0xFFE2E8F0),
          body: Center(
            child: Container(
              width: 420,
              height: frameHeight,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.18),
                    blurRadius: 32,
                    spreadRadius: 2,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
