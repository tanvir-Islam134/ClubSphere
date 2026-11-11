import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../data/models/models.dart';
import '../../widgets/empty_state.dart';

class AdminRequestsScreen extends ConsumerWidget {
  final String clubId;
  const AdminRequestsScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingRequests = ref
        .watch(membershipRequestNotifierProvider)
        .where(
            (r) => r.clubId == clubId && r.status == MembershipStatus.pending)
        .toList();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Membership Requests'),
          Expanded(
            child: pendingRequests.isEmpty
                ? const EmptyState(
                    icon: Icons.check_circle_outline,
                    title: 'All Caught Up!',
                    description: 'No pending requests.')
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: pendingRequests.length,
                    itemBuilder: (context, index) {
                      final req = pendingRequests[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: AppColors.primaryLight,
                                      child: Text(req.name[0])),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(req.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        Text(
                                            '${req.studentId} • ${req.department} • ${req.batch}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text('Motivation:',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                              Text(req.motivation,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.error,
                                          side: const BorderSide(
                                              color: AppColors.error)),
                                      onPressed: () {
                                        ref
                                            .read(
                                                membershipRequestNotifierProvider
                                                    .notifier)
                                            .updateRequestStatus(req.id,
                                                MembershipStatus.declined,
                                                declineReason:
                                                    'Does not meet requirements.');
                                      },
                                      child: const Text('Decline'),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.success),
                                      onPressed: () {
                                        ref
                                            .read(
                                                membershipRequestNotifierProvider
                                                    .notifier)
                                            .updateRequestStatus(req.id,
                                                MembershipStatus.accepted);
                                      },
                                      child: const Text('Approve'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
