import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/buttons.dart';
import '../../data/models/models.dart';

class ClubDetailsScreen extends ConsumerWidget {
  final String clubId;
  const ClubDetailsScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = ref.watch(clubsProvider).firstWhere((c) => c.id == clubId);
    final members =
        ref.watch(membersProvider).where((m) => m.clubId == clubId).toList();
    final activities =
        ref.watch(activitiesProvider).where((a) => a.clubId == clubId).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(club.name),
              background: Container(
                color: AppColors.primary,
                child: Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      club.logoUrl.isNotEmpty
                          ? club.logoUrl
                          : 'assets/images/baust_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About Us',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 8),
                  Text(club.description,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Request to Join Club',
                    onPressed: () {
                      _showApplicationDialog(context, ref, club);
                    },
                  ),
                  const SizedBox(height: 32),
                  Text('Executive Committee',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  ...members
                      .where((m) => m.role != 'Member')
                      .map((m) => ListTile(
                            leading:
                                const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(m.name),
                            subtitle: Text(m.role),
                          )),
                  const SizedBox(height: 32),
                  Text('General Members',
                      style: Theme.of(context).textTheme.displayMedium),
                  ...members
                      .where((m) => m.role == 'Member')
                      .map((m) => ListTile(
                            leading:
                                const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(m.name),
                            subtitle: Text(m.studentId),
                          )),
                  const SizedBox(height: 32),
                  Text('Past Activities',
                      style: Theme.of(context).textTheme.displayMedium),
                  ...activities.map((a) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(a.title),
                          subtitle: Text(a.date.toString().split(' ')[0]),
                          trailing: a.winner != null
                              ? Text('Winner: ${a.winner}')
                              : null,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showApplicationDialog(BuildContext context, WidgetRef ref, Club club) {
    final motivationController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Join ${club.name}'),
        content: TextField(
          controller: motivationController,
          decoration:
              const InputDecoration(hintText: 'Why do you want to join?'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final student = ref.read(currentStudentProvider);
              final req = MembershipRequest(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                clubId: club.id,
                studentId: student.studentId,
                name: student.name,
                department: student.department,
                batch: student.batch,
                motivation: motivationController.text,
                appliedDate: DateTime.now(),
                status: MembershipStatus.pending,
              );
              ref
                  .read(membershipRequestNotifierProvider.notifier)
                  .addRequest(req);
              Navigator.pop(context);
              context.go('/student/applications');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
