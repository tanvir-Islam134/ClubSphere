import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../widgets/app_header.dart';

class HrLoginScreen extends ConsumerWidget {
  const HrLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(
              title: 'HR Login', subtitle: 'Manage university clubs'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppTextField(
                      label: 'HR Email',
                      hint: 'hr@baust.edu.bd',
                      icon: Icons.email_outlined),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Password',
                      hint: 'Enter password',
                      icon: Icons.lock_outline,
                      obscureText: true),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: '4-digit Security PIN',
                      hint: '****',
                      icon: Icons.pin_outlined,
                      obscureText: true),
                  const SizedBox(height: 24),
                  Card(
                    color: AppColors.primaryLight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.support_agent,
                              color: AppColors.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'For IT support or PIN reset, contact the central IT helpdesk.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Login',
                    onPressed: () => context.go('/hr/dashboard'),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New HR Staff? '),
                      TextButton(
                        onPressed: () => context.push('/hr_register'),
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
