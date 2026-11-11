import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/buttons.dart';

class ReportsScreen extends ConsumerWidget {
  final String clubId;
  const ReportsScreen({super.key, required this.clubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members =
        ref.watch(membersProvider).where((m) => m.clubId == clubId).toList();
    final depts = members.map((m) => m.department).toSet();
    Map<String, int> deptCounts = {};
    for (var dept in depts) {
      deptCounts[dept] = members.where((m) => m.department == dept).length;
    }

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Reports & Analytics'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: AppColors.primaryLight,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text('Total Members',
                                    style: TextStyle(color: AppColors.primary)),
                                const SizedBox(height: 8),
                                Text('${members.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(color: AppColors.primary)),
                                const Text('+12 this month',
                                    style: TextStyle(
                                        color: AppColors.success,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          color: AppColors.primaryLight,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text('Approved (Sem)',
                                    style: TextStyle(color: AppColors.primary)),
                                const SizedBox(height: 8),
                                Text('45',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(color: AppColors.primary)),
                                const Text('Total 50 applied',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('Member Growth (6 Months)',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _bar(40, 'Jan'),
                        _bar(60, 'Feb'),
                        _bar(80, 'Mar'),
                        _bar(120, 'Apr'),
                        _bar(150, 'May'),
                        _bar(165, 'Jun')
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Members by Department',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 16),
                  ...deptCounts.entries.map((e) {
                    final fraction = e.value / members.length;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.key),
                              Text('${e.value}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: fraction,
                            backgroundColor: AppColors.primaryLight,
                            color: AppColors.primary,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          )
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                  PrimaryButton(text: 'Export Report (PDF)', onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(double height, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
