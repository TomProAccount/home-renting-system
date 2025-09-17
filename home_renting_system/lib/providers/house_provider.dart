import 'package:flutter/material.dart';
import '../models/house.dart';
import '../repositories/house_repository.dart';

class HouseProvider with ChangeNotifier {
  final HouseRepository repository;

  HouseProvider(this.repository);

  List<House> _houses = [];
  bool _isLoading = false;

  List<House> get houses => _houses;
  bool get isLoading => _isLoading;

  void getHousesByOwner(String ownerId) {
    _isLoading = true;
    notifyListeners();

    repository.getHousesByOwner(ownerId).listen((housesData) {
      _houses = housesData;
      _isLoading = false;
      notifyListeners();
    });
  }

  void getAllHouses() {
    _isLoading = true;
    notifyListeners();

    repository.getAllHouses().listen((housesData) {
      _houses = housesData;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addHouse(House house) async {
    await repository.addHouse(house);
    notifyListeners();
  }

  Future<void> updateHouse(House house) async {
    await repository.updateHouse(house); // repository accepts House
    notifyListeners();
  }

  Future<void> toggleHouseActive(String id, bool currentStatus) async {
    await repository.toggleHouseActive(id, currentStatus);
  }
}