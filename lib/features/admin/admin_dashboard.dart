import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../data/models/models.dart';

class AdminDashboard extends ConsumerWidget {
  final String clubId;
  const AdminDashboard({super.key, required this.clubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = ref.watch(clubsProvider).firstWhere((c) => c.id == clubId);
    final membersCount =
        ref.watch(membersProvider).where((m) => m.clubId == clubId).length;
    final requestsCount = ref
        .watch(membershipRequestNotifierProvider)
        .where(
            (r) => r.clubId == clubId && r.status == MembershipStatus.pending)
        .length;
    final eventsCount =
        ref.watch(activitiesProvider).where((a) => a.clubId == clubId).length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Admin Portal',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.primaryLight)),
                  Text(club.name,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: StatCard(
                                icon: Icons.groups,
                                title: 'Members',
                                value: membersCount.toString())),
                        const SizedBox(width: 16),
                        Expanded(
                            child: StatCard(
                                icon: Icons.pending_actions,
                                title: 'Pending',
                                value: requestsCount.toString(),
                                iconColor: AppColors.warning)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                            child: StatCard(
                                icon: Icons.event,
                                title: 'Events',
                                value: eventsCount.toString())),
                        const SizedBox(width: 16),
                        const Expanded(
                            child: StatCard(
                                icon: Icons.campaign,
                                title: 'Notices',
                                value: '1')),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text('Quick Actions',
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2.8,
                      children: [
                        _actionCard(
                            context,
                            Icons.person_add,
                            'Approve Requests',
                            () => context.push('/admin/$clubId/requests')),
                        _actionCard(
                            context,
                            Icons.manage_accounts,
                            'Manage Members',
                            () => context.push('/admin/$clubId/members')),
                        _actionCard(context, Icons.campaign, 'Post Notice',
                            () => context.push('/admin/$clubId/post_notice')),
                        _actionCard(context, Icons.edit, 'Club Profile',
                            () => context.push('/admin/$clubId/edit_profile')),
                        _actionCard(context, Icons.bar_chart, 'Reports',
                            () => context.push('/admin/$clubId/reports')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
