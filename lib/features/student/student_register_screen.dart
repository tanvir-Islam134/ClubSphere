import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';
import '../../widgets/app_header.dart';

class StudentRegisterScreen extends StatelessWidget {
  const StudentRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(
              title: 'Student Registration', subtitle: 'Create a new account'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppTextField(
                      label: 'Full Name',
                      hint: 'John Doe',
                      icon: Icons.person_outline),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Student ID',
                      hint: 'e.g. 200101001',
                      icon: Icons.badge_outlined),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Institutional Email',
                      hint: 'id@baust.edu.bd',
                      icon: Icons.email_outlined),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                              labelText: 'Department',
                              border: OutlineInputBorder()),
                          items: ['CSE', 'EEE', 'ME', 'IPE', 'BBA', 'English']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                              labelText: 'Batch', border: OutlineInputBorder()),
                          items: ['10th', '11th', '12th'].map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Password',
                      hint: 'Create a password',
                      obscureText: true,
                      icon: Icons.lock_outline),
                  const SizedBox(height: 16),
                  const AppTextField(
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                      obscureText: true,
                      icon: Icons.lock_outline),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Register',
                    onPressed: () {
                      context.go('/student/dashboard');
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
