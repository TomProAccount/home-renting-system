import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Screens
import '../authentication/auth_screen.dart';
import 'student_home_screen.dart';
import 'landlord_home_screen.dart';
import 'unauthorized_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()), // 👈 auto-refresh on login/logout
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return const AuthScreen(); // not logged in
        }
        // If logged in, check role
        return FutureBuilder<String?>(
          future: _getUserRole(user.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == 'student') return const StudentHomeScreen();
            if (snapshot.data == 'landlord') return const LandlordHomeScreen();
            return const UnauthorizedScreen();
          },
        );
      },
    ),
    GoRoute(
      path: '/student',
      builder: (context, state) => const StudentHomeScreen(),
      redirect: (context, state) async => await _roleGuard('student'),
    ),
    GoRoute(
      path: '/landlord',
      builder: (context, state) => const LandlordHomeScreen(),
      redirect: (context, state) async => await _roleGuard('landlord'),
    ),
    GoRoute(
      path: '/unauthorized',
      builder: (context, state) => const UnauthorizedScreen(),
    ),
  ],
);

/// Role guard function
Future<String?> _roleGuard(String requiredRole) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return '/'; // Not logged in

  final role = await _getUserRole(user.uid);
  if (role != requiredRole) return '/unauthorized'; // Wrong role
  return null; // Allowed
}

Future<String?> _getUserRole(String uid) async {
  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return doc.data()?['role'] as String?;
}

/// Helper: converts Stream into GoRouterRefreshListenable
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
