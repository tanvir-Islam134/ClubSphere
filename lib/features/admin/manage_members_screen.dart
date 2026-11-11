import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';

class ManageMembersScreen extends ConsumerStatefulWidget {
  final String clubId;
  const ManageMembersScreen({super.key, required this.clubId});

  @override
  ConsumerState<ManageMembersScreen> createState() =>
      _ManageMembersScreenState();
}

class _ManageMembersScreenState extends ConsumerState<ManageMembersScreen> {
  String _searchQuery = '';
  String _selectedRole = 'All';

  @override
  Widget build(BuildContext context) {
    final members = ref
        .watch(membersProvider)
        .where((m) => m.clubId == widget.clubId)
        .toList();
    final filteredMembers = members.where((m) {
      final matchesSearch =
          m.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              m.studentId.contains(_searchQuery);
      final matchesRole = _selectedRole == 'All' || m.role == _selectedRole;
      return matchesSearch && matchesRole;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Manage Members'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or ID...',
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
              children: [
                'All',
                'President',
                'VP',
                'General Secretary',
                'Member'
              ].map((role) {
                final isSelected = _selectedRole == role;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(role),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedRole = role),
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
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final m = filteredMembers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: AppColors.primaryLight,
                        child: Text(m.name[0])),
                    title: Text(m.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${m.studentId} • ${m.department}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(m.role, style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
