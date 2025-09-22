import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/house.dart';
import '../repositories/house_repository.dart';

class HouseProvider with ChangeNotifier {
  final HouseRepository repository;

  HouseProvider(this.repository);

  List<House> _houses = [];
  bool _isLoading = false;

  List<House> get houses => _houses;
  bool get isLoading => _isLoading;

  // Clear houses when user logs out
  void clearHouses() {
    _houses = [];
    _isLoading = false;
    notifyListeners();
  }

  // Safe fetch by owner
  void getHousesByOwner(String ownerId) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No logged-in user, skipping Firestore fetch');
      _houses = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    repository.getHousesByOwner(ownerId).listen((housesData) {
      _houses = housesData;
      _isLoading = false;
      notifyListeners();
    });
  }

  // Safe fetch all houses
  void getAllHouses() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No logged-in user, skipping Firestore fetch');
      _houses = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    repository.getAllHouses().listen((housesData) {
      _houses = housesData;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addHouse(House house) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // prevent permission error

    await repository.addHouse(house);
    notifyListeners();
  }

  Future<void> updateHouse(House house) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await repository.updateHouse(house);
    notifyListeners();
  }

  Future<void> toggleHouseActive(String id, bool currentStatus) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await repository.toggleHouseActive(id, currentStatus);

    int index = _houses.indexWhere((h) => h.id == id);
    if (index != -1) {
      _houses[index] = House(
        id: _houses[index].id,
        title: _houses[index].title,
        type: _houses[index].type,
        size: _houses[index].size,
        price: _houses[index].price,
        internet: _houses[index].internet,
        ownerId: _houses[index].ownerId,
        createdAt: _houses[index].createdAt,
        isActive: !currentStatus,
      );
      notifyListeners();
    }
  }
}
