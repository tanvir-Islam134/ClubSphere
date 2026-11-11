import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBack;
  final Widget? trailing;
  final bool showLogo;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = true,
    this.trailing,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                )
              else
                const SizedBox(width: 48),
              if (trailing != null) trailing! else const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: showBack ? 8.0 : 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'BAUST CLUBSPHERE',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primaryLight,
                                  ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (showLogo && trailing == null)
                  Container(
                    width: 54,
                    height: 54,
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/baust_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
