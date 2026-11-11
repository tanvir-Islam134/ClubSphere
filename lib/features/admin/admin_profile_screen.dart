import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';

class AdminProfileScreen extends ConsumerWidget {
  final String clubId;
  const AdminProfileScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = ref.watch(clubsProvider).firstWhere((c) => c.id == clubId);

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Admin Profile', showBack: false),
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
                        child: Icon(Icons.admin_panel_settings,
                            size: 48, color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      Text('Admin',
                          style: Theme.of(context).textTheme.displayMedium),
                      Text(club.name,
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
                    ref.read(currentAdminClubIdProvider.notifier).state = null;
                    context.go('/admin_login');
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
