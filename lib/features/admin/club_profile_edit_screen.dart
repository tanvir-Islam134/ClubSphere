import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/buttons.dart';

class ClubProfileEditScreen extends ConsumerStatefulWidget {
  final String clubId;
  const ClubProfileEditScreen({super.key, required this.clubId});

  @override
  ConsumerState<ClubProfileEditScreen> createState() =>
      _ClubProfileEditScreenState();
}

class _ClubProfileEditScreenState extends ConsumerState<ClubProfileEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final club =
        ref.read(clubsProvider).firstWhere((c) => c.id == widget.clubId);
    _nameController = TextEditingController(text: club.name);
    _descController = TextEditingController(text: club.description);
    _emailController = TextEditingController(text: club.contactEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Edit Club Profile'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primaryLight,
                          child: Icon(Icons.image,
                              size: 40, color: AppColors.primary),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.accent,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.edit,
                                  size: 16, color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                      controller: _nameController,
                      label: 'Club Name',
                      hint: ''),
                  const SizedBox(height: 16),
                  AppTextField(
                      controller: _descController,
                      label: 'Description',
                      hint: '',
                      maxLines: 4),
                  const SizedBox(height: 16),
                  AppTextField(
                      controller: _emailController,
                      label: 'Contact Email',
                      hint: ''),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: 'Save Changes',
                    onPressed: () {
                      final clubs = ref.read(clubsProvider);
                      final updatedClubs = clubs.map((c) {
                        if (c.id == widget.clubId) {
                          return c.copyWith(
                            name: _nameController.text,
                            description: _descController.text,
                            contactEmail: _emailController.text,
                          );
                        }
                        return c;
                      }).toList();
                      ref.read(clubsProvider.notifier).updateClubs(updatedClubs);
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 16),
                  AppOutlineButton(
                    text: 'Cancel',
                    onPressed: () => context.pop(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
