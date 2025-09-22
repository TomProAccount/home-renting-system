import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../providers/house_provider.dart';
import '../widgets/house_widget.dart';

class LandlordHomeScreen extends StatefulWidget {
  const LandlordHomeScreen({super.key});

  @override
  State<LandlordHomeScreen> createState() => _LandlordHomeScreenState();
}

class _LandlordHomeScreenState extends State<LandlordHomeScreen> {

  @override
  void initState() {
    super.initState();
    // Safe call to provider after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final houseProvider = Provider.of<HouseProvider>(context, listen: false);
      final user = FirebaseAuth.instance.currentUser!;
      houseProvider.getHousesByOwner(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final houseProvider = Provider.of<HouseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Houses')),
      body: houseProvider.isLoading || houseProvider.houses.isEmpty
          ? HouseListWidget(
        houses: houseProvider.houses,
        isLoading: houseProvider.isLoading,
      )
          : HouseListWidget(
        houses: houseProvider.houses,
        isLoading: false,
      ),
    );
  }
}
