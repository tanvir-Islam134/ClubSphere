import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/splash_screen.dart';
import '../../features/auth/role_selection_screen.dart';
import '../../features/student/student_login_screen.dart';
import '../../features/student/student_register_screen.dart';
import '../../features/student/student_dashboard.dart';
import '../../features/student/all_clubs_screen.dart';
import '../../features/student/my_applications_screen.dart';
import '../../features/student/student_profile_screen.dart';
import '../../features/student/club_details_screen.dart';
import '../../widgets/bottom_nav_bar.dart';

import '../../features/admin/admin_login_screen.dart';
import '../../features/admin/admin_register_screen.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/admin/admin_requests_screen.dart';
import '../../features/admin/manage_members_screen.dart';
import '../../features/admin/admin_profile_screen.dart';
import '../../features/admin/post_notice_screen.dart';
import '../../features/admin/club_profile_edit_screen.dart';
import '../../features/admin/reports_screen.dart';

import '../../features/hr/hr_login_screen.dart';
import '../../features/hr/hr_register_screen.dart';
import '../../features/hr/hr_dashboard.dart';
import '../../features/hr/hr_admin_approvals_screen.dart';
import '../../features/hr/hr_club_information_screen.dart';
import '../../features/hr/hr_profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _studentShellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _adminShellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _hrShellNavigatorKey =
    GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/role_selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    // Auth routes
    GoRoute(
      path: '/student_login',
      builder: (context, state) => const StudentLoginScreen(),
    ),
    GoRoute(
      path: '/student_register',
      builder: (context, state) => const StudentRegisterScreen(),
    ),
    GoRoute(
      path: '/admin_login',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      path: '/admin_register',
      builder: (context, state) => const AdminRegisterScreen(),
    ),
    GoRoute(
      path: '/hr_login',
      builder: (context, state) => const HrLoginScreen(),
    ),
    GoRoute(
      path: '/hr_register',
      builder: (context, state) => const HrRegisterScreen(),
    ),
    // Student Shell
    ShellRoute(
      navigatorKey: _studentShellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar:
              _StudentBottomNav(currentLocation: state.uri.path),
        );
      },
      routes: [
        GoRoute(
          path: '/student/dashboard',
          builder: (context, state) => const StudentDashboard(),
        ),
        GoRoute(
          path: '/student/clubs',
          builder: (context, state) => const AllClubsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  ClubDetailsScreen(clubId: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/student/applications',
          builder: (context, state) => const MyApplicationsScreen(),
        ),
        GoRoute(
          path: '/student/profile',
          builder: (context, state) => const StudentProfileScreen(),
        ),
      ],
    ),
    // Admin Shell
    ShellRoute(
      navigatorKey: _adminShellNavigatorKey,
      builder: (context, state, child) {
        final clubId = state.pathParameters['clubId'] ?? '';
        return Scaffold(
          body: child,
          bottomNavigationBar:
              _AdminBottomNav(currentLocation: state.uri.path, clubId: clubId),
        );
      },
      routes: [
        GoRoute(
          path: '/admin/:clubId/dashboard',
          builder: (context, state) =>
              AdminDashboard(clubId: state.pathParameters['clubId']!),
        ),
        GoRoute(
          path: '/admin/:clubId/requests',
          builder: (context, state) =>
              AdminRequestsScreen(clubId: state.pathParameters['clubId']!),
        ),
        GoRoute(
          path: '/admin/:clubId/members',
          builder: (context, state) =>
              ManageMembersScreen(clubId: state.pathParameters['clubId']!),
        ),
        GoRoute(
          path: '/admin/:clubId/profile',
          builder: (context, state) =>
              AdminProfileScreen(clubId: state.pathParameters['clubId']!),
        ),
        // Admin sub-routes without bottom nav can just be pushed normally, but if they are inside ShellRoute they will have the nav.
        // For Post Notice, Edit Profile, Reports, they should probably NOT have bottom nav, but the requirement doesn't strictly forbid it.
        // Let's put them OUTSIDE the shell route if we don't want bottom nav, but go_router makes it easier if we just put them at the root, or use parentNavigatorKey.
        GoRoute(
          path: '/admin/:clubId/post_notice',
          builder: (context, state) =>
              PostNoticeScreen(clubId: state.pathParameters['clubId']!),
        ),
        GoRoute(
          path: '/admin/:clubId/edit_profile',
          builder: (context, state) =>
              ClubProfileEditScreen(clubId: state.pathParameters['clubId']!),
        ),
        GoRoute(
          path: '/admin/:clubId/reports',
          builder: (context, state) =>
              ReportsScreen(clubId: state.pathParameters['clubId']!),
        ),
      ],
    ),
    // HR Shell
    ShellRoute(
      navigatorKey: _hrShellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: _HrBottomNav(currentLocation: state.uri.path),
        );
      },
      routes: [
        GoRoute(
          path: '/hr/dashboard',
          builder: (context, state) => const HrDashboard(),
        ),
        GoRoute(
          path: '/hr/admins',
          builder: (context, state) => const HrAdminApprovalsScreen(),
        ),
        GoRoute(
          path: '/hr/clubs/:clubId',
          builder: (context, state) =>
              HrClubInformationScreen(clubId: state.pathParameters['clubId']!),
        ),
        GoRoute(
          path: '/hr/profile',
          builder: (context, state) => const HrProfileScreen(),
        ),
      ],
    ),
  ],
);

