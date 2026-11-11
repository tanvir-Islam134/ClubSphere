import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/buttons.dart';

class HrClubInformationScreen extends ConsumerWidget {
  final String clubId;
  const HrClubInformationScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = ref.watch(clubsProvider).firstWhere((c) => c.id == clubId);
    final members =
        ref.watch(membersProvider).where((m) => m.clubId == clubId).toList();
    final admins =
        ref.watch(adminsProvider).where((a) => a.clubId == clubId).toList();
    final activities =
        ref.watch(activitiesProvider).where((a) => a.clubId == clubId).toList();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Club Information'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: club.logoUrl.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.asset(club.logoUrl,
                                    fit: BoxFit.contain),
                              )
                            : Text(club.name[0],
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(club.name,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            Text(club.department,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.successLight,
                            borderRadius: BorderRadius.circular(999)),
                        child: const Text('Active',
                            style: TextStyle(
                                color: AppColors.success,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                          child: StatCard(
                              icon: Icons.groups,
                              title: 'Members',
                              value: members.length.toString())),
                      const SizedBox(width: 12),
                      Expanded(
                          child: StatCard(
                              icon: Icons.event,
                              title: 'Events',
                              value: activities.length.toString())),
                      const SizedBox(width: 12),
                      Expanded(
                          child: StatCard(
                              icon: Icons.admin_panel_settings,
                              title: 'Admins',
                              value: admins.length.toString())),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('Approved Admins',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  if (admins.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No approved admins for this club.'),
                      ),
                    )
                  else
                    ...admins.map((admin) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(admin.name),
                            subtitle: Text('${admin.role} • ${admin.email}'),
                            trailing: const Icon(Icons.check_circle,
                                color: AppColors.success),
                          ),
                        )),
                  const SizedBox(height: 32),
                  Text('Budget Overview',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Allocated: \$5000'),
                              Text('Spent: \$2000'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 2000 / 5000,
                            backgroundColor: AppColors.primaryLight,
                            color: AppColors.primary,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                          child: AppOutlineButton(
                              text: 'View Members', onPressed: () {})),
                      const SizedBox(width: 16),
                      Expanded(
                          child: PrimaryButton(
                              text: 'Export Report', onPressed: () {})),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('Recent Activity',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  ...activities.map((a) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(a.title),
                          subtitle: Text(a.date.toString().split(' ')[0]),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
