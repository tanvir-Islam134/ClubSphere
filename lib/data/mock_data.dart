import 'models/models.dart';

class MockData {
  static final List<Club> clubs = [
    Club(
      id: 'c1',
      name: 'BAUST Computer Club',
      department: 'CSE',
      description:
          'The official computer club of BAUST. We organize programming contests, tech talks, and workshops.',
      contactEmail: 'bcc@baust.edu.bd',
      logoUrl: 'assets/images/baust_logo.png',
      coverUrl: 'assets/images/bcc_cover.png',
    ),
    Club(
      id: 'c2',
      name: 'BAUST Robotics Club',
      department: 'EEE',
      description:
          'Building the future with robotics. Join us to learn about electronics, microcontrollers, and automation.',
      contactEmail: 'brc@baust.edu.bd',
      logoUrl: 'assets/images/baust_logo.png',
    ),
    Club(
      id: 'c3',
      name: 'BAUST Cultural Club',
      department: 'All Depts',
      description:
          'Celebrating diversity and culture through music, dance, and drama.',
      contactEmail: 'cultural@baust.edu.bd',
      logoUrl: 'assets/images/baust_logo.png',
    ),
    Club(
      id: 'c4',
      name: 'BAUST Sports Club',
      department: 'All Depts',
      description:
          'Promoting physical fitness and sportsmanship among students.',
      contactEmail: 'sports@baust.edu.bd',
      logoUrl: 'assets/images/baust_logo.png',
    ),
    Club(
      id: 'c5',
      name: 'Career Society BAUST',
      department: 'All Depts',
      description:
          'Helping students prepare for their future careers with workshops, seminars, and networking events.',
      contactEmail: 'careers@baust.edu.bd',
      logoUrl: 'assets/images/baust_logo.png',
    ),
  ];

  static final Student currentStudent = Student(
    id: 's1',
    name: 'John Doe',
    studentId: '200101001',
    department: 'CSE',
    batch: '10th',
    semester: '7th',
    email: 'john.doe@baust.edu.bd',
  );

  static final List<ClubMember> members = [
    ClubMember(
      id: 'm1',
      clubId: 'c1',
      studentId: '200101001',
      name: 'John Doe',
      department: 'CSE',
      batch: '10th',
      role: 'Member',
    ),
    ClubMember(
      id: 'm2',
      clubId: 'c1',
      studentId: '190101005',
      name: 'Alice Smith',
      department: 'CSE',
      batch: '9th',
      role: 'President',
    ),
    ClubMember(
      id: 'm3',
      clubId: 'c1',
      studentId: '190101012',
      name: 'Bob Johnson',
      department: 'CSE',
      batch: '9th',
      role: 'General Secretary',
    ),
  ];

  static final List<MembershipRequest> membershipRequests = [
    MembershipRequest(
      id: 'mr1',
      clubId: 'c2',
      studentId: '200101001',
      name: 'John Doe',
      department: 'CSE',
      batch: '10th',
      motivation: 'I am passionate about robotics and want to learn more.',
      appliedDate: DateTime.now().subtract(const Duration(days: 2)),
      status: MembershipStatus.pending,
    ),
  ];

  static final List<ClubAdmin> admins = [
    ClubAdmin(
      id: 'a1',
      clubId: 'c1',
      name: 'Alice Smith',
      email: 'alice.smith@baust.edu.bd',
      role: 'President',
    ),
  ];

  static final List<AdminApprovalRequest> adminRequests = [
    AdminApprovalRequest(
      id: 'ar1',
      clubId: 'c2',
      adminId: 'a2',
      name: 'Charlie Brown',
      studentId: '190201001',
      email: 'charlie.brown@baust.edu.bd',
      role: 'President',
      status: AdminApprovalStatus.pending,
      appliedDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static final List<Notice> notices = [
    Notice(
      id: 'n1',
      clubId: 'c1',
      title: 'Upcoming Programming Contest',
      message:
          'Registration is open for the upcoming inter-university programming contest.',
      sendTo: 'All Members',
      postedDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static final List<ActivityLogEntry> activities = [
    ActivityLogEntry(
      id: 'act1',
      clubId: 'c1',
      title: 'Intra-University Hackathon 2023',
      description:
          'A 24-hour hackathon where students built innovative solutions.',
      date: DateTime.now().subtract(const Duration(days: 30)),
      winner: 'Team Alpha',
    ),
  ];
}
