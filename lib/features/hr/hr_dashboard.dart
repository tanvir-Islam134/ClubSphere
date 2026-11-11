import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../data/models/models.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/stat_card.dart';

class HrDashboard extends ConsumerWidget {
  const HrDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubs = ref.watch(clubsProvider);
    final allRequests = ref.watch(adminRequestNotifierProvider);
    final pendingRequests = allRequests
        .where((r) => r.status == AdminApprovalStatus.pending)
        .toList();
    final approvedAdmins = ref.watch(adminsProvider);

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('HR Portal',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.primaryLight)),
                      Text('Overview',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Colors.white)),
                    ],
                  ),
                  Container(
                    width: 44,
                    height: 44,
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
                                icon: Icons.business,
                                title: 'Clubs',
                                value: clubs.length.toString())),
                        const SizedBox(width: 16),
                        Expanded(
                            child: StatCard(
                                icon: Icons.admin_panel_settings,
                                title: 'Admins',
                                value: approvedAdmins.length.toString())),
                      ],
                    ),
                    const SizedBox(height: 16),
                    StatCard(
                        icon: Icons.pending_actions,
                        title: 'Pending Admin Approvals',
                        value: pendingRequests.length.toString(),
                        iconColor: AppColors.warning),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pending Approvals',
                            style: Theme.of(context).textTheme.displaySmall),
                        TextButton(
                          onPressed: () => context.go('/hr/admins'),
                          child: const Text('See All'),
                        )
                      ],
                    ),
                    if (pendingRequests.isEmpty)
                      const Text('No pending requests.')
                    else
                      ...pendingRequests.take(3).map((r) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(r.name),
                              subtitle: Text(r.role),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () => context.go('/hr/admins'),
                            ),
                          )),
                    const SizedBox(height: 32),
                    Text('Clubs Directory',
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 16),
                    ...clubs.map((c) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: AppColors.primaryLight,
                                child: Text(c.name[0])),
                            title: Text(c.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(c.department),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () => context.push('/hr/clubs/${c.id}'),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
