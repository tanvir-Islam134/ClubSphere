import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../widgets/app_header.dart';

class HrRegisterScreen extends ConsumerWidget {
  const HrRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(
              title: 'HR Registration', subtitle: 'Create HR account'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/baust_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Register HR Officer',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Administrative credentials for university authority',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const AppTextField(
                      label: 'Full Name',
                      hint: 'Jane Smith',
                      icon: Icons.person_outline),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'HR Email',
                      hint: 'hr@baust.edu.bd',
                      icon: Icons.email_outlined),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                              labelText: 'HR Section',
                              border: OutlineInputBorder()),
                          items: [
                            'Student Affairs',
                            'Club Management',
                            'General HR'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child:
                            AppTextField(label: 'Employee ID', hint: 'EMP001'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Designation',
                      hint: 'e.g. HR Officer',
                      icon: Icons.badge_outlined),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Password',
                      hint: 'Create password',
                      icon: Icons.lock_outline,
                      obscureText: true),
                  const SizedBox(height: 24),
                  Card(
                    color: AppColors.warningLight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: AppColors.warning),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Notice: Your account must be verified by the Registrar before you can access the system.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.warning),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Register',
                    onPressed: () => context.pop(),
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
