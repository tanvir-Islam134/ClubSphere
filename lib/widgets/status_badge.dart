import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../data/models/models.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  factory StatusBadge.membership(MembershipStatus status) {
    switch (status) {
      case MembershipStatus.accepted:
        return const StatusBadge(
          label: 'Accepted',
          bgColor: AppColors.successLight,
          textColor: AppColors.success,
        );
      case MembershipStatus.pending:
        return const StatusBadge(
          label: 'Pending',
          bgColor: AppColors.warningLight,
          textColor: AppColors.warning,
        );
      case MembershipStatus.declined:
        return const StatusBadge(
          label: 'Declined',
          bgColor: AppColors.errorLight,
          textColor: AppColors.error,
        );
    }
  }

  factory StatusBadge.adminApproval(AdminApprovalStatus status) {
    switch (status) {
      case AdminApprovalStatus.approved:
        return const StatusBadge(
          label: 'Approved',
          bgColor: AppColors.successLight,
          textColor: AppColors.success,
        );
      case AdminApprovalStatus.pending:
        return const StatusBadge(
          label: 'Pending',
          bgColor: AppColors.warningLight,
          textColor: AppColors.warning,
        );
      case AdminApprovalStatus.declined:
        return const StatusBadge(
          label: 'Declined',
          bgColor: AppColors.errorLight,
          textColor: AppColors.error,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
            ),
      ),
    );
  }
}
