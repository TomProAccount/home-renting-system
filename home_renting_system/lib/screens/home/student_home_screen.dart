import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/auth_screen.dart';
import '../../providers/house_provider.dart';
import 'package:provider/provider.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final houseProvider = Provider.of<HouseProvider>(context);

    // fetch houses when screen loads (for StatelessWidget, do it here)
    if (!houseProvider.isLoading && houseProvider.houses.isEmpty) {
      houseProvider.getAllHouses();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                    (route) => false,
              );
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

          // ✅ Expanded list using provider state
          Expanded(
            child: houseProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : houseProvider.houses.isEmpty
                ? const Center(child: Text('No houses available.'))
                : ListView.builder(
              itemCount: houseProvider.houses.length,
              itemBuilder: (context, index) {
                final house = houseProvider.houses[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(house.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${house.type}'),
                        Text('Size: ${house.size} m²'),
                        Text('Price: \$${house.price}'),
                        Text('Internet: ${house.internet == "none" ? "No" : house.internet}'),
                        Text('Status: ${house.isActive ? "Active" : "Inactive"}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// do a widget!!!!!