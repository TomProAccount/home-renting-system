import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  User? _currentUser;
  User? get currentUser => _currentUser;

  /// Save user data to Firestore
  Future<void> saveUser(User user) async {
    await _userRepository.saveUserData(user);
    _currentUser = user;
    notifyListeners();
  }

  /// Fetch user by UID
  Future<void> fetchUser(String uid) async {
    final user = await _userRepository.getUserById(uid);
    _currentUser = user;
    notifyListeners();
  }

  /// Fetch role quickly if needed
  Future<String?> fetchUserRole(String uid) async {
    return await _userRepository.getUserRole(uid);
  }
}
