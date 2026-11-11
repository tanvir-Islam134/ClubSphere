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
