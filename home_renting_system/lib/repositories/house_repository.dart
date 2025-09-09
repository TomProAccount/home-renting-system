import 'package:cloud_firestore/cloud_firestore.dart';

class HouseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getHousesByOwner(String ownerId) {
    return _firestore
        .collection('houses')
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addHouse(String ownerId, Map<String, dynamic> data) async {
    await _firestore.collection('houses').add({
      ...data,
      'ownerId': ownerId,
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateHouse(String houseId, Map<String, dynamic> data) async {
    await _firestore.collection('houses').doc(houseId).update(data);
  }

  Future<void> toggleHouseActive(String houseId, bool currentState) async {
    await _firestore.collection('houses').doc(houseId).update({
      'isActive': !currentState,
    });
  }
}
