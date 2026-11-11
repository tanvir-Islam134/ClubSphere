enum MembershipStatus { pending, accepted, declined }

enum AdminApprovalStatus { pending, approved, declined }

class Club {
  final String id;
  final String name;
  final String department;
  final String description;
  final String contactEmail;
  final String logoUrl;
  final String coverUrl;

  Club({
    required this.id,
    required this.name,
    required this.department,
    required this.description,
    required this.contactEmail,
    this.logoUrl = '',
    this.coverUrl = '',
  });

  Club copyWith({
    String? id,
    String? name,
    String? department,
    String? description,
    String? contactEmail,
    String? logoUrl,
    String? coverUrl,
  }) {
    return Club(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
      description: description ?? this.description,
      contactEmail: contactEmail ?? this.contactEmail,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }
}

class Student {
  final String id;
  final String name;
  final String studentId;
  final String department;
  final String batch;
  final String semester;
  final String email;

  Student({
    required this.id,
    required this.name,
    required this.studentId,
    required this.department,
    required this.batch,
    required this.semester,
    required this.email,
  });
}

class ClubMember {
  final String id;
  final String clubId;
  final String studentId;
  final String name;
  final String department;
  final String batch;
  final String role; // President, VP, General Secretary, Member

  ClubMember({
    required this.id,
    required this.clubId,
    required this.studentId,
    required this.name,
    required this.department,
    required this.batch,
    required this.role,
  });
}

class MembershipRequest {
  final String id;
  final String clubId;
  final String studentId;
  final String name;
  final String department;
  final String batch;
  final String motivation;
  final DateTime appliedDate;
  final MembershipStatus status;
  final String? declineReason;

  MembershipRequest({
    required this.id,
    required this.clubId,
    required this.studentId,
    required this.name,
    required this.department,
    required this.batch,
    required this.motivation,
    required this.appliedDate,
    required this.status,
    this.declineReason,
  });

  MembershipRequest copyWith({
    MembershipStatus? status,
    String? declineReason,
  }) {
    return MembershipRequest(
      id: id,
      clubId: clubId,
      studentId: studentId,
      name: name,
      department: department,
      batch: batch,
      motivation: motivation,
      appliedDate: appliedDate,
      status: status ?? this.status,
      declineReason: declineReason ?? this.declineReason,
    );
  }
}

class ClubAdmin {
  final String id;
  final String clubId;
  final String name;
  final String email;
  final String role; // Executive position

  ClubAdmin({
    required this.id,
    required this.clubId,
    required this.name,
    required this.email,
    required this.role,
  });
}

class AdminApprovalRequest {
  final String id;
  final String clubId;
  final String adminId;
  final String name;
  final String studentId;
  final String email;
  final String role;
  final AdminApprovalStatus status;
  final DateTime appliedDate;

  AdminApprovalRequest({
    required this.id,
    required this.clubId,
    required this.adminId,
    required this.name,
    required this.studentId,
    required this.email,
    required this.role,
    required this.status,
    required this.appliedDate,
  });

  AdminApprovalRequest copyWith({
    AdminApprovalStatus? status,
  }) {
    return AdminApprovalRequest(
      id: id,
      clubId: clubId,
      adminId: adminId,
      name: name,
      studentId: studentId,
      email: email,
      role: role,
      status: status ?? this.status,
      appliedDate: appliedDate,
    );
  }
}

class Notice {
  final String id;
  final String clubId;
  final String title;
  final String message;
  final String sendTo;
  final DateTime postedDate;

  Notice({
    required this.id,
    required this.clubId,
    required this.title,
    required this.message,
    required this.sendTo,
    required this.postedDate,
  });
}

class ActivityLogEntry {
  final String id;
  final String clubId;
  final String title;
  final String description;
  final DateTime date;
  final String? winner;

  ActivityLogEntry({
    required this.id,
    required this.clubId,
    required this.title,
    required this.description,
    required this.date,
    this.winner,
  });
}
