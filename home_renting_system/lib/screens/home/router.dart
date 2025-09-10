import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Screens
import '../authentication/auth_screen.dart';
import 'student_home_screen.dart';
import 'landlord_home_screen.dart';
import 'unauthorized_screen.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthScreen(),
    ),
    GoRoute(
      path: '/student',
      builder: (context, state) => StudentHomeScreen(),
      redirect: (context, state) async {
        return await _roleGuard('student');
      },
    ),
    GoRoute(
      path: '/landlord',
      builder: (context, state) => LandlordHomeScreen(),
      redirect: (context, state) async {
        return await _roleGuard('landlord');
      },
    ),
    GoRoute(
      path: '/unauthorized',
      builder: (context, state) => UnauthorizedScreen(),
    ),
  ],
);

/// Role guard function
Future<String?> _roleGuard(String requiredRole) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return '/login'; // Not logged in

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();

  final role = doc.data()?['role'];

  if (role != requiredRole) return '/unauthorized'; // Wrong role
  return null; // ✅ Allowed
}
