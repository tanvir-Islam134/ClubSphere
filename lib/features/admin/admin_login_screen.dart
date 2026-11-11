import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../widgets/app_header.dart';
import '../../data/models/models.dart';

class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Club? _selectedClub;
  String? _errorMsg;

  void _login() {
    if (_selectedClub == null ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() => _errorMsg = 'Please fill all fields');
      return;
    }
    // Mock setting the current club id context
    ref.read(currentAdminClubIdProvider.notifier).setId(_selectedClub!.id);
    context.go('/admin/${_selectedClub!.id}/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final clubs = ref.watch(clubsProvider);

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Admin Login', subtitle: 'Manage your club'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_errorMsg != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                          color: AppColors.errorLight,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(_errorMsg!,
                          style: const TextStyle(color: AppColors.error)),
                    ),
                  DropdownButtonFormField<Club>(
                    decoration: const InputDecoration(
                        labelText: 'Select Club', border: OutlineInputBorder()),
                    items: clubs.map((Club club) {
                      return DropdownMenuItem<Club>(
                          value: club, child: Text(club.name));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedClub = val),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _emailController,
                    label: 'Admin Email',
                    hint: 'admin@baust.edu.bd',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  Card(
                    color: AppColors.primaryLight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.security, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Only authorized admins approved by HR can access this portal.',
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
                  PrimaryButton(text: 'Login', onPressed: _login),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered? '),
                      TextButton(
                        onPressed: () => context.push('/admin_register'),
                        child: const Text('Request Access'),
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
