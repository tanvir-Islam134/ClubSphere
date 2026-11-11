import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/buttons.dart';

class AllClubsScreen extends ConsumerStatefulWidget {
  const AllClubsScreen({super.key});

  @override
  ConsumerState<AllClubsScreen> createState() => _AllClubsScreenState();
}

class _AllClubsScreenState extends ConsumerState<AllClubsScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final clubs = ref.watch(clubsProvider);
    final filteredClubs = clubs.where((c) {
      final matchesSearch =
          c.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          c.department.contains(_selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'All Clubs', showBack: false),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primaryLight,
            width: double.infinity,
            child: Text(
              'Total Active Clubs: ${clubs.length}',
              style: const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search clubs...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: ['All', 'CSE', 'EEE', 'All Depts'].map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (val) =>
                        setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                        color:
                            isSelected ? Colors.white : AppColors.textPrimary),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredClubs.length,
              itemBuilder: (context, index) {
                final club = filteredClubs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 24,
                                backgroundColor: AppColors.primaryLight,
                                child: Text(club.name[0])),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(club.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(club.department,
                                        style: const TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Members: 120'), // Mock
                            Text('Past Events: 15'), // Mock
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppOutlineButton(
                          text: 'View Details',
                          onPressed: () =>
                              context.push('/student/clubs/${club.id}'),
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
