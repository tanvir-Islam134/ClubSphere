import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/status_badge.dart';
import '../../data/models/models.dart';
import '../../widgets/empty_state.dart';

class HrAdminApprovalsScreen extends ConsumerStatefulWidget {
  const HrAdminApprovalsScreen({super.key});

  @override
  ConsumerState<HrAdminApprovalsScreen> createState() =>
      _HrAdminApprovalsScreenState();
}

class _HrAdminApprovalsScreenState
    extends ConsumerState<HrAdminApprovalsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final allRequests = ref.watch(adminRequestNotifierProvider);

    List<AdminApprovalRequest> filteredRequests = [];
    if (_selectedIndex == 0) {
      filteredRequests = allRequests
          .where((r) => r.status == AdminApprovalStatus.pending)
          .toList();
    }
    if (_selectedIndex == 1) {
      filteredRequests = allRequests
          .where((r) => r.status == AdminApprovalStatus.approved)
          .toList();
    }
    if (_selectedIndex == 2) {
      filteredRequests = allRequests
          .where((r) => r.status == AdminApprovalStatus.declined)
          .toList();
    }

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Admin Approvals', showBack: false),
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.primaryLight,
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                        'A club admin can manage a club only after HR approval.',
                        style: TextStyle(color: AppColors.primary))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Pending')),
                ButtonSegment(value: 1, label: Text('Approved')),
                ButtonSegment(value: 2, label: Text('Declined')),
              ],
              selected: {_selectedIndex},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() => _selectedIndex = newSelection.first);
              },
            ),
          ),
          Expanded(
            child: filteredRequests.isEmpty
                ? const EmptyState(
                    icon: Icons.check_circle_outline,
                    title: 'No Requests',
                    description: 'Nothing to show here.')
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final req = filteredRequests[index];
                      final club = ref.watch(clubsProvider).firstWhere(
                          (c) => c.id == req.clubId,
                          orElse: () => Club(
                              id: '',
                              name: 'Unknown',
                              department: '',
                              description: '',
                              contactEmail: ''));

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
                                        Text('${club.name} • ${req.role}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text(req.studentId,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                  ),
                                  StatusBadge.adminApproval(req.status),
                                ],
                              ),
                              if (req.status ==
                                  AdminApprovalStatus.pending) ...[
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
                                              .read(adminRequestNotifierProvider
                                                  .notifier)
                                              .updateRequestStatus(req.id,
                                                  AdminApprovalStatus.declined);
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
                                              .read(adminRequestNotifierProvider
                                                  .notifier)
                                              .updateRequestStatus(req.id,
                                                  AdminApprovalStatus.approved);
                                        },
                                        child: const Text('Approve'),
                                      ),
                                    ),
                                  ],
                                )
                              ]
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
