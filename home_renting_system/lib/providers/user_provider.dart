import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  Future<void> saveUser({
    required String uid,
    required String email,
    required String role,
  }) async {
    await _userRepository.saveUserData(
      uid: uid,
      email: email,
      role: role,
    );
  }

  Future<String?> fetchUserRole(String uid) async {
    return await _userRepository.getUserRole(uid);
  }
}
