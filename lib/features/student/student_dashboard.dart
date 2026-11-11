import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(currentStudentProvider);
    final allMemberships = ref.watch(membersProvider);
    final myClubs =
        allMemberships.where((m) => m.studentId == student.studentId).toList();
    final allRequests = ref.watch(membershipRequestNotifierProvider);
    final myRequests =
        allRequests.where((r) => r.studentId == student.studentId).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, student.name),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Active Clubs',
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 16),
                    if (myClubs.isEmpty)
                      const EmptyState(
                        icon: Icons.group_off,
                        title: 'No Active Clubs',
                        description: 'Join a club to see it here.',
                      )
                    else
                      ...myClubs.map((m) {
                        final club = ref
                            .watch(clubsProvider)
                            .firstWhere((c) => c.id == m.clubId);
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: AppColors.primaryLight,
                                child: Text(club.name[0])),
                            title: Text(club.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            subtitle: Text('Role: ${m.role}'),
                            trailing: const StatusBadge(
                              label: 'Active Member',
                              bgColor: AppColors.successLight,
                              textColor: AppColors.success,
                            ),
                          ),
                        );
                      }),
                    const SizedBox(height: 32),
                    Text('Application Status Tracker',
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 16),
                    if (myRequests.isEmpty)
                      const EmptyState(
                        icon: Icons.history,
                        title: 'No Applications',
                        description: 'Your applications will appear here.',
                      )
                    else
                      ...myRequests.map((r) {
                        final club = ref
                            .watch(clubsProvider)
                            .firstWhere((c) => c.id == r.clubId);
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: AppColors.primaryLight,
                                child: Text(club.name[0])),
                            title: Text(club.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            subtitle: Text(
                                'Applied: ${r.appliedDate.toString().split(' ')[0]}'),
                            trailing: StatusBadge.membership(r.status),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello,',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.primaryLight)),
                  Text(name,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.white)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(width: 4),
              Container(
                width: 38,
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/baust_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
