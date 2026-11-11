import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../widgets/app_header.dart';
import '../../data/models/models.dart';

class AdminRegisterScreen extends ConsumerStatefulWidget {
  const AdminRegisterScreen({super.key});

  @override
  ConsumerState<AdminRegisterScreen> createState() =>
      _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends ConsumerState<AdminRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final clubs = ref.watch(clubsProvider);

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(
              title: 'Request Admin Access',
              subtitle: 'Submit details for HR approval'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<Club>(
                    decoration: const InputDecoration(
                        labelText: 'Select Club', border: OutlineInputBorder()),
                    items: clubs.map((Club club) {
                      return DropdownMenuItem<Club>(
                          value: club, child: Text(club.name));
                    }).toList(),
                    onChanged: (val) {},
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        labelText: 'Executive Position',
                        border: OutlineInputBorder()),
                    items: [
                      'President',
                      'Vice President',
                      'General Secretary',
                      'Treasurer'
                    ].map((String pos) {
                      return DropdownMenuItem<String>(
                          value: pos, child: Text(pos));
                    }).toList(),
                    onChanged: (val) {},
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Full Name',
                      hint: 'Jane Doe',
                      icon: Icons.person_outline),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Admin Email',
                      hint: 'admin@baust.edu.bd',
                      icon: Icons.email_outlined),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Club Secret Verification Key',
                      hint: 'Ask previous admin',
                      icon: Icons.key_outlined,
                      obscureText: true),
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
                              'Warning: Your request must be verified and approved by the HR office before you can log in.',
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
                    text: 'Submit Request',
                    onPressed: () {
                      context.pop();
                    },
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
