import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  final String id;
  final String title;
  final double price;
  final bool isActive;
  final String type;
  final double size;
  final String internet;
  final String? ownerId;
  final DateTime? createdAt;
  final bool furnished;

  House({
    required this.id,
    required this.title,
    required this.price,
    this.isActive = true,
    required this.type,
    required this.size,
    required this.internet,
    this.ownerId,
    this.createdAt,
    this.furnished = false,
  });

  factory House.fromMap(Map<String, dynamic> map, String id) {
    return House(
      id: id,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      type: map['type'] ?? '',
      size: (map['size'] ?? 0).toDouble(),
      internet: map['internet'] ?? 'none',
      ownerId: map['ownerId'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      furnished: map['furnished'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'type': type,
      'size': size,
      'internet': internet,
      'furnished': furnished,
    };
  }
}
