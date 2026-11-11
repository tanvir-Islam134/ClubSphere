import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';

class HrProfileScreen extends ConsumerWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'HR Profile', showBack: false),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(Icons.business,
                            size: 48, color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      Text('HR Officer',
                          style: Theme.of(context).textTheme.displayMedium),
                      Text('Student Affairs',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildOptionTile(Icons.edit, 'Edit Profile', () {}),
                _buildOptionTile(Icons.lock, 'Change Password', () {}),
                _buildOptionTile(Icons.notifications, 'Notifications', () {}),
                _buildOptionTile(Icons.help, 'Help & Support', () {}),
                const SizedBox(height: 32),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.error),
                  title: const Text('Logout',
                      style: TextStyle(
                          color: AppColors.error, fontWeight: FontWeight.bold)),
                  onTap: () {
                    ref.read(roleProvider.notifier).state = AppRole.none;
                    context.go('/hr_login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
