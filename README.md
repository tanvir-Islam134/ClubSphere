# ClubSphere - Project Documentation

Welcome to the **ClubSphere** project! This is a complete Flutter desktop & web application for the BAUST university club management system. 

This document explains the overall architecture, technology stack, and detailed folder structure of the codebase so you know exactly where to find and modify things.

---

## 🏗 Architecture Overview

The app follows a **Feature-Driven Architecture**. Instead of grouping files by their type (e.g., putting all screens in one folder, all controllers in another), we group files by the **feature** they belong to. This makes the project highly scalable and easier to maintain.

**Key Technologies Used:**
- **Framework:** Flutter 3.x (Material 3)
- **State Management:** `flutter_riverpod` (In-memory mock data, reactive UI updates)
- **Routing:** `go_router` (Declarative routing, deep linking, nested navigation)
- **Typography:** `google_fonts` (Inter font)

---

## 📂 Folder Structure Breakdown

All application code lives inside the `lib/` directory.

### 1. `lib/core/`
Contains the foundational elements of the app that don't belong to any specific feature but are used everywhere.
- **`core/theme/`**: The visual design system. Contains colors, text styles, and global Material Theme configurations to ensure the app matches your Figma designs.
- **`core/router/`**: Navigation logic. Contains `app_router.dart` which defines all the routes (URLs/paths) using `go_router`, role-based nested navigation (ShellRoutes for bottom nav bars), and redirection rules.

### 2. `lib/data/`
Handles all data representation and storage (currently local/mocked, but ready for a backend).
- **`data/models/`**: Contains the data classes (e.g., `Student`, `Club`, `MembershipRequest`, `Notice`). These classes define what data looks like.
- **`mock_data.dart`**: Contains the hardcoded seed data used to populate the application (5 seeded clubs, members, fake HR data) so the app looks complete and interactive without a real server.

### 3. `lib/providers/`
Contains the global state management logic using Riverpod.
- Includes files that hold the application state (e.g., auth state, list of clubs, list of pending applications). When these providers update, the UI automatically rebuilds to reflect the latest data (like when an Admin approves a member).

### 4. `lib/widgets/`
The shared UI component library. Any widget used across multiple features lives here to keep the code DRY (Don't Repeat Yourself).
- Contains highly reusable, Figma-matched components like `AppTextField` (inputs), `buttons.dart` (primary/secondary buttons), `StatCard`, `StatusBadge`, and the global `BottomNavBar`.

### 5. `lib/features/`
The heart of the application. This is split into the distinct user roles and domains.

#### `features/auth/`
- Contains shared authentication flows like the Splash Screen and the Role Selection screen (where a user picks Student, Club Admin, or HR).

#### `features/student/`
- Contains everything a Student sees.
- `student_login_screen.dart` & `student_register_screen.dart`
- `student_dashboard.dart`: The home screen showing active clubs and pending applications.
- `all_clubs_screen.dart`: The directory to search and filter all university clubs.
- `club_details_screen.dart`: The scrollable screen showing club info and the "Request to Join" flow.
- `student_profile_screen.dart` & application history tracking.

#### `features/admin/`
- Contains the portal for Club Admins (Presidents, VPs, etc.).
- Admin auth screens.
- `admin_dashboard.dart`: Quick actions and stats for managing their specific club.
- `admin_requests_screen.dart`: Approving/Declining new member requests.
- Screens for managing current members, posting notices, and updating the club profile.

#### `features/hr/`
- Contains the administrative dashboard for the University HR/Registrar Office.
- HR auth screens.
- `hr_dashboard.dart`: Overview of all registered clubs and pending admin approvals.
- `hr_admin_approvals_screen.dart`: Where HR verifies and approves a student to become a Club Admin.
- `hr_club_information_screen.dart`: Detailed view of a club's budget, executive committee, and activities.

---

## 🚀 How Data Flows (No Backend Yet)

Because we wanted the app to be fully interactive without a backend, we used **Riverpod Providers** acting as an in-memory database:
1. When you approve a student on the **Admin Requests** screen, the Admin screen calls a method on a Provider.
2. The Provider updates the status of that `MembershipRequest` object in `mock_data.dart` in memory.
3. The **Student Dashboard** listens to that same Provider. Because the state changed, the Student Dashboard immediately and automatically rebuilds to show the green "Approved" badge instead of "Pending".

If you eventually connect this to Firebase or a REST API, you will simply replace the logic inside the `lib/providers/` files to talk to the network instead of modifying local mock data. The UI screens (`lib/features/`) will barely need to change!
