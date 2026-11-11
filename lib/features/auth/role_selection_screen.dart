import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/app_state.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome to ClubSphere',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 48),
              _buildRoleCard(
                context,
                title: 'Student',
                description: 'Join clubs and manage your applications',
                icon: Icons.school,
                onTap: () {
                  ref.read(roleProvider.notifier).setRole(AppRole.student);
                  context.push('/student_login');
                },
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                context,
                title: 'Club Admin',
                description: 'Manage your club, members, and events',
                icon: Icons.admin_panel_settings,
                onTap: () {
                  ref.read(roleProvider.notifier).setRole(AppRole.admin);
                  context.push('/admin_login');
                },
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                context,
                title: 'HR Office',
                description: 'Oversee clubs and approve admins',
                icon: Icons.business,
                onTap: () {
                  ref.read(roleProvider.notifier).setRole(AppRole.hr);
                  context.push('/hr_login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardSurface,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
