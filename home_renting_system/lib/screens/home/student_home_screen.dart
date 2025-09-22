import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/house_provider.dart';
import '../widgets/house_widget.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {

  @override
  void initState() {
    super.initState();
    // Fetch houses only if the user is logged in
    Future.microtask(() {
      if (FirebaseAuth.instance.currentUser != null) {
        Provider.of<HouseProvider>(context, listen: false).getAllHouses();
      } else {
        print('User is not logged in, skipping Firestore fetch.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final houseProvider = Provider.of<HouseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Provider.of<HouseProvider>(context, listen: false).clearHouses();
                context.go('/'); // <-- redirect after logout
              } catch (e) {
                print('Logout failed: $e');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Welcome, ${user?.email ?? 'Student'}!",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Here are the available properties:",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Expanded list using provider state
          Expanded(
            child: HouseListWidget(
              houses: houseProvider.houses,
              isLoading: houseProvider.isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