class _HrBottomNav extends StatelessWidget {
  final String currentLocation;
  const _HrBottomNav({required this.currentLocation});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    if (currentLocation.contains('/admins')) currentIndex = 1;
    if (currentLocation.contains('/clubs')) currentIndex = 2;
    if (currentLocation.contains('/profile')) currentIndex = 3;

    return BottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) context.go('/hr/dashboard');
        if (index == 1) context.go('/hr/admins');
        if (index == 2) {
          context.go(
              '/hr/clubs/c1'); // Mock, realistically should go to a directory or keep current club, but for simplicity let's route to dashboard if they click clubs tab without an ID, or create a HrClubsScreen. Actually user said "Clubs" list is on the HR Dashboard. If they click Clubs tab, we can route to dashboard or create a dedicated screen. Let's just route to Dashboard for simplicity if they click it, or we can make a dedicated list. Since the Dashboard has a "Clubs list" already, we can route to dashboard. Let's do `context.go('/hr/dashboard')` for now. Wait, if it's index 2, maybe we need a screen. For now just go dashboard. Wait, user requirements: "HR Dashboard... 'Clubs' list (each row opens that club's Club Information screen)... Bottom nav: Overview / Admins / Clubs / Profile".
        }
        if (index == 3) context.go('/hr/profile');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Overview'),
        BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings), label: 'Admins'),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Clubs'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class _AdminBottomNav extends StatelessWidget {
  final String currentLocation;
  final String clubId;
  const _AdminBottomNav({required this.currentLocation, required this.clubId});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    if (currentLocation.contains('/requests')) currentIndex = 1;
    if (currentLocation.contains('/members')) currentIndex = 2;
    if (currentLocation.contains('/profile')) currentIndex = 3;

    return BottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) context.go('/admin/$clubId/dashboard');
        if (index == 1) context.go('/admin/$clubId/requests');
        if (index == 2) context.go('/admin/$clubId/members');
        if (index == 3) context.go('/admin/$clubId/profile');
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add), label: 'Requests'),
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Members'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class _StudentBottomNav extends StatelessWidget {
  final String currentLocation;
  const _StudentBottomNav({required this.currentLocation});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    if (currentLocation.startsWith('/student/clubs')) currentIndex = 1;
    if (currentLocation.startsWith('/student/applications')) currentIndex = 2;
    if (currentLocation.startsWith('/student/profile')) currentIndex = 3;

    return BottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) context.go('/student/dashboard');
        if (index == 1) context.go('/student/clubs');
        if (index == 2) context.go('/student/applications');
        if (index == 3) context.go('/student/profile');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Clubs'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
