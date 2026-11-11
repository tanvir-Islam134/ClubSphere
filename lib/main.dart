import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'widgets/desktop_frame.dart';

void main() {
  runApp(const ProviderScope(child: ClubSphereApp()));
}

class ClubSphereApp extends StatelessWidget {
  const ClubSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ClubSphere',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return DesktopFrame(child: child ?? const SizedBox());
      },
    );
  }
}
