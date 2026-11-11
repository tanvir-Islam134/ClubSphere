import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';

class StudentProfileScreen extends ConsumerWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(currentStudentProvider);

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Profile', showBack: false),
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
                        child: Icon(Icons.person,
                            size: 48, color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      Text(student.name,
                          style: Theme.of(context).textTheme.displayMedium),
                      Text(student.studentId,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/baust_logo.png',
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'BAUST Verified Student',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildOptionTile(Icons.groups, 'My Clubs',
                    () => context.go('/student/clubs')),
                _buildOptionTile(Icons.history, 'Application History',
                    () => context.go('/student/applications')),
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
                    ref.read(roleProvider.notifier).setRole(AppRole.none);
                    context.go('/student_login');
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
