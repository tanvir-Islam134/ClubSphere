import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/status_badge.dart';
import '../../data/models/models.dart';

class MyApplicationsScreen extends ConsumerStatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  ConsumerState<MyApplicationsScreen> createState() =>
      _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends ConsumerState<MyApplicationsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final student = ref.watch(currentStudentProvider);
    final allRequests = ref.watch(membershipRequestNotifierProvider);
    final myRequests =
        allRequests.where((r) => r.studentId == student.studentId).toList();

    List<MembershipRequest> filteredRequests = [];
    if (_selectedIndex == 0) {
      filteredRequests = myRequests
          .where((r) => r.status == MembershipStatus.pending)
          .toList();
    }
    if (_selectedIndex == 1) {
      filteredRequests = myRequests
          .where((r) => r.status == MembershipStatus.accepted)
          .toList();
    }
    if (_selectedIndex == 2) {
      filteredRequests = myRequests
          .where((r) => r.status == MembershipStatus.declined)
          .toList();
    }

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'My Applications', showBack: false),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Pending')),
                ButtonSegment(value: 1, label: Text('Accepted')),
                ButtonSegment(value: 2, label: Text('Declined')),
              ],
              selected: {_selectedIndex},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() => _selectedIndex = newSelection.first);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                final req = filteredRequests[index];
                final club = ref
                    .watch(clubsProvider)
                    .firstWhere((c) => c.id == req.clubId);
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(club.name,
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            StatusBadge.membership(req.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                            'Applied: ${req.appliedDate.toString().split(' ')[0]}'),
                        const SizedBox(height: 16),
                        _buildProgressTracker(req.status),
                        if (req.status == MembershipStatus.declined &&
                            req.declineReason != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.errorLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Reason: ${req.declineReason}',
                              style: const TextStyle(color: AppColors.error),
                            ),
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

  Widget _buildProgressTracker(MembershipStatus status) {
    return Row(
      children: [
        _trackerStep('Submitted', true),
        _trackerDivider(),
        _trackerStep('Under Review', status == MembershipStatus.pending),
        _trackerDivider(),
        _trackerStep('Decision', status != MembershipStatus.pending),
      ],
    );
  }

  Widget _trackerStep(String label, bool isActive) {
    return Column(
      children: [
        Icon(Icons.check_circle,
            color: isActive ? AppColors.primary : Colors.grey[300]),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: isActive ? AppColors.textPrimary : Colors.grey)),
      ],
    );
  }

  Widget _trackerDivider() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey[300],
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
