import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/house.dart';

class HouseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<House>> getHousesByOwner(String ownerId) {
    return _firestore
        .collection('houses')
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => House.fromMap(doc.data(), doc.id)).toList());
  }

  Stream<List<House>> getAllHouses() {
    return _firestore
        .collection('houses')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => House.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addHouse(House house) async {
    await _firestore.collection('houses').add({
      ...house.toMap(),
      'ownerId': house.ownerId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateHouse(House house) async {
    await _firestore.collection('houses').doc(house.id).update(house.toMap());
  }

  Future<void> toggleHouseActive(String id, bool currentStatus) async {
    await _firestore.collection('houses').doc(id).update({'isActive': !currentStatus});
  }
}