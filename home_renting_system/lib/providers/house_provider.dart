import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HouseProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getHousesByOwner(String ownerId) {
    return _firestore
        .collection('houses')
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addHouse(String ownerId, Map<String, dynamic> data) async {
    data['ownerId'] = ownerId;
    data['isActive'] = true;
    data['createdAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('houses').add(data);
    notifyListeners();
  }

  Future<void> updateHouse(String id, Map<String, dynamic> data) async {
    await _firestore.collection('houses').doc(id).update(data);
    notifyListeners();
  }

  Future<void> toggleHouseActive(String id, bool currentStatus) async {
    await _firestore.collection('houses').doc(id).update({'isActive': !currentStatus});
    notifyListeners();
  }
}
