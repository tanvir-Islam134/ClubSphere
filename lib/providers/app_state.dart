import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';
import '../data/mock_data.dart';

// Current Role State
enum AppRole { none, student, admin, hr }

class RoleNotifier extends Notifier<AppRole> {
  @override
  AppRole build() => AppRole.none;

  void setRole(AppRole role) {
    state = role;
  }
}

final roleProvider = NotifierProvider<RoleNotifier, AppRole>(RoleNotifier.new);

// Current User Context (for simpler mock logic)
final currentStudentProvider =
    Provider<Student>((ref) => MockData.currentStudent);

class CurrentAdminClubIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setId(String? id) {
    state = id;
  }
}

final currentAdminClubIdProvider =
    NotifierProvider<CurrentAdminClubIdNotifier, String?>(
        CurrentAdminClubIdNotifier.new);

// Data Providers
class ClubsNotifier extends Notifier<List<Club>> {
  @override
  List<Club> build() => MockData.clubs;

  void updateClubs(List<Club> clubs) {
    state = clubs;
  }
}

final clubsProvider =
    NotifierProvider<ClubsNotifier, List<Club>>(ClubsNotifier.new);

class MembersNotifier extends Notifier<List<ClubMember>> {
  @override
  List<ClubMember> build() => MockData.members;

  void updateMembers(List<ClubMember> members) {
    state = members;
  }
}

final membersProvider =
    NotifierProvider<MembersNotifier, List<ClubMember>>(MembersNotifier.new);

class MembershipRequestNotifier extends Notifier<List<MembershipRequest>> {
  @override
  List<MembershipRequest> build() => MockData.membershipRequests;

  void addRequest(MembershipRequest request) {
    state = [...state, request];
  }

  void updateRequestStatus(String requestId, MembershipStatus status,
      {String? declineReason}) {
    state = state.map((req) {
      if (req.id == requestId) {
        return req.copyWith(status: status, declineReason: declineReason);
      }
      return req;
    }).toList();
  }
}

final membershipRequestNotifierProvider =
    NotifierProvider<MembershipRequestNotifier, List<MembershipRequest>>(
        MembershipRequestNotifier.new);

class AdminRequestNotifier extends Notifier<List<AdminApprovalRequest>> {
  @override
  List<AdminApprovalRequest> build() => MockData.adminRequests;

  void addRequest(AdminApprovalRequest request) {
    state = [...state, request];
  }

  void updateRequestStatus(String requestId, AdminApprovalStatus status) {
    state = state.map((req) {
      if (req.id == requestId) {
        return req.copyWith(status: status);
      }
      return req;
    }).toList();
  }
}

final adminRequestNotifierProvider =
    NotifierProvider<AdminRequestNotifier, List<AdminApprovalRequest>>(
        AdminRequestNotifier.new);

class NoticesNotifier extends Notifier<List<Notice>> {
  @override
  List<Notice> build() => MockData.notices;

  void updateNotices(List<Notice> notices) {
    state = notices;
  }
}

final noticesProvider =
    NotifierProvider<NoticesNotifier, List<Notice>>(NoticesNotifier.new);

class ActivitiesNotifier extends Notifier<List<ActivityLogEntry>> {
  @override
  List<ActivityLogEntry> build() => MockData.activities;

  void updateActivities(List<ActivityLogEntry> activities) {
    state = activities;
  }
}

final activitiesProvider =
    NotifierProvider<ActivitiesNotifier, List<ActivityLogEntry>>(
        ActivitiesNotifier.new);

class AdminsNotifier extends Notifier<List<ClubAdmin>> {
  @override
  List<ClubAdmin> build() => MockData.admins;

  void updateAdmins(List<ClubAdmin> admins) {
    state = admins;
  }
}

final adminsProvider =
    NotifierProvider<AdminsNotifier, List<ClubAdmin>>(AdminsNotifier.new);
