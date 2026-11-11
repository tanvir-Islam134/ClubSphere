import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../widgets/app_header.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMsg;

  void _login() {
    if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMsg = 'Please enter both ID and password');
      return;
    }
    // Mock login success
    context.go('/student/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(
              title: 'Student Login', subtitle: 'Sign in to access your clubs'),
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
                          width: 76,
                          height: 76,
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
                          'Student Portal',
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
                          'Sign in with your institutional credentials',
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
                  if (_errorMsg != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.errorLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMsg!,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  AppTextField(
                    controller: _idController,
                    label: 'Student ID or Email',
                    hint: 'Enter your ID',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Login',
                    onPressed: _login,
                  ),
                  const SizedBox(height: 16),
                  AppOutlineButton(
                    text: 'Continue with BAUST SSO',
                    onPressed: _login,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? '),
                      TextButton(
                        onPressed: () => context.push('/student_register'),
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
